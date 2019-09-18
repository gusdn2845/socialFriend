package com.board.controller;


import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.board.domain.ChatDTO;
import com.board.domain.UserVO;
import com.board.service.ChatService;
import com.board.service.UserService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class ChatController {
	@Autowired
	ChatService service;
	@Autowired
	UserService userservice;
	
	@ResponseBody
	@PostMapping("/chatSubmit")
	public void findFriend(HttpServletRequest request,@RequestParam("fromID") String fromName,@RequestParam("toID") String toName,
			@RequestParam("chatContent") String chatContent) {
		SimpleDateFormat format = new SimpleDateFormat ( "yyyy년 MM월dd일 HH시mm분");
		Date time = new Date();
		ChatDTO dto = new ChatDTO();
		dto.setFromName(fromName);
		dto.setToName(toName);
		dto.setChatContent(chatContent);
		dto.setProfile(userservice.checkid(toName).getUserprofile());
		dto.setChatTime(format.format(time));
		service.submit(dto);
	}
	
	@ResponseBody
	@PostMapping("/chatList")
	public List<ChatDTO> chatList(@RequestParam("fromID") String fromName,
			@RequestParam("toID") String toName,@RequestParam("type") int chatID) {
		service.messageRead(fromName, toName);
		List<ChatDTO> list = service.messageList(fromName, toName, chatID);
		for(int i = 0 ; i < list.size() ;i++) {
			log.info(list.get(i).getFromName()+","+userservice.checkid(list.get(i).getFromName()).getUserprofile());
			list.get(i).setProfile(userservice.checkid(list.get(i).getFromName()).getUserprofile());
		}
		
		return list;
	}
	
	@ResponseBody
	@PostMapping("/unread")
	public int unread(@RequestParam("name") String name) {
		return service.unread(name).size();
	}
	
	@ResponseBody
	@PostMapping("/chatBox")
	public List<ChatDTO> chatBox(@RequestParam("name") String name,HttpServletRequest request){
		HttpSession session = request.getSession();
		UserVO user = (UserVO) session.getAttribute("user");
		List<ChatDTO> list = service.getBox(name);
		for(int i = 0 ; i < list.size(); i++) {
			ChatDTO x = list.get(i);
			for(int j = 0 ; j < list.size(); j++) {
				ChatDTO y = list.get(j);
				if(x.getFromName().equals(y.getToName()) && x.getToName().equals(y.getFromName())) {
					if(x.getChatID() < y.getChatID()) {
						list.remove(x);
						i--;
						break;
					}else {
						list.remove(y);
						j--;
					}
				}
			}
		}
		
		for(int i = 0 ; i < list.size(); i++) {
			int unread = service.getunread(name, list.get(i).getFromName()).size();
			if(list.get(i).getFromName().equals(user.getUserid())) {
				list.get(i).setProfile(userservice.checkid(list.get(i).getToName()).getUserprofile());
				list.get(i).setFromName(userservice.checkid(list.get(i).getToName()).getUsername());
			}else {
				list.get(i).setProfile(userservice.checkid(list.get(i).getFromName()).getUserprofile());
				list.get(i).setToName(list.get(i).getFromName());
				list.get(i).setFromName(userservice.checkid(list.get(i).getToName()).getUsername());
			}
			list.get(i).setChatRead(unread);
		}
		//log.info(list+"");
		return list;
	}
}
