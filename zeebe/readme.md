absalon@pc-absalon:~$ helm install zeebe-cluster zeebe/zeebe-cluster
NAME: zeebe-cluster
LAST DEPLOYED: Tue Sep  8 09:54:51 2020
NAMESPACE: default
STATUS: deployed
REVISION: 1
NOTES:
______     ______     ______     ______     ______    
/\___  \   /\  ___\   /\  ___\   /\  == \   /\  ___\   
\/_/  /__  \ \  __\   \ \  __\   \ \  __<   \ \  __\   
  /\_____\  \ \_____\  \ \_____\  \ \_____\  \ \_____\ 
  \/_____/   \/_____/   \/_____/   \/_____/   \/_____/                                                                                                                                      

(zeebe-cluster - 0.0.128)

- Docker Image used for Broker: camunda/zeebe:0.23.4
- Cluster Name: "zeebe-cluster-zeebe"
- ElasticSearch Enabled: true - URL: http://elasticsearch-master:9200
- Kibana Enabled: false
- Prometheus Enabled: false
- Prometheus ServiceMonitor Enabled: false

The Cluster itself is not exposed as a service that means that you can use kubectl port-forward to access the Zeebe cluster from outside Kubernetes:

> kubectl port-forward svc/zeebe-cluster-zeebe-gateway 26500:26500 -n default

Now you can connect your workers and clients to `localhost:26500`

