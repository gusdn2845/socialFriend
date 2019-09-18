package com.board.controller;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.board.domain.UserVO;
import com.board.domain.WriteDTO;
import com.board.service.WriteService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class WriteController {
	@Autowired
	WriteService service;
	
	@PostMapping("/write")
	public String write(HttpServletRequest request) {
		HttpSession session = request.getSession();
		SimpleDateFormat format = new SimpleDateFormat ( "yyyy년 MM월dd일 HH시mm분");
		Date time = new Date();
		UserVO user = (UserVO) session.getAttribute("user");
		WriteDTO write = new WriteDTO();
		write.setUserid(user.getUserid());
		write.setWriteTitle(request.getParameter("title"));
		write.setWriteContent(request.getParameter("content"));
		log.info(write+"");
		service.write(write);
		//write.setDate(format.format(time));
		return "redirect:/";
	}
}
