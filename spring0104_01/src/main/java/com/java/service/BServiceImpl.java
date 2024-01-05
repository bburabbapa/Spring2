package com.java.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.java.dto.BoardDto;
import com.java.mapper.BoardMapper;

@Service
public class BServiceImpl implements BService {

	@Autowired
	BoardMapper boardMapper;
	
	@Override
	public List<BoardDto> blist() {
		//전체게시글 가져오기
		List<BoardDto> list = boardMapper.blist(); 
		return list;
	}

	@Override
	public void write(BoardDto bdto) {
		// 게시글 저장
		boardMapper.write(bdto);
	}

	@Override
	public BoardDto selectOne(int bno) {
		//게시글 1개 가져오기
		BoardDto boardDto = boardMapper.selectOne(bno);
		return boardDto;
	}


}
