package com.sts;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

@SpringBootApplication
@EnableScheduling
public class StepUpStylesApplication {

	public static void main(String[] args) {
		SpringApplication.run(StepUpStylesApplication.class, args);
	}

}
