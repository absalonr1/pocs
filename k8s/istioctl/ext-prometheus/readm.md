
# -----------------------------------------------------------------------------
# 0° instal Helm
# -----------------------------------------------------------------------------

curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh
helm repo add stable https://kubernetes-charts.storage.googleapis.com/

# -----------------------------------------------------------------------------
# 1° Install prometheus
# -----------------------------------------------------------------------------

# https://github.com/helm/charts/tree/master/stable/prometheus-operator
helm install prometheus stable/prometheus-operator

kubectl port-forward deployment/prometheus-grafana 3000
kubectl port-forward pod/prometheus-prometheus-prometheus-oper-prometheus-0 9090

# -----------------------------------------------------------------------------
# 2° Modificar prometheus
# -----------------------------------------------------------------------------

# POD de ejemplo para verificar monitoreo
# ... situarse en directorio correspondiente
kubectl create namespace istio-demo
kubectl label namespace istio-demo istio-injection=enabled
kubectl apply -f deployment-2.yml -n istio-demo
kubectl apply -f svc-2.yaml  -n istio-demo
curl http://$(minikube ip):30080

# -----------------------------------------------------------------------------
# 3° Install istio (modificado con lo minimo. sin kiali, prometheus, etc)
# -----------------------------------------------------------------------------

istioctl install --set values.global.jwtPolicy=first-party-jwt -f dump-demo-profile-mod.yaml

# Habiliar NS y PODs especificos
...

# Likewise, not every Kubernetes namespace we have needed to have sidecars injected into them, so we limited the namespaces that could have a sidecar by adding the following label to istio-enabled namespaces:
istio-injection: "enabled"

# With these two pieces in place, we were able to roll out Istio on an application by application basis by adding the following annotation to pods:

sidecar.istio.io/inject: "true"

# -----------------------------------------------------------------------------
# 4° Install Kiali
# -----------------------------------------------------------------------------

helm install \
--namespace istio-system \
--set auth.strategy="anonymous" \
--repo https://kiali.org/helm-charts \
kiali-server \
kiali-server


# 4.1 Desinstalar kiali
helm uninstall --namespace istio-system kiali-server
kubectl delete crd monitoringdashboards.monitoring.kiali.io

#  Acceder a la UI de Kiali
istioctl dashboard kiali

# No inyectar istio en PODs como NGIX u otros que no se requiere