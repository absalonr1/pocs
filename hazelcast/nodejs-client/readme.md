
# (1) 
npn init -y

# (2) install express 
npm i express@4.16.1

# (3)
npm install hazelcast-client

# (4)
eval $(minikube docker-env) && \
docker build -t nodejs-hazelcast-client-1 .


# (5)
kubectl apply -f pod.yaml
kubectl apply -f svc.yaml

# (7)
curl http://$(minikube ip):30083

# -----------------------------------
# (4.1) run locally (no funciona con todo (HZ, Node client) en localhost)
docker run --rm -p 8080:8080 --env PORT=8080 --env HOST="0.0.0.0"  --env HZ_SVC="127.0.0.1:5701" nodejs-hazelcast-client-1
