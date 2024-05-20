package docker.estudos;


import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class DockerController {

    @GetMapping("/hellodocker")
    public HelloDocker greeting(){
        var hostName = System.getenv("HOSTNAME");
        var helloDocker = new HelloDocker("Hello Docker", hostName);
        return helloDocker;
    }
}
