npm install
npm start 
docker build -t nodejs-server .

kubectl apply -f manifest.yml

# get one of the pod ip
kubectl get po -o wide
# run the busybox
kubectl run busybox --image=busybox -it --restart=Never -- /bin/sh

# shell
wget 172.18.0.3:3000

# cat index.html
 cat index.html

kubectl apply -f sample-service.yaml

minikube service nodejs-api-svc --url

curl $(minikube service nodejs-api-svc --url)

# ... ahora el Ingress
kubectl apply -f sample-ingress-res.yaml

curl --resolve microbot.minikube.io:$(minikube ip) https://microbot.minikube.io --insecure  
