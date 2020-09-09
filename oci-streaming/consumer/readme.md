rm -rf ./target && \
mvn package && \
export img_name="test-consumer-env-var" && \
export img_v="7" && \
docker build -t $img_name .  && \
docker tag test-consumer-env-var iad.ocir.io/tdecloud/tdecloud_repository/$img_name:$img_v  && \
docker push iad.ocir.io/tdecloud/tdecloud_repository/$img_name:$img_v
kubectl config use-context pocrkechl
kubectl delete pod test-consumer-pod
kubectl delete cm consumer-cm
kubectl apply -f configmap.yaml
kubectl apply -f pod.v2.yaml