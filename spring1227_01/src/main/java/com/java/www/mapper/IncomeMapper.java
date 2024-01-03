package com.java.www.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.java.www.dto.IncomeDto;

@Mapper
public interface IncomeMapper {

	//매출액 가져오기
	List<IncomeDto> incomeSelect(String cyear);

}
