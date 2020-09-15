# ---------------
# ----- 1 -------
# ---------------
https://github.com/zeebe-io/zeebe-docker-compose

Profile: simple-monitor - a single node Zeebe broker with Simple Monitor

# ---------------
# ----- 2 -------
# ---------------


$ docker-compose up

# OPTIONAL
#  --build                    Build images before starting containers.
#  --force-recreate           Recreate containers even if their configuration  and image haven't changed.
docker-compose up --build --force-recreate worker


# ---------------
# ----- 3-------
# ---------------

Install zbctl
  chmod +x
  mover a /usr/local/bin

# ---------------
# ----- 4 -------
# ---------------

zbctl deploy $HOME/git-root/pocs/zeebe/src/main/resources/order-process.bpmn --insecure

{
  "key": 2251799813685250,
  "workflows": [
    {
      "bpmnProcessId": "order-process",
      "version": 1,
      "workflowKey": 2251799813685249,
      "resourceName": "order-process.bpmn"
    }
  ]
}

# ---------------
# ----- 5 -------
# ---------------

zbctl create instance order-process --variables "{\"emergencyReason\" : \"person\"}" --insecure

{
  "workflowKey": 2251799813685249,
  "bpmnProcessId": "order-process",
  "version": 1,
  "workflowInstanceKey": 2251799813685251
}

# ---------------
# ----- 6 -------
# ---------------

https://zeebe.io/blog/2019/10/0.21-release/#tls
$ export ZEEBE_INSECURE_CONNECTION=true
$ cd /home/absalon/git-root/pocs/zeebe-demo-worker/
$ mvn spring-boot:run


# ---------------
# ----- 7 -------
# ---------------

~/git-root/pocs/zeebe/simple-monitor-cluster/simple-monitor$ docker-compose down

# optional
# v, --volumes           Remove named volumes declared in the 'volumes'
#                        section of the Compose file and anonymous volumes
#                        attached to containers.
docker-compose down -v