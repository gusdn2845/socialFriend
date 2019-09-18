package com.board.mappers;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.board.domain.ChatDTO;

public interface ChatMapper {
	public int chatSubmit(ChatDTO dto); //메세지 전송
	
	public List<ChatDTO> messageList(@Param(value = "fromName") String fromName,@Param(value = "toName") String toName,@Param(value = "chatID") int chatID);
	
	public void messageRead(@Param(value = "fromName") String fromName,@Param(value = "toName") String toName);
	
	public List<ChatDTO> unread(@Param(value = "name") String name);
	
	public List<ChatDTO> getunread(@Param(value = "fromName") String fromName,@Param(value = "toName") String toName);
	
	public List<ChatDTO> getBox(@Param(value = "name") String name);
}
