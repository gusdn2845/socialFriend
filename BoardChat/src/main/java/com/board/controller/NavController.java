package com.board.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com.board.domain.UserVO;
import com.board.service.UserService;


@Controller
public class NavController {
	@Autowired
	UserService service;
	
	@GetMapping("/")
	public String main() {
		return "index";
	}
	
	@GetMapping("/login")
	public String login() {
		return "login";
	}
	
	@GetMapping("/join")
	public String join(){
		return "join";
	}
	
	@GetMapping("/update")
	public String update(){
		return "update";
	}
	//로그아웃
	@GetMapping("/logout")
	public String logout(HttpServletRequest request) {
		HttpSession session = request.getSession();
		session.invalidate();
		return "redirect:/";
	}
	
	@GetMapping("/updateprofile")
	public String updateprofile(HttpServletRequest request){
		HttpSession session = request.getSession();
		String path = request.getRealPath("/resources/upload/");
		UserVO user = (UserVO)session.getAttribute("user");
		if(user.getUserprofile().equals("")) {
			user.setUserprofile("image.jpg");;
		}
		return "updateprofile";
	}
	
	@GetMapping("/find")
	public String findFriend() {
		return "find";
	}
	
	@GetMapping("/chat")
	public String chat(HttpServletRequest request) {
		UserVO user = service.checkid(request.getParameter("toID"));
		if( user == null){
			request.setAttribute("message", "존재하지 않는 이용자입니다.");
			return "find";
		}
		request.setAttribute("toID", service.checkid(request.getParameter("toID")));
		return "chat";
	}
	
	@GetMapping("/msgBox")
	public String msgBox() {
		return "msgBox";
	}
	
	@GetMapping("/friendList")
	public String friendList() {
		return "friendList";
	}
	
	@GetMapping("/friendRequest")
	public String friendRequest() {
		return "friendRequest";
	}
}
