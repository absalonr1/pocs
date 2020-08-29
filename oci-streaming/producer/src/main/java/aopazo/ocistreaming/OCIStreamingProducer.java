package aopazo.ocistreaming;

import java.util.Properties;
import org.apache.kafka.clients.producer.Producer;
import org.apache.kafka.clients.producer.KafkaProducer;
import org.apache.kafka.clients.producer.ProducerRecord;

public class OCIStreamingProducer {

   public static void main(String[] args) throws Exception{

      String topicName = "stream-demo";
      
      String tenancyName ="ocid1.tenancy.oc1..aaaaaaaahww27qgv44s5ibdur2pdshfheobg7je6rsawkqwr3wrilff7mn4q";
      String username ="oracleidentitycloudservice/luisopazo@gmail.com";
      String stream_pool_OCID ="ocid1.streampool.oc1.iad.amaaaaaafnixjbyapenbnk4od4gyuzg3jv5j364dd5odnggdkv3f7go75mma";
      String authToken ="719O:pwpCN74s487nKLJ";

      Properties properties = new Properties();
      properties.put("bootstrap.servers", "streaming.us-ashburn-1.oci.oraclecloud.com:9092");
      properties.put("security.protocol", "SASL_SSL");
      properties.put("sasl.mechanism", "PLAIN");
      properties.put("sasl.jaas.config", "org.apache.kafka.common.security.plain.PlainLoginModule required "+
      "username=\""+tenancyName+"/"+username+"/"+stream_pool_OCID+"\" password=\""+authToken+"\";");

      properties.put("key.serializer", 
         "org.apache.kafka.common.serialization.StringSerializer");

      properties.put("value.serializer", 
         "org.apache.kafka.common.serialization.StringSerializer");

      Producer<String, String> producer = new KafkaProducer<String, String>(properties);

      for(int i = 0; i < 10; i++)
         producer.send(new ProducerRecord<String, String>(topicName, 
            Integer.toString(i), Integer.toString(i)));
               System.out.println("Message sent successfully");
               producer.close();
   }
}