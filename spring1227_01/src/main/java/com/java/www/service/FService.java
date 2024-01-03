package com.java.www.service;

import java.util.List;

import com.java.www.dto.IncomeDto;

public interface FService {

	//매출액 가져오기
	List<IncomeDto> incomeSelect(String cyear);

}
