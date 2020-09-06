package com.show.movie.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.show.movie.model.domain.User;
import com.show.movie.model.service.UserService;

@Controller
public class SignUpController {
	
	//내용 입력 회원가입 버튼 -> 입력받은 내용 컨트롤러에 전달 -> 처리(디비에 insert)->
	// 회원 가입 완료 알러트 창 -> 메인 페이지로 이동
	
	//아이디 중복확인
	
	
	@Autowired
	UserService userService;
	
	@Autowired(required = false)
	User user;
	
	@RequestMapping(value = "/signUp.do", method = RequestMethod.POST)
	public String signUp(Model model, User user) {
		
		int result = userService.userIdCheck(user);
		try {
			if(result == 1) { // 1 == 아이디중복 
				return "/signUp"; //회원가입 페이지로 되돌아감
			}else if(result == 0) { // 0 == 아이디 중복 아님
				userService.signUpUser(user); // user에 데이터 넣어줌...?
			}

		} catch (Exception e) {
			throw new RuntimeException();
		}
		model.addAttribute("user", user);
		System.out.println("회원가입 컨트롤러 왔다감");
		return "redirect:/";
	}
	
	@RequestMapping(value = "/userIdCheck", method = RequestMethod.POST,  produces = "application/json; charset=utf8")
	@ResponseBody
	 // 리턴값을 model없이 string으로 받음. (일반 controller는 modelAndView, 리턴(어디로 보낼지 주소) 필요
	public int userIdCheck(User user) {
		
		System.out.println("아이디체크 컨트롤러 왔다감");
		
		int result = userService.userIdCheck(user);
		return result;
	}
	
}
