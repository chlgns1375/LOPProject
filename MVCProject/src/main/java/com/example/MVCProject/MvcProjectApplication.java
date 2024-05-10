package com.example.MVCProject;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.boot.web.servlet.ServletComponentScan;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.EnableAspectJAutoProxy;

import com.example.MVCProject.config.SiteMeshConfiguration;

@ServletComponentScan
@EnableAspectJAutoProxy
@SpringBootApplication
public class MvcProjectApplication{

	public static void main(String[] args) {
		SpringApplication.run(MvcProjectApplication.class, args);
	}
}
