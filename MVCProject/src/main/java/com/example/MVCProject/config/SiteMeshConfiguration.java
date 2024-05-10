package com.example.MVCProject.config;

import org.sitemesh.builder.SiteMeshFilterBuilder;
import org.sitemesh.config.ConfigurableSiteMeshFilter;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class SiteMeshConfiguration extends ConfigurableSiteMeshFilter {

	@Bean
	public FilterRegistrationBean<SiteMeshConfiguration> siteMeshFilter() {

		FilterRegistrationBean<SiteMeshConfiguration> filter = new FilterRegistrationBean<SiteMeshConfiguration>();
		filter.setFilter(new SiteMeshConfiguration());

		return filter;

	} 
	
	@Override
	protected void applyCustomConfiguration(SiteMeshFilterBuilder builder) { 
		builder
		// Map decorators to path patterns. 
                .addDecoratorPath("/*", 	"/WEB-INF/views/common/Common.jsp")
                // Exclude path from decoration.
                .addExcludedPath("/html/*")
                .addExcludedPath(".json")
                .addExcludedPath(".css")
                .setMimeTypes("text/html");
	}

}