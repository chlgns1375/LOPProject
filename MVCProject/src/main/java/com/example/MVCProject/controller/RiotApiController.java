package com.example.MVCProject.controller;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.MVCProject.service.RiotService;


@Controller
@RequestMapping(value = "/riot")
public class RiotApiController {

	@Autowired(required=true)
	private RiotService riotService;
	
	@ResponseBody
	@GetMapping("/getApiKey")
	public HashMap<String, String> getApiKey(HttpServletRequest request, HttpServletResponse response) {
		
		HashMap<String, String> returnMap = new HashMap<String, String>();
		
		try {
			String apikey = riotService.getApiKey();
			returnMap.put("apikey", apikey);
			
			returnMap.put("status", "ok");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return returnMap;
	}
}
