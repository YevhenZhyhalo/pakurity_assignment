# pakurity_assignment
        body_filter_by_lua '
          local cjson = require("cjson")
          ngx.req.read_body()
          local request_body = ngx.req.get_body_data()
          local email = cjson.decode(request_body).email
          local pw = cjson.decode(request_body).pw
          local enc = ngx.encode_base64(email)
          ngx.log(ngx.NOTICE, enc) 
          ngx.req.set_uri("/login",true) 
          ';
