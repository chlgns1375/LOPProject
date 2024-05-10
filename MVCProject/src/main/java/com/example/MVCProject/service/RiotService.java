package com.example.MVCProject.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

public interface RiotService {
	
	public String getApiKey() throws Exception;
	
	public HashMap<String, Object> getPuuidApiUrl(HashMap<String, Object> objMap) throws Exception;
	
	public HashMap<String, Object> getAccountInfoApiUrl(HashMap<String, Object> objMap) throws Exception;
	
	public ArrayList<String> getMatchIdListUrl(HashMap<String, Object> objMap) throws Exception;
	
	public HashMap<String, Object> getMatchInfoUrl(HashMap<String, Object> objMap, ArrayList<String> matchIdList) throws Exception;
	
	public ArrayList<Object>  getrecordInfoUrl(HashMap<String, Object> objMap) throws Exception;
	
}
