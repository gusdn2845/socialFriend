package com.board.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.board.domain.ChatDTO;
import com.board.mappers.ChatMapper;

@Service
public class ChatService {
	@Autowired
	ChatMapper mapper;
	
	public int submit(ChatDTO dto) {
		return mapper.chatSubmit(dto);
	}
	
	public List<ChatDTO> messageList(String fromName,String toName,int chatID){
		return mapper.messageList(fromName, toName,chatID);
	}
	
	public void messageRead(String fromName,String toName) {
		mapper.messageRead(fromName, toName);
	}
	
	public List<ChatDTO> unread(String name) {
		return mapper.unread(name);
	}
	
	public List<ChatDTO> getunread(String fromName, String toName){
		return mapper.getunread(fromName, toName);
	}
	
	public List<ChatDTO> getBox(String name){
		return mapper.getBox(name);
	}
}
