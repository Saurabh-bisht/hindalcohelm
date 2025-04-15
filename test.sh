kubectl create namespace haproxy-controller

helm repo add haproxytech https://haproxytech.github.io/helm-charts
helm repo update

helm install haproxy-ingress haproxytech/kubernetes-ingress \
  --namespace haproxy-controller \
  --set controller.service.type=LoadBalancer \
  --set controller.replicaCount=2 \
  --set defaultBackend.enabled=false