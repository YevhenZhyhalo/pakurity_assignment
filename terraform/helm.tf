

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
  set {
    name  = "operator.logDevMode"
    value = "true"
  }
  set {
    name  = "operator.builtInTrivyServer"
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


}
