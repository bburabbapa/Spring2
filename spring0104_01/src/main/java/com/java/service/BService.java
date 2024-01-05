package com.java.service;

import java.util.List;

import com.java.dto.BoardDto;

public interface BService {

	//게시글 전체 가져오기
	List<BoardDto> blist();

	//게시글 저장
	void write(BoardDto bdto);

	//게시글 1개 가져오기
	BoardDto selectOne(int bno);


}
