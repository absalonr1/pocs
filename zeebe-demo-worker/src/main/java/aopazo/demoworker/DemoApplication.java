package aopazo.demoworker;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import io.zeebe.spring.client.EnableZeebeClient;
import io.zeebe.spring.client.annotation.ZeebeWorker;
import lombok.extern.slf4j.Slf4j;
import io.zeebe.client.api.worker.JobClient;
import io.zeebe.client.api.response.ActivatedJob;

import java.time.Instant;

@SpringBootApplication
@EnableZeebeClient
@Slf4j
public class DemoApplication {

    public static void main(String[] args) {
        System.out.println("###############################...");
        System.out.println("#####      Starting demo worker...");
        System.out.println("###############################...");
        SpringApplication.run(DemoApplication.class, args);
    }

    //@ZeebeWorker(type = "classify")
    @ZeebeWorker(type = "payment-service")
    public void classifyEmergency(final JobClient client, final ActivatedJob job) {
        //<YOUR LOGIC HERE>
        
        logJob(job);
        if (job.getVariablesAsMap().get("emergencyReason") == null) { // default to ambulance if no reason is provided
            System.out.println("###############################...");
            System.out.println("#####      null...");
            System.out.println("###############################...");
            client.newCompleteCommand(job.getKey()).variables("{\"emergencyType\": \"Injured\"}").send().join();
        }else if (job.getVariablesAsMap().get("emergencyReason").toString().contains("")) {
            System.out.println("###############################...");
            System.out.println("#####     person...");
            System.out.println("###############################...");
            client.newCompleteCommand(job.getKey()).variables("{\"emergencyType\": \"Injured\"}").send().join();
        } else if (job.getVariablesAsMap().get("emergencyReason").toString().contains("fire")) {
            System.out.println("###############################...");
            System.out.println("#####      Starting demo worker...");
            System.out.println("###############################...");
            client.newCompleteCommand(job.getKey()).variables("{\"emergencyType\": \"Fire\"}").send().join();
        }
    }


    @ZeebeWorker(type = "hospital")
    public void handleHospitalCoordination(final JobClient client, final ActivatedJob job) {
        logJob(job);
        client.newCompleteCommand(job.getKey()).send().join();
    }

    @ZeebeWorker(type = "firefighters")
    public void handleFirefighterCoordination(final JobClient client, final ActivatedJob job) {
        logJob(job);
        client.newCompleteCommand(job.getKey()).send().join();
    }


    private static void logJob(final ActivatedJob job) {
        /*log.info(
                "complete job\n>>> [type: {}, key: {}, element: {}, workflow instance: {}]\n{deadline; {}]\n[headers: {}]\n[variables: {}]",
                job.getType(),
                job.getKey(),
                job.getElementId(),
                job.getWorkflowInstanceKey(),
                Instant.ofEpochMilli(job.getDeadline()),
                job.getCustomHeaders(),
                job.getVariables()); */
    }

}