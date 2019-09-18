package com.board.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.board.domain.FriendDTO;
import com.board.domain.UserVO;
import com.board.service.FriendService;
import com.board.service.UserService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class FriendController {
	@Autowired
	FriendService service;
	
	@Autowired
	UserService userservice;
	@ResponseBody
	@PostMapping("/findFriend")
	public Map<String,Object> findFriend(HttpServletRequest request) {
		String name = request.getParameter("findName");
		Map<String, Object> map = new HashMap<String, Object>();
		UserVO find = service.findUser(name);
		if(ObjectUtils.isEmpty(find)) {
			map.put("user", null);
			return map;
		}
		map.put("user", find);
		return map;
	}
	
	@GetMapping("/friendReq")
	public String friendReq(@RequestParam("toID") String friendID,HttpServletRequest request) {
		HttpSession session = request.getSession();
		UserVO user = (UserVO)session.getAttribute("user");
		if(user.getUserid().equals(friendID)) {
			request.setAttribute("message", "자신과 친구상태가 될수 없습니다.");
			return "find";
		}
		FriendDTO friend = new FriendDTO();
		friend.setUserID(user.getUserid());
		friend.setFriendID(friendID);
		if(service.checkFriend(friend) != null) {
			if(service.checkFriend(friend).getAvaliable() == 1) {
				request.setAttribute("message", "이미 친구상태 입니다.");
				return "find";
			}else {
				request.setAttribute("message", "이미 친구요청을 하였습니다.");
				return "find";
			}
		}else {
			boolean result = service.friendReq(friend);
			if(result == false) {
				request.setAttribute("message", "친구요청에 실패하였습니다.");
				return "find";
			}else {
				request.setAttribute("message", "친구요청을 하였습니다.");
				return "find";
			}
		}
	}
	
	@ResponseBody
	@PostMapping("/friendReqNum")
	public int friendReqNum(@RequestParam("name") String name) {
		return service.friendReqList(name).size();
	}
	
	@ResponseBody
	@PostMapping("/friendReqList")
	public List<UserVO> friendReqList(@RequestParam("name") String name) {
		List<UserVO> list = null;
		if(service.friendReqList(name).size() != 0) {
			list = new ArrayList<UserVO>();
			for(int i = 0 ; i < service.friendReqList(name).size(); i++) {
				list.add(userservice.checkid(service.friendReqList(name).get(i).getUserID()));
			}
		}
		return list;
	}
	
	@ResponseBody
	@PostMapping("/friendAccept")
	public String friendAccept(HttpServletRequest request) {
		HttpSession session = request.getSession();
		UserVO user = (UserVO)session.getAttribute("user");
		boolean result = service.friendAccept(user.getUserid(), request.getParameter("friendID"));
		if(result == true) {
			return "1";
		}else {
			return "0";
		}
	}
	
	@ResponseBody
	@PostMapping("/friendRefusal")
	public String friendRefusal(HttpServletRequest request) {
		HttpSession session = request.getSession();
		UserVO user = (UserVO)session.getAttribute("user");
		boolean result = service.friendRefusal(user.getUserid(), request.getParameter("friendID"));
		if(result == true) {
			return "1";
		}else {
			return "0";
		}
	}
}
