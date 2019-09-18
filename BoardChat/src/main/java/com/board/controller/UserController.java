package com.board.controller;

import java.io.File;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.board.domain.UserVO;
import com.board.service.UserService;

import lombok.extern.slf4j.Slf4j;


@Controller
@Slf4j
public class UserController {
	@Autowired
	UserService service;
	
	@Autowired
	ServletContext contextCtx;
	
	@Autowired
	BCryptPasswordEncoder encoder;
	
	
	//로그인
	@PostMapping("/memberLogin")
	public String memberLogin(HttpServletRequest request) {
		HttpSession session = request.getSession();
		String userid = request.getParameter("userid");
		String userpw = request.getParameter("password");
		UserVO user = service.login(userid);
		if(ObjectUtils.isEmpty(user)) {
			request.setAttribute("message", "존재하지 않는 아이디입니다.");
			return "login";
		}else {
			if(!encoder.matches(userpw, user.getPassword())) {
				request.setAttribute("message", "비밀번호가 일치하지 않습니다.");
				return "login";
			}
		}
		session.setAttribute("user",user);
		return "index";
	}
	//회원가입
	@PostMapping("/memberJoin")
	public String memberJoin(HttpServletRequest request) {
		UserVO vo = new UserVO();
		vo.setUserid(request.getParameter("userid"));
		vo.setPassword(encoder.encode(request.getParameter("userpw")));
		vo.setUsername(request.getParameter("username"));
		vo.setUserage(Integer.parseInt(request.getParameter("userage")));
		vo.setUsergender(request.getParameter("usergender"));
		vo.setUseremail(request.getParameter("useremail"));
		int result = service.join(vo);
		if(result == 0) {
			return "redirect:/join";
		}else {
			return "redirect:/login";
		}
	}
	//회원가입시 중복확인
	@PostMapping("/checkid")
	public @ResponseBody boolean checkUser(@RequestParam("userid") String userid ) {
		UserVO user = service.checkid(userid);
		if(ObjectUtils.isEmpty(user)) {
			return true;
		}else {
			return false;
		}
	}
	//회원정보수정
	@PostMapping("/memberupdate")
	public String memberupdate(HttpServletRequest request) {
		HttpSession session = request.getSession();
		UserVO user = (UserVO)session.getAttribute("user");
		if(encoder.matches(request.getParameter("userpw"), user.getPassword())) {
			request.setAttribute("message", "이전비밀번호와 동일할 수 없습니다.");
			return "update";
		}
		
		user.setPassword(encoder.encode(request.getParameter("userpw")));
		user.setUseremail(request.getParameter("useremail"));
		if(service.update(user)) {
			return "index";
		}else {
			request.setAttribute("message", "오류가 발생했습니다.");
			return "update";
		}
	}
	
	@PostMapping("/memberprofile")
	public String memberprofile(MultipartFile file,HttpServletRequest request) {
		if(file.isEmpty()) {
			request.setAttribute("message", "업로드 파일이 없습니다.");
			return "updateprofile";
		}
		
		HttpSession session = request.getSession();
		UserVO user = (UserVO) session.getAttribute("user");
		String path = request.getRealPath("/resources/upload/");
		String ext = file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf(".")+1);
		UUID uuid = UUID.randomUUID();
		String fileName = uuid.toString() + "_" + file.getOriginalFilename();
		if(ext.equals("jpg")||ext.equals("png")||ext.equals("gif")) {
			File saveFile = new File(path,fileName);
			File preFile = new File(path,user.getUserprofile());
			try {
				if(preFile.exists()) {
					preFile.delete();
				}
				file.transferTo(saveFile);
				user.setUserprofile(fileName);
				service.updateprofile(user);
			}catch(Exception e) {
				e.printStackTrace();
				request.setAttribute("message", "업로드 오류가 발생했습니다.");
				return "updateprofile";
			}
			request.setAttribute("message", "등록되었습니다.");
			return "updateprofile";
			
		}else {
			request.setAttribute("message", "해당파일은 업로드 할 수 없습니다.");
			return "updateprofile";
		}
	}
}
