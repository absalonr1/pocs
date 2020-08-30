package aopazo.ocistreaming;

import java.util.Properties;
import org.apache.kafka.clients.producer.Producer;
import org.apache.kafka.clients.producer.ProducerConfig;
import org.apache.kafka.clients.producer.KafkaProducer;
import org.apache.kafka.clients.producer.ProducerRecord;

public class OCIStreamingProducer {

   public static void main(String[] args) throws Exception{

      
      String topicName = "stream-demo";
      
      Properties properties = new Properties();
      properties.put(ProducerConfig.ACKS_CONFIG, "all");
      properties.put("bootstrap.servers", "cell-1.streaming.us-ashburn-1.oci.oraclecloud.com:9092");
      properties.put("security.protocol", "SASL_SSL");
      properties.put("sasl.mechanism", "PLAIN");
      properties.put("sasl.jaas.config", "org.apache.kafka.common.security.plain.PlainLoginModule required username=\"absalon/oracleidentitycloudservice/luisopazo@gmail.com/ocid1.streampool.oc1.iad.amaaaaaafnixjbyapenbnk4od4gyuzg3jv5j364dd5odnggdkv3f7go75mma\" password=\"719O:pwpCN74s487nKLJ\";");

      properties.put("key.serializer", 
         "org.apache.kafka.common.serialization.StringSerializer");

      properties.put("value.serializer", 
         "org.apache.kafka.common.serialization.StringSerializer");

      Producer<String, String> producer = new KafkaProducer<String, String>(properties);

      long t1=System.currentTimeMillis();
      int numMsgs = 1000;
      for(int i = 0; i < numMsgs; i++){
         long time = System.currentTimeMillis();
         producer.send(new ProducerRecord<String, String>(topicName, 
         "key-" + i +"-"+time, "message-"+i )
         );
         
      }
      System.out.println(numMsgs+ " messages sent successfully in "+( (System.currentTimeMillis()-t1)/1000 )+" seconds.");
      producer.close();
   }
}