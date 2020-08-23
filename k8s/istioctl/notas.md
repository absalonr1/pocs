# Istio 1.6 has been tested with these Kubernetes releases: 1.15, 1.16, 1.17, 1.18

# https://istio.io/latest/docs/setup/install/istioctl/
# istioctl install and istioctl manifest apply are exactly the same command. In Istio 1.6, the simpler install command replaces manifest apply, which is deprecated and will be removed in 1.7.
istioctl manifest apply

# default	, demo	, minimal	,remote
# https://istio.io/latest/docs/setup/additional-setup/config-profiles/
istioctl install --set profile=demo --set values.global.jwtPolicy=first-party-jwt

istioctl install --set profile=default --set addonComponents.kiali.enabled=true
istioctl install --set addonComponents.kiali.enabled=false

# configuracion de un profile en particular
istioctl profile dump demo

istioctl profile list

# install a partir de un "dump" modificado
istioctl install -f {dump-file}

# para minikube (solo soporta first-party-jwt)
istioctl install --set values.global.jwtPolicy=first-party-jwt -f {dump-file}

# YAML de instalacion istio nativos de kubernetes
istioctl manifest generate -f {dump-file} 
istioctl manifest generate -f {dump-file} --set values.global.jwtPolicy=first-party-jwt 
istioctl manifest generate -f {dump-file} --set values.global.jwtPolicy=first-party-jwt > output.yaml


# [Remotely Accessing Telemetry Addons] https://istio.io/latest/docs/tasks/observability/gateways/


# Genera proxy locla par aacceder a consola (UIs) de istio
istioctl dashboard kiali

# metricas sobre PODs de control plane de istio
istioctl dashboard controlz istiod-bf8cd4cfc-9cl6q.istio-system

# dashboard envoy
istioctl dashboard envoy vehicle-telemetry-649bb8c5c-tf8kf.defaul

# dashboard grafana
istioctl dashboard grafana

# SETUP
istioctl install --set profile=default --set addonComponents.kiali.enabled=true
istioctl install -f demo.yaml --set addonComponents.grafana.enabled=false --set addonComponents.prometheus.enabled=false --set addonComponents.tracing.enabled=false --set addonComponents.kiali.enabled=false --set values.global.jwtPolicy=first-party-jwt

# reomver grafana
- Pruning removed resources                                                                                                                             Pruned object Deployment:istio-system:grafana.
  Pruned object Service:istio-system:grafana.
  Pruned object ConfigMap:istio-system:istio-grafana.
  Pruned object ConfigMap:istio-system:istio-grafana-configuration-dashboards-istio-mesh-dashboard.
  Pruned object ConfigMap:istio-system:istio-grafana-configuration-dashboards-istio-performance-dashboard.
  Pruned object ConfigMap:istio-system:istio-grafana-configuration-dashboards-istio-service-dashboard.
  Pruned object ConfigMap:istio-system:istio-grafana-configuration-dashboards-istio-workload-dashboard.
  Pruned object ConfigMap:istio-system:istio-grafana-configuration-dashboards-mixer-dashboard.
  Pruned object ConfigMap:istio-system:istio-grafana-configuration-dashboards-pilot-dashboard.
  Pruned object PeerAuthentication:istio-system:grafana-ports-mtls-disabled.

# remover prometheus

  - Pruning removed resources                                                                                                                             Pruned object Deployment:istio-system:prometheus.
  Pruned object Service:istio-system:prometheus.
  Pruned object ConfigMap:istio-system:prometheus.
  Pruned object ServiceAccount:istio-system:prometheus.
  Pruned object ClusterRole::prometheus-istio-system.
  Pruned object ClusterRoleBinding::prometheus-istio-system.

# remover tracing
  - Pruning removed resources                                                                                                                             Pruned object Deployment:istio-system:istio-tracing.
  Pruned object Service:istio-system:jaeger-agent.
  Pruned object Service:istio-system:jaeger-collector.
  Pruned object Service:istio-system:jaeger-collector-headless.
  Pruned object Service:istio-system:jaeger-query.
  Pruned object Service:istio-system:tracing.
  Pruned object Service:istio-system:zipkin.

  # remover kiali
  - Pruning removed resources                                                                                                                             Pruned object Deployment:istio-system:kiali.
  Pruned object Service:istio-system:kiali.
  Pruned object ConfigMap:istio-system:kiali.
  Pruned object Secret:istio-system:kiali.
  Pruned object ServiceAccount:istio-system:kiali-service-account.
  Pruned object ClusterRole::kiali.
  Pruned object ClusterRole::kiali-viewer.
  Pruned object ClusterRoleBinding::kiali.
✔ Installation complete                    


# --------------------------------

# Uninstall Istio
# To uninstall Istio, run the following command:

istioctl manifest generate <your original installation options> | kubectl delete -f -

# Real
# (1)
istioctl manifest generate -f demo.yaml > manifest_demo_rancher.yaml
# (2)
kubectl delete -f 5-application-no-istio.yaml


# The control plane namespace (e.g., istio-system) is not removed by default. If no longer needed, use the following command to remove it:

$ kubectl delete namespace istio-system