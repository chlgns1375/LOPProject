package com.example.MVCProject.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;
import org.mockito.InjectMocks;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.example.MVCProject.service.RiotService;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping(value = "/search")
public class SearchManageController {
	
	@Autowired(required=true)
	private RiotService riotService;
	
	public String getApiKey() {
		String apikey = "";
		try {
			 apikey = riotService.getApiKey();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return apikey;
	}
	
	@GetMapping("/userSearchManage")
	public ModelAndView userSearchManage(@RequestParam("summonerName") String summonerName,
			HttpServletRequest request, HttpServletResponse response) {
		
		ModelAndView mav = new ModelAndView();
		
		HashMap<String, Object> returnMap = new HashMap<String, Object>();
		
		try {
			
			HashMap<String, Object> objMap = new HashMap<String, Object>();
			
			HashMap<String, Object> puuidMap = new HashMap<String, Object>(); //소환사에 대한 고유번호 정보
			HashMap<String, Object> accountInfoMap = new HashMap<String, Object>(); //소환사에 대한 계정정보
			ArrayList<String> matchIdList = new ArrayList<String>(); // 소환사의 경기 고유번호 정보
			ArrayList<Object> matchInfoList = new ArrayList<Object>(); // 소환사의 경기에 대한 정보
			ArrayList<Object> recordInfoList = new ArrayList<Object>(); // 소환사의 전체전적에 대한 정보
			String[] summonerNameSplit = summonerName.replaceAll(" ",  "").split("-");
			String nickName = summonerNameSplit[0];
			String tagName = summonerNameSplit[1];
			objMap.put("nickName", nickName);
			objMap.put("tagName", tagName);
			objMap.put("apiKey", getApiKey());
			objMap.put("code", "0");
			
			puuidMap = riotService.getPuuidApiUrl(objMap);
			objMap.put("puuid", (String)puuidMap.get("puuid"));
			returnMap.put("puuidMap", puuidMap);
			
			objMap.replace("code", "1");
			accountInfoMap = riotService.getAccountInfoApiUrl(objMap);
			returnMap.put("accountInfoMap", accountInfoMap);
			
			objMap.replace("code", "2");
			matchIdList = riotService.getMatchIdListUrl(objMap);
			returnMap.put("matchIdList", matchIdList);
			/*
			objMap.replace("code", "3");
			objMap.put("matchIdList", matchIdList);
			matchInfoList = riotService.getMatchInfoUrl(objMap, matchIdList);
			returnMap.put("matchInfoList", matchInfoList);
			*/
			objMap.replace("code", "4");
			objMap.put("summonerId", accountInfoMap.get("id"));
			recordInfoList = riotService.getrecordInfoUrl(objMap);
			returnMap.put("recordInfoList", recordInfoList);
			
			JSONObject jsonObject = new JSONObject(returnMap);
			
			mav.addObject("jsonObj",jsonObject);
            mav.setViewName("/search/userSearchManage");
		} catch (Exception e) {
			mav.addObject("err", e.getMessage());
		}
		
		return mav;
	}
	
}
