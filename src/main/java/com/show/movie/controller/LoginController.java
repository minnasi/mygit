package com.show.movie.controller;

import static org.junit.Assert.assertTrue;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.request;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.github.scribejava.core.model.OAuth2AccessToken;
import com.show.movie.controller.util.naver.NaverLoginBO;
import com.show.movie.model.dao.UserDAO;
import com.show.movie.model.domain.Login;
import com.show.movie.model.domain.User;
import com.show.movie.model.service.UserService;

import lombok.extern.log4j.Log4j;

/**
 * Handles requests for the application home page.
 */
@Controller
@Log4j
public class LoginController {
	/* NaverLoginBO */
	@Autowired
	private NaverLoginBO naverLoginBO;
	private String apiResult = null;
	@Autowired(required = false)
	User user;
	
	@Autowired(required = false)
	Login login;
	
	@Autowired
	UserDAO userDao;
	
	@Autowired
	UserService userService;


	  @RequestMapping(value = "/loginPost", method = RequestMethod.POST) 
	  public String loginPost(User user,User login, HttpServletRequest request,HttpSession httpSession, Model model) { 
		  log.info("param : "+login);
		  log.info("param : " + user);
		  login = userService.getLogin(user);
		  user = userService.getUser(user.getUserId());
		  log.info("return login : " + login);
		  log.info("return user : " + user);
		  

		if (login == null ) {
			  return "login";
		  }else {
			  request.getSession().setAttribute("user",user);
			  model.addAttribute("user",user);
			  return "redirect:/";
		  }
		  
	  }
	  
	  
	  
	 

	//  네이버로그인
	@RequestMapping(value="/login", method = { RequestMethod.GET, RequestMethod.POST })
	public String login(Model model , HttpSession session) {
		
		/* 네이버아이디로 인증 URL을 생성하기 위하여 naverLoginBO클래스의 getAuthorizationUrl메소드 호출 */
		//https://nid.naver.com/oauth2.0/authorize?response_type=code&client_id=sE***************&
		//redirect_uri=http%3A%2F%2F211.63.89.90%3A8090%2Flogin_project%2Fcallback&state=e68c269c-5ba9-4c31-85da-54c16c658125
		String naverAuthUrl = naverLoginBO.getAuthorizationUrl(session);
		model.addAttribute("naverAuthUrl", naverAuthUrl);
		return "login";
	}

	//네이버 로그인 성공시 callback호출 메소드
	@RequestMapping(value = "/naverCallback", method = { RequestMethod.GET, RequestMethod.POST })
	public String naverNallback(Model model, @RequestParam String code, @RequestParam String state, HttpSession session)
			throws IOException, ParseException {

		OAuth2AccessToken oauthToken;
		oauthToken = naverLoginBO.getAccessToken(session, code, state);
		//1. 로그인 사용자 정보를 읽어온다.
		apiResult = naverLoginBO.getUserProfile(oauthToken); // String형식의 json데이터
		/**
		 * apiResult json 구조 {"resultcode":"00", "message":"success",
		 * "response":{"id":"33666449","nickname":"shinn****","age":"20-29","gender":"M","email":"sh@naver.com","name":"\uc2e0\ubc94\ud638"}}
		 **/
		//2. String형식인 apiResult를 json형태로 바꿈
		JSONParser parser = new JSONParser();
		Object obj = parser.parse(apiResult);
		JSONObject jsonObj = (JSONObject) obj;
		System.out.println(apiResult);
		//3. 데이터 파싱
		//Top레벨 단계 _response 파싱
		JSONObject response_obj = (JSONObject) jsonObj.get("response");
		//response의 nickname값 파싱
		String userId = (String) response_obj.get("id");
		System.out.println(userId);
		
		
		System.out.println(" isUser   :  "+ userService.getUser(userId));
		//DB저장
		user = getLoginUserInfo(user, response_obj);
		if(userService.getUser(userId) == null ) {
			System.out.println("insert로 왔어염 " + user);
			
			userService.insertNewUser(user);
		}
		
		//4.파싱 닉네임 세션으로 저장
		session.setAttribute("user", user); // 세션 생성
		return "redirect:/";
	}
	
	//로그아웃
	@RequestMapping(value = "/logout", method = { RequestMethod.GET, RequestMethod.POST })
	public String logout(HttpSession session) throws IOException {
		session.invalidate();
		return "redirect:/";
	}
	
	public User getLoginUserInfo(User user, JSONObject obj) {
		user.setUserId((String)obj.get("id"));
		user.setUserName((String)obj.get("name"));
		user.setUserBirth((String)obj.get("birthday"));
		user.setUserSignupCode(1);
		return user;
	}
	
}
