package com.example.MVCProject.config;

import java.util.Base64;
import java.util.HashMap;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.autoconfigure.jdbc.DataSourceProperties;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import com.zaxxer.hikari.HikariDataSource;



@Configuration
@EnableTransactionManagement
public class DataSourceConfiguration {
	
	Logger logger =  LoggerFactory.getLogger(AOPConfiguration.class);
	
	@Bean
    @Primary
    @ConfigurationProperties("spring.datasource")
    public DataSourceProperties dataSourceProperties() {
        return new DataSourceProperties();
    }

    @Bean
    @ConfigurationProperties("spring.datasource.hikari")
    public HikariDataSource dataSource(DataSourceProperties properties) {
    	byte[] encodeBytes_classLoader = Base64.getMimeEncoder().encode(properties.getClassLoader().toString().getBytes());
    	byte[] encodeBytes_driverClassName = Base64.getMimeEncoder().encode(properties.getDriverClassName().toString().getBytes());
    	byte[] encodeBytes_url = Base64.getMimeEncoder().encode(properties.getUrl().toString().getBytes());
    	byte[] encodeBytes_userName = Base64.getMimeEncoder().encode(properties.getUsername().toString().getBytes());
    	byte[] encodeBytes_password = Base64.getMimeEncoder().encode(properties.getPassword().getBytes());
    	
    	String classLoader = new String(encodeBytes_classLoader);
    	String driverClassName = new String(encodeBytes_driverClassName);
    	String url = new String(encodeBytes_url);
    	String userName = new String(encodeBytes_userName);
    	String password = new String(encodeBytes_password);
    	//DB Connection 정보 암호화 작업
    	
    	HashMap<String, String> DBConnectionInfo = new HashMap<String, String>();
    	
    	DBConnectionInfo.put("classLoader", classLoader);
    	DBConnectionInfo.put("driverClassName", driverClassName);
    	DBConnectionInfo.put("url", url);
    	DBConnectionInfo.put("userName", userName);
    	DBConnectionInfo.put("password", password);
    	
    	logger.info("DB Connection Info :" + DBConnectionInfo);
    	
        return properties.initializeDataSourceBuilder().type(HikariDataSource.class).build();
    }
    
}
