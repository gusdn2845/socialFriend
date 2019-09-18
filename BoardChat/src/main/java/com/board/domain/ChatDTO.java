package com.board.domain;

import lombok.Data;

@Data
public class ChatDTO {
	private int chatID;
	private String fromName;
	private String toName;
	private String chatContent;
	private String chatTime;
	private String profile;
	private int chatRead;
}
