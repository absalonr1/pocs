package aopazo.ocistreaming;

import java.util.Properties;
import java.util.Arrays;
import org.apache.kafka.clients.consumer.KafkaConsumer;

import org.apache.kafka.clients.consumer.ConsumerRecords;
import org.apache.kafka.clients.consumer.ConsumerRecord;

public class OCIStreamingConsumer {

   public static void main(String[] args) throws Exception{

      String topicName = "stream-demo";
      
      Properties properties = new Properties();
      properties.put("bootstrap.servers", "cell-1.streaming.us-ashburn-1.oci.oraclecloud.com:9092");
      properties.put("security.protocol", "SASL_SSL");
      properties.put("sasl.mechanism", "PLAIN");
      properties.put("sasl.jaas.config", "org.apache.kafka.common.security.plain.PlainLoginModule required username=\"absalon/oracleidentitycloudservice/luisopazo@gmail.com/ocid1.streampool.oc1.iad.amaaaaaafnixjbyapenbnk4od4gyuzg3jv5j364dd5odnggdkv3f7go75mma\" password=\"719O:pwpCN74s487nKLJ\";");

      properties.put("group.id", "group-0");
      //properties.put("acks", "all");
      properties.put("enable.auto.commit", "true");
      properties.put("auto.commit.interval.ms", "1000");
      properties.put("session.timeout.ms", "30000");
      properties.put("key.deserializer","org.apache.kafka.common.serialization.StringDeserializer");
      properties.put("value.deserializer","org.apache.kafka.common.serialization.StringDeserializer");
      KafkaConsumer<String, String> consumer = null;
      try{
         consumer = new KafkaConsumer<String, String>(properties);

         consumer.subscribe(Arrays.asList(topicName));
         System.out.println("Subscribed to topic " + topicName);
         int i = 0;
         
         System.out.println("Entering while...");
         while (i<100) {
            ConsumerRecords<String, String> records = consumer.poll(1000);
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