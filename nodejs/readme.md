# crear la imagen
docker build -t nodejs-server-2 .

# manual istio inyecting
stioctl kube-inject -f deployment-2.yml | kubectl apply -f -