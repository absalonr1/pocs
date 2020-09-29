package aopazo.test.hazelcast;

import com.hazelcast.client.HazelcastClient;
import com.hazelcast.client.config.*;
import com.hazelcast.core.HazelcastInstance;
import com.hazelcast.map.IMap;
import com.hazelcast.replicatedmap.ReplicatedMap;

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
            System.out.println("Hello World! 3");
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
            clientConfig.setInstanceName("ExampleClientName");
            clientConfig.addLabel("user");
            clientConfig.addLabel("bar");
            clientConfig.getConnectionStrategyConfig()
                        .setAsyncStart(true)
                        .setReconnectMode(ClientConnectionStrategyConfig.ReconnectMode.ASYNC);
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

            for (int i = 0; i < 2; i++) {
                IMap<String, String> mapCustomers = client.getMap("customers-"+System.currentTimeMillis()); //creates the map proxy
                mapCustomers.put("1", "Customer 1");
                mapCustomers.put("2", "Customer 2");
                mapCustomers.put("3", "Customer 3");
                mapCustomers.put("4", "Customer 4");
                mapCustomers.put("5", "Customer 5");
                //mapCustomers.set

                ReplicatedMap<String, String> map = client.getReplicatedMap("replicated-map-"+System.currentTimeMillis());
                map.put("1", "Tokyo");
                map.put("2", "Paris");
                map.put("3", "New York");
                map.put("4", "Chile");
                map.put("5", "Peru");
    

                System.out.println("IMap ["+i+"] sent to Hazelcast!");
            } 
            HazelcastClient.shutdownAll();
            
            Thread.currentThread().sleep(30000);
            
           
        }
        
        
        
    }
}
