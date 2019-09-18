package com.board.service;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.board.domain.FriendDTO;
import com.board.domain.UserVO;
import com.board.mappers.UserMapper;

@Service
public class UserService {
	@Autowired
	BCryptPasswordEncoder encoder;
	@Autowired
	UserMapper mapper;
	
	public UserVO login(String userid) {
		return mapper.get(userid);
	}
	
	public int join(UserVO vo) {
		return mapper.join(vo);
	}
	
	public UserVO checkid(String userid) {
		return mapper.get(userid);
	}
	
	public boolean update(UserVO vo) {
		return mapper.update(vo);
	}
	
	public boolean updateprofile(UserVO vo) {
		return mapper.updateprofile(vo);
	}
}
