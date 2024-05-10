package com.example.MVCProject.mapper;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface RiotMapper {
	public String getApiKey();
	
	public String getApiUrl(String code);
}
