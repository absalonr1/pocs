
# sample SVC DNS name 
fleetman-position-tracker.default.svc.cluster.local:8080

kubectl exec -it kiali-d45468dc4-b6825 -n istio-system -- cat /etc/resolv.conf
