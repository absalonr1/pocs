# https://github.com/hazelcast/hazelcast-code-samples/tree/master/hazelcast-integration/kubernetes/samples/external-client

# https://github.com/hazelcast/charts/tree/master/stable/hazelcast
$ helm repo add hazelcast https://hazelcast-charts.s3.amazonaws.com/
$ helm repo update
$ helm install my-release hazelcast/hazelcast
        NAME: my-release
        LAST DEPLOYED: Thu Sep 24 15:56:07 2020
        NAMESPACE: default
        STATUS: deployed
        REVISION: 1
        NOTES:
        ** Hazelcast cluster is being deployed! **

        -------------------------------------------------------------------------------

        To access Hazelcast within the Kubernetes cluster:

        - Use Hazelcast Client with Kubernetes Discovery Strategy. Read more at: https://github.com/hazelcast/hazelcast-kubernetes.

        -------------------------------------------------------------------------------

        To access Hazelcast from outside the Kubernetes cluster:

        - Use Hazelcast Client with Smart Routing disabled:
        *) Forward port from POD:
            $ export POD=$(kubectl get pods --namespace default -l "app.kubernetes.io/name=hazelcast,role=hazelcast" -o jsonpath="{.items[0].metadata.name}")
            $ kubectl port-forward --namespace default $POD 5701:5701
        *) In Hazelcast Client configure:
            clientConfig.getNetworkConfig().setSmartRouting(false);
            clientConfig.getNetworkConfig().addAddress("127.0.0.1:5701");

        -------------------------------------------------------------------------------

        To access Hazelcast Management Center:
        *) Check Management Center external IP:
            $ export MANCENTER_IP=$(kubectl get svc --namespace default my-release-hazelcast-mancenter -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
        *) Open Browser at: http://$MANCENTER_IP:8080

# Consola manager
http://{minikube ip}:30148/login.html

# test de headless service
# $ kubectl run tmp-shell --rm -i --tty --image nicolaka/netshoot -- /bin/bash
# $ docker run -it --net container:<container_name> nicolaka/netshoot

        # test del headles
        nslookup my-release-hazelcast.default.svc.cluster.local

                Server:		10.96.0.10
                Address:	10.96.0.10#53

                Name:	my-release-hazelcast.default.svc.cluster.local
                Address: 172.18.0.6
                Name:	my-release-hazelcast.default.svc.cluster.local
                Address: 172.18.0.5
                Name:	my-release-hazelcast.default.svc.cluster.local
                Address: 172.18.0.3


        # test de cada DNS por pod
        nslookup my-release-hazelcast-0.my-release-hazelcast.default.svc.cluster.local

        # test de cada DNS por pod
        nslookup my-release-hazelcast-1.my-release-hazelcast.default.svc.cluster.local

        # test de cada DNS por pod
        nslookup my-release-hazelcast-2.my-release-hazelcast.default.svc.cluster.local

        # svc nodeports
        absalon@pc-absalon:~/git-root/pocs/hazelcast$ kubectl apply -f svc-nodeport-0.yaml 
        absalon@pc-absalon:~/git-root/pocs/hazelcast$ kubectl apply -f svc-nodeport-1.yaml 
        absalon@pc-absalon:~/git-root/pocs/hazelcast$ kubectl apply -f svc-nodeport-2.yaml 

        # test de selectors
        kubectl get pods -l statefulset.kubernetes.io/pod-name=my-release-hazelcast-0
        kubectl get pods -l statefulset.kubernetes.io/pod-name=my-release-hazelcast-1
        kubectl get pods -l statefulset.kubernetes.io/pod-name=my-release-hazelcast-2

# Service de tipo NodePort para bancear los PODs de hazelcast
k apply -f svc-nodeport-test.yaml


# localhost minikube
# ~/git-root/pocs/hazelcast/java.client
rm -rf ./target && \
mvn package && \
export img_name="hazelcast-client-1" && \
docker build -t $img_name .

kubectl apply -f configmap.yaml
kubectl apply -f deployment.yaml

# Entel OKE xxx
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