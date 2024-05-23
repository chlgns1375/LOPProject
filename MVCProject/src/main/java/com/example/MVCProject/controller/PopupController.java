package com.example.MVCProject.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping(value = "/popup")
public class PopupController {

	@RequestMapping(value = "/teamInformationPopup")
	public ModelAndView userSearchManage(HttpServletRequest request, HttpServletResponse response) {
		
		ModelAndView mav = new ModelAndView();
		
		try {
			
			mav.setViewName("/popup/teamInformationPopup");
		} catch(Exception e) {
			
		}
		
		return mav;
		
	}
}
