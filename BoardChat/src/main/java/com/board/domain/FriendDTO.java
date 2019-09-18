package com.board.domain;

import lombok.Data;

@Data
public class FriendDTO {
	private String userID;
	private String friendID;
	private String addDate;
	private int avaliable;
}
