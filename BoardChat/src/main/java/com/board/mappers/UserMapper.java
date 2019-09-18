package com.board.mappers;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.board.domain.FriendDTO;
import com.board.domain.UserVO;

public interface UserMapper {
	public UserVO get(String userid);
	
	public int join(UserVO vo);
	
	public boolean update(UserVO vo);
	
	public boolean updateprofile(UserVO vo);
}
