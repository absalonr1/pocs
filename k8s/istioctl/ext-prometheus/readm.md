# Verison de k8s en Rancher entel: Kubernetes Version: v1.16.8
# k8s version en minikube: Preparing Kubernetes v1.18.3 on Docker 19.03.2

# -----------------------------------------------------------------------------
# 0° instal Helm e istioctl
# -----------------------------------------------------------------------------

curl -L https://istio.io/downloadIstio | sh -
sudo mv ./istio-1.7.0/istioctl /usr/local/bin/

curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh
helm repo add stable https://kubernetes-charts.storage.googleapis.com/

# -----------------------------------------------------------------------------
# 1° Install prometheus
# -----------------------------------------------------------------------------

# [OPCIONAL]
kubectl create namespace istio-system
kubectl config set-context --current --namespace=istio-system

# https://github.com/helm/charts/tree/master/stable/prometheus-operator / https://github.com/prometheus-operator/prometheus-operator
helm install prometheus stable/prometheus-operator --namespace istio-system

helm get manifest prometheus --namespace istio-system > prometheus-helm-manifest.yaml

kubectl port-forward deployment/prometheus-grafana 3000
kubectl port-forward pod/prometheus-prometheus-prometheus-oper-prometheus-0 9090

# verificar que quedo en el namespace correcto
helm list --namespace istio-system

# -----------------------------------------------------------------------------
# 2° Install istio (modificado con lo minimo. sin kiali, prometheus, etc)
# -----------------------------------------------------------------------------

# [A]
istioctl install -f demo.yaml --set addonComponents.grafana.enabled=false --set addonComponents.prometheus.enabled=false --set addonComponents.tracing.enabled=false --set addonComponents.kiali.enabled=false --set values.global.jwtPolicy=first-party-jwt

# [B]
istioctl install --set profile=default --set addonComponents.grafana.enabled=false --set addonComponents.prometheus.enabled=false --set addonComponents.tracing.enabled=false --set addonComponents.kiali.enabled=false --set values.global.jwtPolicy=first-party-jwt

# [C**] Version 1.70 solo incluye en profile "demo": istio-egressgateway / istio-ingressgateway / istiod
istioctl install --set profile=default --set values.global.jwtPolicy=first-party-jwt

# -----------------------------------------------------------------------------
# 3° Install Kiali
# -----------------------------------------------------------------------------

# [A] https://kiali.io/documentation/latest/installation-guide/
$ kubectl create namespace kiali-operator
$ helm install \
    --set cr.create=true \
    --set cr.namespace=istio-system \
    --namespace kiali-operator \
    --repo https://kiali.org/helm-charts \
    kiali-operator \
    kiali-operator

helm get manifest kiali-operator --namespace kiali-operator > kiali-helm-manifest.yaml
helm get values kiali-operator --all --namespace kiali-operator > kiali-helm-all-values.yaml
kubectl apply -f kiali-custom-cr.yaml -n istio-system --dry-run=client

# [A] uninstall
helm uninstall --namespace kiali-operator kiali-operator
kubectl delete monitoringdashboards.monitoring.kiali.io
kubectl delete kialis.kiali.io

# [A] Kiali UI
# 1.- Obtener el "secret" desde: $ kubectl get serviceaccount kiali-service-account -o yaml
# 2.- Obtener el "token" desde: $ kubectl get secret kiali-service-account-token-dnjbs -o yaml
# 3.- Decode del token (base64) e ingresarlo en la url dada por: $ stioctl dashboard kiali

# ..finalmente: Cannot load the graph: Post "http://prometheus.istio-system:9090/api/v1/query": dial tcp: lookup prometheus.istio-system on 10.96.0.10:53: no such host

# [B]
helm install \
--namespace istio-system \
--set auth.strategy="anonymous" \
--repo https://kiali.org/helm-charts \
kiali-server \
kiali-server

# Uninstall kiali
helm uninstall --namespace istio-system kiali-server
kubectl delete crd monitoringdashboards.monitoring.kiali.io

# acceder al dashboard
istioctl dashboard kiali

# -----------------------------------------------------------------------------
# 4° POD de testing para Grafana y Kiali
# -----------------------------------------------------------------------------

# ... situarse en directorio correspondiente
eval $(minikube docker-env)
docker build -t nodejs-server-2 .

kubectl create namespace istio-demo
kubectl label namespace istio-demo istio-injection=enabled

kubectl apply -f deployment-2.yml -n istio-demo
kubectl apply -f svc-2.yaml  -n istio-demo
QQQ
# Habiliar NS y PODs especificos
...

# Likewise, not every Kubernetes namespace we have needed to have sidecars injected into them, so we limited the namespaces that could have a sidecar by adding the following label to istio-enabled namespaces:
istio-injection: "enabled"

# With these two pieces in place, we were able to roll out Istio on an application by application basis by adding the following annotation to pods:

sidecar.istio.io/inject: "true"




# 4.1 Desinstalar kiali
helm uninstall --namespace istio-system kiali-server
kubectl delete crd monitoringdashboards.monitoring.kiali.io

#  Acceder a la UI de Kiali
istioctl dashboard kiali

# No inyectar istio en PODs como NGIX u otros que no se requiere