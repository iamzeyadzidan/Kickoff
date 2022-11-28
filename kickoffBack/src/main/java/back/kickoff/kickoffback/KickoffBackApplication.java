package back.kickoff.kickoffback;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.RestController;

@RestController
@SpringBootApplication
public class KickoffBackApplication {

	public static void main(String[] args) {
		SpringApplication.run(KickoffBackApplication.class, args);
	}

}
