package com.example.MVCProject.serviceimpl;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.MVCProject.config.AOPConfiguration;
import com.example.MVCProject.mapper.RiotMapper;
import com.example.MVCProject.service.RiotService;


@Service
public class RiotServiceImpl implements RiotService{

	@Autowired
	private RiotMapper riotMapper;
	
	Logger logger =  LoggerFactory.getLogger(RiotServiceImpl.class);
	
	BufferedReader in = null;
	StringBuffer sb = null;
	HttpURLConnection con = null;
	
	@Override
	public String getApiKey() throws Exception {
		
		return riotMapper.getApiKey();
	}

	@Override
	public HashMap<String, Object> getPuuidApiUrl(HashMap<String, Object> objMap) throws Exception {
	
		HashMap<String, Object> returnMap = new HashMap<String, Object>();
		try {
			String puuidCode = (String)objMap.get("code");
			String urlStr = riotMapper.getApiUrl(puuidCode) + objMap.get("nickName") + "/" + objMap.get("tagName") + "?api_key=" + objMap.get("apiKey");
			
			logger.info("Riot API URL : " + urlStr);
			
			URL url = new URL(urlStr);
			
			con = (HttpURLConnection)url.openConnection();
			con.setRequestMethod("GET");
			in = new BufferedReader(new InputStreamReader(con.getInputStream(), "UTF-8"));
			String line;
			sb = new StringBuffer();
			while((line = in.readLine()) != null) { // response를 차례대로 출력
				sb.append(line);
			}
			line = sb.toString();
			
			returnMap = new ObjectMapper().readValue(line, new TypeReference<HashMap<String, Object>>(){});
			
		} catch(Exception e) {
			throw e;
		} finally {
			con.disconnect();
			in.close();
			sb.delete(0, sb.length() );
		}
		return returnMap;
	}

	@Override
	public HashMap<String, Object> getAccountInfoApiUrl(HashMap<String, Object> objMap) throws Exception {
		
		HashMap<String, Object> returnMap = new HashMap<String, Object>();
		try {
			String accountInfoCode = (String)objMap.get("code");
			String urlStr = riotMapper.getApiUrl(accountInfoCode) + objMap.get("puuid") + "?api_key=" + objMap.get("apiKey");
			//TODO 페이징처리
			
			logger.info("Riot API URL : " + urlStr);
			
			URL url = new URL(urlStr);
			
			con = (HttpURLConnection)url.openConnection();
			con.setRequestMethod("GET");
			in = new BufferedReader(new InputStreamReader(con.getInputStream(), "UTF-8"));
			String line;
			sb = new StringBuffer();
			while((line = in.readLine()) != null) { // response를 차례대로 출력
				sb.append(line);
			}
			line = sb.toString();
			
			returnMap = new ObjectMapper().readValue(line, new TypeReference<HashMap<String, Object>>(){});
			
		} catch(Exception e) {
			throw e;
		} finally {
			con.disconnect();
			in.close();
			sb.delete(0, sb.length() );
		}
		return returnMap;
	}

	@Override
	public ArrayList<String> getMatchIdListUrl(HashMap<String, Object> objMap) throws Exception {
		
		ArrayList<String> returnList = new ArrayList<String>();
		try {
			String matchIdListCode = (String)objMap.get("code");
			String urlStr = riotMapper.getApiUrl(matchIdListCode) + objMap.get("puuid") + "/ids?api_key=" + objMap.get("apiKey") + "&start=" + 0 + "&end=" + 20;
			
			logger.info("Riot API URL : " + urlStr);
			
			URL url = new URL(urlStr);
			
			con = (HttpURLConnection)url.openConnection();
			con.setRequestMethod("GET");
			in = new BufferedReader(new InputStreamReader(con.getInputStream(), "UTF-8"));
			String line;
			sb = new StringBuffer();
			while((line = in.readLine()) != null) { // response를 차례대로 출력
				sb.append(line);
			}
			line = sb.toString();
			
			returnList = new ObjectMapper().readValue(line, new TypeReference<ArrayList<String>>(){});
			
		} catch(Exception e) {
			throw e;
		} finally {
			con.disconnect();
			in.close();
			sb.delete(0, sb.length() );
		}
		return returnList;
	}

	@Override
	public HashMap<String, Object> getMatchInfoUrl(HashMap<String, Object> objMap, ArrayList<String> matchIdList) throws Exception {
		
		HashMap<String, Object> returnMap = new HashMap<String, Object>();
		try {
			String matchInfoCode = (String)objMap.get("code");
			String line;
			
			for(String matchId : matchIdList) {
				String urlStr = riotMapper.getApiUrl(matchInfoCode) + matchId + "?api_key=" + objMap.get("apiKey");

				logger.info("Riot API URL : " + urlStr);
				
				URL url = new URL(urlStr);
				
				con = (HttpURLConnection)url.openConnection();
				con.setRequestMethod("GET");
				in = new BufferedReader(new InputStreamReader(con.getInputStream(), "UTF-8"));
				
				sb = new StringBuffer();
				while((line = in.readLine()) != null) { // response를 차례대로 출력
					sb.append(line);
				}
				
			}
			line = sb.toString();
			returnMap = new ObjectMapper().readValue(line, new TypeReference<HashMap<String, Object>>(){});
			
		} catch(Exception e) {
			throw e;
		} finally {
			con.disconnect();
			in.close();
			sb.delete(0, sb.length() );
		}
		return returnMap;
	}
	
	@Override
	public ArrayList<Object> getrecordInfoUrl(HashMap<String, Object> objMap) throws Exception {
		
		ArrayList<Object> returnList = new ArrayList<Object>();
		try {
			String recordInfoCode = (String)objMap.get("code");
			String urlStr = riotMapper.getApiUrl(recordInfoCode) + objMap.get("summonerId") + "?api_key=" + objMap.get("apiKey");
			
			logger.info("Riot API URL : " + urlStr);
			
			URL url = new URL(urlStr);
			
			con = (HttpURLConnection)url.openConnection();
			con.setRequestMethod("GET");
			in = new BufferedReader(new InputStreamReader(con.getInputStream(), "UTF-8"));
			String line;
			sb = new StringBuffer();
			while((line = in.readLine()) != null) { // response를 차례대로 출력
				sb.append(line);
			}
			line = sb.toString();
			returnList = new ObjectMapper().readValue(line, new TypeReference<ArrayList<Object>>(){});
		} catch(Exception e) {
			throw e;
		} finally {
			con.disconnect();
			in.close();
			sb.delete(0, sb.length() );
		}
		return returnList;
	}
}
