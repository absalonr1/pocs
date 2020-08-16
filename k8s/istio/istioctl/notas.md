# Istio 1.6 has been tested with these Kubernetes releases: 1.15, 1.16, 1.17, 1.18

# https://istio.io/latest/docs/setup/install/istioctl/
# istioctl install and istioctl manifest apply are exactly the same command. In Istio 1.6, the simpler install command replaces manifest apply, which is deprecated and will be removed in 1.7.
./bin/istioctl manifest apply

# default	, demo	, minimal	,remote
# https://istio.io/latest/docs/setup/additional-setup/config-profiles/
./bin/istioctl install --set profile=default

./bin/istioctl install --set profile=default --set addonComponents.kiali.enabled=true
./bin/istioctl install --set addonComponents.kiali.enabled=false

# configuracion de un profile en particular
./bin/istioctl profile dump demo

./bin/istioctl profile list

# install a partir de un "dump" modificado
./bin/istioctl install -f {dump-file}

# para minikube (solo soporta first-party-jwt)
./bin/istioctl install --set values.global.jwtPolicy=first-party-jwt -f {dump-file} 

# YAML de instalacion istio nativos de kubernetes
istioctl manifest generate -f {dump-file} 
istioctl manifest generate -f {dump-file} --set values.global.jwtPolicy=first-party-jwt 
istioctl manifest generate -f {dump-file} --set values.global.jwtPolicy=first-party-jwt > output.yaml


# [Remotely Accessing Telemetry Addons] https://istio.io/latest/docs/tasks/observability/gateways/
