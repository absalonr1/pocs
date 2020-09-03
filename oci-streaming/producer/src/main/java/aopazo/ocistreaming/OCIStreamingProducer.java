package aopazo.ocistreaming;

import java.util.Properties;
import org.apache.kafka.clients.producer.Producer;
import org.apache.kafka.clients.producer.ProducerConfig;
import org.apache.kafka.clients.producer.KafkaProducer;
import org.apache.kafka.clients.producer.ProducerRecord;

public class OCIStreamingProducer {

   public static void main(String[] args) throws Exception{

      /**
       Username: app_microservicios_poc
        Token: GbZfF1-Pc.V-cseMGG5i
         tdecloud/app_microservicios_poc/ocid1.streampool.oc1.iad.amaaaaaa4u3umwqaku3jfqaxmk3vblcuggccfzsyuvap7oxcuubidt7cepoq
       10.12.28.127:9092
         */

      String topicName =  System.getenv("TOPIC_NAME");
      
      Properties properties = new Properties();
      properties.put(ProducerConfig.ACKS_CONFIG, System.getenv("ACKS_CONFIG"));
      properties.put("bootstrap.servers", System.getenv("BOOTSTRAP_SERVER"));
      properties.put("request.timeout.ms", System.getenv("REQUEST_TIMEOUT_MS"));
      properties.put("metadata.fetch.timeout.ms", System.getenv("METADATA_FETCH_TIMEOUT_MS"));
      properties.put("security.protocol", System.getenv("SECURITY_PROTOCOL"));
      properties.put("sasl.mechanism", System.getenv("SASL_MECHANISM"));
      properties.put("sasl.jaas.config", System.getenv("SASL_JAAS_CONFIG"));

      properties.put("key.serializer", 
         "org.apache.kafka.common.serialization.StringSerializer");
      properties.put("value.serializer", 
         "org.apache.kafka.common.serialization.StringSerializer");

      System.out.println("Configuracion: "+properties);
      System.out.println("topicName: "+topicName);
      Producer<String, String> producer = new KafkaProducer<String, String>(properties);

      long t1=System.currentTimeMillis();
      int numMsgs = Integer.valueOf(System.getenv("NUM_MSG"));

      System.out.println("Entering 'for'");
      for(int i = 0; i < numMsgs; i++){
         //System.out.println("Iteration : "+i);
         long time = System.currentTimeMillis();
         producer.send(new ProducerRecord<String, String>(topicName,"key-" + i +"-"+time, "message-"+i ));
         //System.out.println(( (System.currentTimeMillis()-time)/1000 )+" seconds.");
      }
      System.out.println(numMsgs+ " messages sent successfully in "+( (System.currentTimeMillis()-t1)/1000 )+" seconds.");
      producer.close();
   }
}