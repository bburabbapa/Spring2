package com.java.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.java.dto.BoardDto;

@Mapper
public interface BoardMapper {

	//게시글 전체가져오기
	List<BoardDto> selectAll();

	//글쓰기 저장
	void bwrite(BoardDto bdto);

	//게시글 1개 가져오기
	BoardDto selectOne(int bno);

	
}
