package com.java.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.java.service.EmailService;


@Controller
public class MController {
	
	@Autowired EmailService emailService;
	
	
	@RequestMapping("/")
	public String index() {
		return "index";
	}
	@PostMapping("email")
	@ResponseBody
	public String email(String name,String email) {
		System.out.println("MController 이름 : "+name);
		System.out.println("MController 이메일 : "+email);
		
		//service연결 - text 이메일발송
		//String result = emailService.emailSend(name,email);
		
		//service연결 - html 이메일발송
		String result = emailService.emailSend2(name,email);
		
		return "success : "+result;
	}
	

}
