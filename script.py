

query = """
select id, REGEXP_REPLACE(report,r",","") as report
from(
select
  STRING_AGG(report) AS report,
  id
from(
  SELECT
    `timestamp` as TM,
    resource.labels.pod_name as id,
    textPayload AS report,
  FROM `spheric-shield-451012-u9.Trivy.stdout`
  Order by  TM
)
  GROUP BY id
) where id  LIKE "%scan-vulnerabilityreport%"
"""


##"%scan-vulnerabilityreport-6588565598-r6blk%" "%scan-%"

from google.cloud import bigquery
import base64, bz2,json
import pandas as pd

# Replace with your own JSON file path and BigQuery dataset and table details
project_id = "spheric-shield-451012-u9"
dataset_id = "Trivy"
table_id = "filtered"

destination_table = project_id+"."+dataset_id+"."+table_id

schema = [
    bigquery.SchemaField("scan_id", "STRING", mode="REQUIRED"),
    bigquery.SchemaField("full_json", "JSON", mode="NULLABLE"),
    bigquery.SchemaField("vulnerability", "JSON", mode="NULLABLE"),
]

def query_data():
  client = bigquery.Client()
  # Perform a query
  query_job = client.query(query)  # API request
  rows = query_job.result()  # Waits for query to finish
  return rows

def create_table():
  # Construct a BigQuery client object.
  writer = bigquery.Client()
  table = bigquery.Table(destination_table, schema=schema)
  table = writer.create_table(table)  # Make an API request.
  print(
      "Created table {}.{}.{}".format(table.project, table.dataset_id, table.table_id)
  )

def load_data():
  writer = bigquery.Client(project = project_id)
  dataset = writer.dataset(dataset_id)
  table = dataset.table(table_id)

  rows = query_data()
  df = pd.DataFrame(columns=['scan_id', 'full_json','vulnerability'])
  print(df)

  for row in rows:
      try:
        print(row.id)
        bytes = base64.b64decode(row.report)
        data = bz2.decompress(bytes)
        js = json.loads(data)
        print("before")
        for obj in  js["Results"]:
          for vuln in obj["Vulnerabilities"]:
            ### Create data to load
            new_row = pd.DataFrame([[row.id, js,vuln]],
            columns=['scan_id', 'full_json','vulnerability'])
            df = pd.concat([df, new_row], ignore_index=True)
      except:
        print("error")
  print(df)
  job_config = bigquery.LoadJobConfig()
  job_config.source_format = bigquery.SourceFormat.NEWLINE_DELIMITED_JSON
  job_config.schema = schema
  json_data = df.to_json(orient = 'records')
  json_object = json.loads(json_data)
  job = writer.load_table_from_json(json_object, table, job_config = job_config)
  print(job.result())

load_data()
