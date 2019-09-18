package com.board.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.board.domain.WriteDTO;
import com.board.mappers.WriteMapper;

@Service
public class WriteService {
	@Autowired
	WriteMapper mapper;
	
	public void write(WriteDTO dto) {
		mapper.write(dto);
	}
}
