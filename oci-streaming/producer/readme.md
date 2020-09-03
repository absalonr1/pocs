java -jar poc-producer-0.0.1-SNAPSHOT-jar-with-dependencies.jar
 2010  #docker build -t test-producer .
 2011  cd ..
 docker build -t test-producer-env-var .
 docker run test-producer
 docker save --output test-producer-export.tar test-producer

docker login iad.ocir.io 

user: tdecloud/oracleidentitycloudservice/SCACEVEDO@entel.cl 

pass: {WR+4gTHwaT#zWbrWKjz 


docker build -t test-producer-env-var .

docker tag test-producer-env-var iad.ocir.io/tdecloud/tdecloud_repository/test-producer-env-var:1

docker push iad.ocir.io/tdecloud/tdecloud_repository/test-producer-env-var:1