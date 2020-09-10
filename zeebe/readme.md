https://github.com/zeebe-io/zeebe-docker-compose

Profile: simple-monitor - a single node Zeebe broker with Simple Monitor

$ docker-compose up

Install zbctl
  chmod +x
  mover a /usr/local/bin

/git-root/pocs/zeebe/src/main/resources$ zbctl deploy order-process.bpmn --insecure

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

zbctl create instance order-process --variables "{\"emergencyReason\" : \"person\"}" --insecure

{
  "workflowKey": 2251799813685249,
  "bpmnProcessId": "order-process",
  "version": 1,
  "workflowInstanceKey": 2251799813685251
}


https://zeebe.io/blog/2019/10/0.21-release/#tls
export ZEEBE_INSECURE_CONNECTION=true

mvn spring-boot:run

~/git-root/pocs/zeebe/simple-monitor-cluster/simple-monitor$ docker-compose down