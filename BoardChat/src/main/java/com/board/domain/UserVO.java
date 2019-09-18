package com.board.domain;

import java.sql.Date;

import lombok.Data;

@Data
public class UserVO {
	private String userid;
	private String password;
	private String username;
	private int userage;
	private String usergender;
	private String useremail;
	private String userprofile;
	private int friendnum;
	private Date regdate;
}
