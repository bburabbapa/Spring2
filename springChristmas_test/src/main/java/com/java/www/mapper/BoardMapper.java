package com.java.www.mapper;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import com.java.www.dto.BoardDto;

@Mapper
public interface BoardMapper {

	//게시글전체 가져오기
	ArrayList<BoardDto> selectAll(int startRow, int endRow, String category, String searchWord);
	//게시글검색 가져오기
	ArrayList<BoardDto> selectSearch(int startRow, int endRow, String category, String searchWord);
	//게시글 총개수 
	int selectCountAll(String category, String searchWord);
	//게시글 검색개수
	int selectSearchCount(String category, String searchWord);

	//게시글1개 가져오기 - 현재글
	BoardDto selectOne(int bno);
	//게시글1개 가져오기 - 이전글
	BoardDto selectOnePrev(int bno);
	//게시글1개 가져오기 - 다음글
	BoardDto selectOneNext(int bno);
	//조회수 1증가
	void bhitUp(int bno);
	
	//글쓰기 저장
	int bInsert(BoardDto bdto);

	//게시글 삭제
	int bDelete(int bno);

	//게시글 수정저장
	int doBUpdate(BoardDto bdto);


	//-- 답변달기 저장 --
	//다른게시글 bstep 1증가
	void bstepUp(BoardDto bdto);
	int doBReply(BoardDto bdto);
	
	

	

	
	
	
	
	
	
	
}