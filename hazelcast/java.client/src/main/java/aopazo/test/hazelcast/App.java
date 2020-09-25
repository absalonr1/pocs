package aopazo.test.hazelcast;

import com.hazelcast.client.HazelcastClient;
import com.hazelcast.client.config.*;
import com.hazelcast.core.HazelcastInstance;
import com.hazelcast.map.IMap;

import java.util.concurrent.BlockingQueue;

/**
 * Hello world!
 */
public final class App {
    private App() {
    }

    /**
     * Says hello to the world.
     * 
     * @param args The arguments of the program.
     * @throws Exception
     */
    public static void main(String[] args) throws Exception {
        while(true){
            System.out.println("Hello World! 1");
            //ClientConfig clientConfig = new ClientConfig();
            ClientConfig clientConfig = null;
            try{
                clientConfig = new XmlClientConfigBuilder("/data/hazelcast-conf/hazelcast-client.xml").build();
                System.out.println("Usando configmap");
            }catch(Throwable e){
                e.printStackTrace();
                clientConfig = new ClientConfig();
                System.out.println("Usando valores de conexion por defecto");
                clientConfig.getNetworkConfig().addAddress("172.17.0.3:30010").setSmartRouting(false);
            }
            //clientConfig.getNetworkConfig().addAddress("172.17.0.3:30010").setSmartRouting(false);
            //clientConfig.getNetworkConfig().addAddress("172.17.0.3:30007", "172.17.0.3:30008","172.17.0.3:30009")
            //    .setSmartRouting(true);
                //.setConnectionTimeout(5000);
            //clientConfig.setBackupAckToClientEnabled(true);
            HazelcastInstance client = HazelcastClient.newHazelcastClient(clientConfig);
            System.out.println(clientConfig.toString());

            BlockingQueue<String> queue = client.getQueue("queue");
            queue.put("Hello!");
            System.out.println("Message sent by Hazelcast Client!");

            for (int i = 0; i < 10; i++) {
                IMap<String, String> mapCustomers = client.getMap("customers-"+System.currentTimeMillis()); //creates the map proxy

                mapCustomers.put("1", "Customer 1");
                mapCustomers.put("2", "Customer 2");
                mapCustomers.put("3", "Customer 3");

                System.out.println("IMap ["+i+"] sent to Hazelcast!");
            } 
            HazelcastClient.shutdownAll();
            
            Thread.currentThread().sleep(10000);
            
           
        }
        
        
        
    }
}
