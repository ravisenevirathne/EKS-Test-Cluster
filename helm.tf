

resource "helm_release" "web_server" {
  name       = "web-server"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "nginx"
}


/*

resource "helm_release" "kubernetes-dashboard" {
  name       = "kubernetes-dashboard"
  repository = "https://kubernetes.github.io/dashboard/"
  chart      = "kubernetes-dashboard"
}

*/

//kubectl patch svc kubernetes-dashboard -p '{"spec": {"type": "LoadBalancer"}}'

// kubectl patch svc kubernetes-dashboard -p '{"spec": {"type": "ClusterIP"}}'

// kubectl patch svc kubernetes-dashboard -p '{"spec": {"type": "ClusterIP"}}'