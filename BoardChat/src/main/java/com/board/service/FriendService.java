package com.board.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.board.domain.FriendDTO;
import com.board.domain.UserVO;
import com.board.mappers.FriendMapper;

@Service
public class FriendService {
	@Autowired
	FriendMapper mapper;
	
	public UserVO findUser(String name) {
		return mapper.finduser(name);
	}
	
	public boolean friendReq(FriendDTO friend) {
		return mapper.friendReq(friend);
	}
	
	public List<FriendDTO> friendReqList(String name) {
		return mapper.friendReqList(name);
	}
	
	public boolean friendAccept(String name,String friendID) {
		return mapper.friendAccept(name, friendID);
	}
	
	public boolean friendRefusal(String name,String friendID) {
		return mapper.friendRefusal(name, friendID);
	}
	
	public FriendDTO checkFriend(FriendDTO friend) {
		return mapper.checkFriend(friend);
	}
}
