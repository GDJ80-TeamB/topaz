package com.topaz.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.topaz.dto.GuestRequest;
import com.topaz.service.CustomerService;
import com.topaz.utill.Debug;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class CustomerController {
	
	@Autowired
	CustomerService customerService;
	
	@GetMapping("/customer/gstLogin")
	public String gstLogin() {
		
		return "/customer/gstLogin";
	}

	@GetMapping("/customer/gstMain")
	public String gstMain() {
		
		return "/customer/gstMain";
	}

	@GetMapping("/customer/infoCompany")
	public String infoCompany() {
		
		return "/customer/infoCompany";
	}

	@GetMapping("/customer/infoPrograms")
	public String infoPrograms() {
		
		return "/customer/infoPrograms";
	}

	@GetMapping("/customer/infoRegident")
	public String infoRegident() {
		
		return "/customer/infoRegident";
	}

	@GetMapping("/customer/infoRegidentA")
	public String infoRegidentA() {
		
		return "/customer/infoRegidentA";
	}

	@GetMapping("/customer/newsDetail")
	public String newDetail() {
		
		return "/customer/newsDetail";
	}

	@GetMapping("/customer/newsList")
	public String newsList() {
		
		return "/customer/newsList";
	}

	@GetMapping("/customer/volunteerRqAdd")
	public String volunteerRqAdd() {
		
		return "/customer/volunteerRqAdd";
	}
	
	@GetMapping("/customer/signUp")
	public String signUp() {
		
		return "/customer/signUp";
	}
	
	/*
	 * 서비스명: signUp 
	 * 시작 날짜: 2024-07-10
	 * 담당자: 한은혜
	 */
	@PostMapping("/customer/signUpPost")
	public String signUpPost(GuestRequest guestRequest) {
		// 매개값 디버깅
		log.debug(Debug.HEH + "controller signUp guestRequest : " + guestRequest.toString() + Debug.END);
		
		customerService.signUp(guestRequest);
		
		return "/customer/gstLogin";
	}
	
	
	/*
	 * 서비스명: -
	 * 시작 날짜: 2024-07-12
	 * 담당자: 한은혜
	 */
	@GetMapping("/customer/gstMyInfo")
	public String gstMyInfo(HttpServletRequest req, Model model) {
		log.debug(Debug.HEH + "controller gstMyInfo HttpServletRequest : " + req + Debug.END);

		HttpSession session = req.getSession();
		log.debug(Debug.HEH + "controller gstMyInfo session : " + session + Debug.END);

		String gstId = (String)session.getAttribute("gstId");
		log.debug(Debug.HEH + "controller gstMyInfo gstId : " + gstId + Debug.END);

		Map<String, Object> gstDetail = customerService.selectGstOne(gstId);
		log.debug(Debug.HEH + "controller gstMyInfo gstDetail : " + gstDetail + Debug.END);

		model.addAttribute("gstDetail", gstDetail);
		
		return "/customer/gstMyInfo";
	}
	
	
	
	
	
	
	
	
	
	
	
	
}
