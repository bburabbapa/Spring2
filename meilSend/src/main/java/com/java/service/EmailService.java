package com.java.service;

public interface EmailService {

	//text 이메일 발송
	String emailSend(String name, String email);

	//html 이메일 발송
	String emailSend2(String name, String email);

}
