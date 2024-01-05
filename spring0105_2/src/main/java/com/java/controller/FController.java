package com.java.controller;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.java.dto.BoardDto;
import com.java.service.BService;

import jakarta.mail.Multipart;
import jakarta.servlet.http.HttpSession;

@Controller
public class FController {

	@Autowired BService bService;
	@Autowired HttpSession session;
	//1. main
	@GetMapping({"/","main"})
	public String main() {
		return "main";
	}
	
	
	
	@GetMapping("blist") 
	public String blist(Model model) {
		//2. 게시글 전체가져오기
		List<BoardDto> list = bService.selectAll();
		model.addAttribute("list",list);
		return "blist";
	}
	
	
	//4. 글쓰기 페이지 보기
	@GetMapping("bwrite")
	public String bwrite() {
		return "bwrite";
	}
	
	
	@GetMapping("bview") //3.게시글 보기
	public String bview(@RequestParam(defaultValue = "1")int bno,Model model) {
		//게시글 1개 가져오기
		BoardDto bdto = bService.selectOne(bno);
		model.addAttribute("bdto",bdto);
		return "bview";
	}
	
	@PostMapping("bwrite") //5. 글쓰기 저장
	public String bwrite(BoardDto bdto,@RequestPart MultipartFile file,Model model) throws Exception {
		System.out.println("controller bwrite btitle : "+bdto.getBtitle());
		//파일 서버로 전송하는 부분
		if(!file.isEmpty()) {
			String oriFileName = file.getOriginalFilename();
			long time = System.currentTimeMillis();
			String uploadFileName = time+"_"+oriFileName; //파일이름변경
			String uploadUrl = "c:/upload/";
			File f = new File(uploadUrl+uploadFileName); //파일등록
			file.transferTo(f); //파일서버로 전송
			bdto.setBfile(uploadFileName); //dto bfile 이름저장
		}else {
			bdto.setBfile(""); //dto bfile 이름저장
		}
		System.out.println("controller bwrite bfile : "+bdto.getBfile());
		
		//service연결 - 글쓰기 저장
		bService.bwrite(bdto);
		
		model.addAttribute("result","success-bwrite");
		return "result";
	}
	
	@PostMapping("uploadImage") //6.summernote에서 ajax이미지 전송
	@ResponseBody //ajax이기에 responsebody부분 추가
	public String uploadImage(@RequestPart MultipartFile file) throws Exception {
		String urlName = "";
		//파일 서버로 전송하는 부분
		if(!file.isEmpty()) {
			String oriFileName = file.getOriginalFilename();
			long time = System.currentTimeMillis();
			String uploadFileName = time+"_"+oriFileName; //파일이름변경
			String uploadUrl = "c:/upload/";
			File f = new File(uploadUrl+uploadFileName); //파일등록
			file.transferTo(f); //파일서버로 전송
			urlName = "/upload/"+uploadFileName;
			System.out.println("controller ajax전송 링크주소 : "+urlName);
		}
		return urlName;
	}
	
		//4. 다음 지도 보기
		@GetMapping("map")
		public String map() {
			return "map";
		}
	

	@GetMapping("searchScreen")
	@ResponseBody //데이터 전송
	public String searchScreen(String txt) throws Exception {
		System.out.println("searchData txt : "+txt);
		String key ="b4cefdc91025f56609b0e03df7a460a0";
		StringBuilder urlBuilder = new StringBuilder("http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json"); /*URL*/
        urlBuilder.append("?" + URLEncoder.encode("key","UTF-8") + "="+key); /*Service Key*/
        urlBuilder.append("&" + URLEncoder.encode("targetDt","UTF-8") + "=" + URLEncoder.encode("20231228", "UTF-8")); /*응답메세지 형식 : REST방식의 URL호출 시 json값 추가(디폴트 응답메세지 형식은XML)*/
        URL url = new URL(urlBuilder.toString());
        //URL url = new URL("https://apis.data.go.kr/B551011/PhotoGalleryService1/galleryList1?serviceKey=918RE13GA7OY7ZEmUzApgbOeAcQoZ%2FaHsXWcqPAKQ9YNNPj83KOstRMRIUrCFIAcm9qj2R6b7NFZjp%2FYsYzJLg%3D%3D&numOfRows=10&pageNo=2&MobileOS=ETC&MobileApp=AppTest&arrange=A&_type=json");
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Content-type", "application/json");
        System.out.println("Response code: " + conn.getResponseCode());
        BufferedReader rd;
        if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
            rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        } else {
            rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
        }
        StringBuilder sb = new StringBuilder();  //String 을 계속 더하면 String변수를 계속 새롭게 만듬.
        String line;
        while ((line = rd.readLine()) != null) {
            sb.append(line); //json데이터를 sb에 1줄씩 저장
        }
        rd.close();
        conn.disconnect();
        System.out.println(sb.toString());
		
		return sb.toString();
	}
	


}
