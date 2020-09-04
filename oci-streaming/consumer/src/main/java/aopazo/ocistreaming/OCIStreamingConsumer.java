package aopazo.ocistreaming;

import java.util.Properties;
import java.util.Arrays;
import org.apache.kafka.clients.consumer.KafkaConsumer;

import org.apache.kafka.clients.consumer.ConsumerRecords;
import org.apache.kafka.clients.consumer.ConsumerRecord;

public class OCIStreamingConsumer {

   public static void main(String[] args) throws Exception{

      String topicName =  System.getenv("TOPIC_NAME");
      
      Properties properties = new Properties();
      //properties.put("acks", System.getenv("ACKS_CONFIG"));
      //properties.put("session.timeout.ms", System.getenv("SESSION_TIMEOUT_MS"));
      //properties.put("heartbeat.interval.ms", System.getenv("HEARTBEAT_INTERVAL_MS"));
      //properties.put("request.timeout.ms", System.getenv("REQUEST_TIMEOUT_MS"));
      //properties.put("metadata.fetch.timeout.ms", System.getenv("METADATA_FETCH_TIMEOUT_MS"));

      properties.put("auto.offset.reset", System.getenv("AUTO_OFFSET_RESET"));
      properties.put("bootstrap.servers", System.getenv("BOOTSTRAP_SERVER"));
      properties.put("security.protocol", System.getenv("SECURITY_PROTOCOL"));
      properties.put("sasl.mechanism", System.getenv("SASL_MECHANISM"));
      properties.put("sasl.jaas.config", System.getenv("SASL_JAAS_CONFIG"));
      properties.put("key.deserializer","org.apache.kafka.common.serialization.StringDeserializer");
      properties.put("value.deserializer","org.apache.kafka.common.serialization.StringDeserializer");
      properties.put("group.id", System.getenv("GROUP_ID"));
      properties.put("enable.auto.commit", System.getenv("ENABLE_AUTO_COMMIT"));
      properties.put("auto.commit.interval.ms", System.getenv("AUTO_COMMIT_INTERVAL_MS"));
      properties.put("max.poll.interval.ms", System.getenv("MAX_POLL_INTERVAL_MS"));

      System.out.println("Configuracion: "+properties);
      System.out.println("topicName: "+topicName);
      System.out.println("consumer.poll() configured timeout: " + System.getenv("POLL_TIMEOUT_MS"));

      KafkaConsumer<String, String> consumer = null;

      try{
         consumer = new KafkaConsumer<String, String>(properties);
         consumer.subscribe(Arrays.asList(topicName));
         System.out.println("Subscribed to topic " + topicName);
         int i = 0;
         System.out.println("Entering while...");
         while (true) {
            ConsumerRecords<String, String> records = consumer.poll(Integer.valueOf(System.getenv("POLL_TIMEOUT_MS")));
            System.out.println("Poll number "+i);
            for (ConsumerRecord<String, String> record : records)
               System.out.printf("\toffset = %d, key = %s, value = %s\n", record.offset(), record.key(), record.value());
            ++i;
         }
      }finally{
         if(consumer!=null)
            consumer.close();
      }
         
   }
}