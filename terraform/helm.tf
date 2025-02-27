

resource "helm_release" "trivy" {
  name             = "trivy-operator"
  repository       = "https://aquasecurity.github.io/helm-charts/"
  chart            = "trivy-operator"
  namespace        = "trivy-system"
  version          = "0.26.0"
  timeout          = 1200
  create_namespace = true
  set {
    name  = "trivy.ignoreUnfixed"
    value = "true"
  }



}


resource "helm_release" "nginx_ingress" {
  name       = "ingress-nginx"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  namespace        = "nginx-ingress"
  timeout          = 1200
  create_namespace = true

  set{
    name = "controller.enableSnippets"
    value = "true"    
  }
    set{
    name = "controller.allowSnippetAnnotations"
    value = "true"    
  }
  set{
    name = "controller.config.annotations-risk-level"
    value = "Critical"    
  }


}

resource "helm_release" "application" {
  name       = "application"
  chart      = "../app/helm"
  create_namespace = true
  namespace        = "app"

}
