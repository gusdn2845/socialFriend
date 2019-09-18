package com.board.mappers;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.board.domain.FriendDTO;
import com.board.domain.UserVO;

public interface FriendMapper {
	public UserVO finduser(String name);
	
	public boolean friendReq(FriendDTO friend);

	public List<FriendDTO> friendReqList(@Param(value = "name") String name);
	
	public boolean friendRefusal(@Param(value = "name") String name,@Param(value="friendID") String friendID);
	
	public boolean friendAccept(@Param(value = "name") String name,@Param(value="friendID") String friendID);
	
	public FriendDTO checkFriend(FriendDTO friend);
}
