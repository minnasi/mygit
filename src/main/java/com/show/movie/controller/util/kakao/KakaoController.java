package com.show.movie.controller.util.kakao;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.show.movie.model.domain.Booking;
import com.show.movie.model.domain.Movie;
import com.show.movie.model.domain.MovieInfo;
import com.show.movie.model.domain.Seat;
import com.show.movie.model.domain.User;
import com.show.movie.model.domain.kakao.KakaoPayApprovalVO;
import com.show.movie.model.service.BookingService;
import com.show.movie.model.service.UserService;
import com.show.movie.util.parse.Parser;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class KakaoController {
	@Autowired
	private KakaoAPI kakaoAPI;
	@Autowired(required = false)
	KakaoPay kakaoPay;
	@Autowired
	KakaoPayApprovalVO kakaoInfo;
	@Autowired(required = false)
	User user;
	@Autowired
	UserService userService;
	@Autowired
	BookingService bookingService;

	@RequestMapping(value = "/kakaoCallback")
	public String kakaoLogin(Model model, String code, HttpSession session) {
		String access_Token = kakaoAPI.getAccessToken(code);
		System.out.println("access_Token  " + access_Token);
		HashMap<String, Object> userInfo = kakaoAPI.getUserInfo(access_Token);
		user.setUserId((String) userInfo.get("id"));
		user.setUserName((String) userInfo.get("userName"));
		user.setUserSignupCode(2);
		if (userService.getUser(user.getUserId()) == null) {
			userService.insertNewUser(user);
		}
		// 클라이언트의 이메일이 존재할 때 세션에 해당 이메일과 토큰 등록
		if (user.getUserId() != null) {
			session.setAttribute("user", user);
		}
		//스크린창에서 로그인창으로 돌아온 경우에만 해당부분 실행 (스크린선택창에서 온게 아니면 메인페이지로 이동)
		//영화선택한  정보값을 스크린선택 컨트롤러에 전달
		String view = null;
		if (session.getAttribute("kakaoPay") == null) {
			view = "redirect:/";
		}else if(session.getAttribute("kakaoPay") != null) {
			session.removeAttribute("kakaoPay");
			view = "redirect:/getSelectScreen";
		}
		return view;
	}


	// 카카오 페이 결제 완료 후 정보 갖고오기
	@GetMapping("/kakaoPaySuccess")
	public String kakaoPay(Model model, @RequestParam("pg_token") String pg_token, HttpSession session) {
		
		
		log.info("kakaoPaySuccess ............................................");
		log.info("kakaoPaySuccess pg_token : " + pg_token);
//			JSP 기준
//			총 구매가격 : info.total 
//			갯수 : info.quantity
//			예매일 : info.approved_at  -->Date 타입
//			결제한 유저아이디 : info.partner_user_id
//			log에 info 찍혀있으니 필요한 것 쓰세요 
//			myPage에 url갖고가고 싶으면 redirect 빼세요.
//			 값 가져가고 싶으면 model에 넣으세요 (model.addAttribute(key,value);
		log.info("pgtoken :  " + pg_token);
		log.info(((User) session.getAttribute("user")).getUserId());
		try {
		kakaoInfo = kakaoPay.kakaoPayInfo(pg_token, ((User) session.getAttribute("user")).getUserId());
		}catch (NullPointerException e) {
			   return "/400Error";
		}catch (Exception e) {
			   return "/400Error";
		}
		
		log.info("kakaoInfo :  " + kakaoInfo);

		model.addAttribute("kakaoInfo", kakaoInfo);
		
		Seat seat = (Seat) session.getAttribute("seatList");
		kakaoInfo.getPartner_user_id();
		kakaoInfo.getAmount().getTotal();
		MovieInfo movieInfo = (MovieInfo)session.getAttribute("movieInfo");
		//Seat seatList = (Seat)
		log.info("상영관 코드 받아와야한다 !!   : "+ movieInfo);
		log.info("Seat : "+seat);
		
		// 예매내역에 값 넣기
		Booking booking = new Booking();
		booking.setUser(user);
		booking.getUser().setUserId(kakaoInfo.getPartner_user_id());
		booking.setMovieInfo(movieInfo);
		booking.setBookingSeat(seat.getSeatName());
		booking.setBookingPeople(kakaoInfo.getQuantity());
		booking.setBookingPrice(kakaoInfo.getAmount().getTotal());
		booking.setBookingState(0);
		
		bookingService.insertBookingInfo(booking);
		
		// 해당 상영 영화의 좌석 변경
		bookingService.updateSeatStatus(seat.getSeatName(), movieInfo.getMoiveInfoCode());
		
		session.removeAttribute("movieInfo");
		model.addAttribute("booking", booking);
		model.addAttribute("seat",seat);
		
//			 컨트롤러 기준

//			 kakaoInfo에서 꺼내 쓰면 됩니다.
//			 kakaoInfo.getPartner_user_id()
//			 kakaoInfo.getAmount().total() 등등..
//			 ↓ 밑에 예매내역 insert 하면 됩니다.
		
		return "redirect:/myPage";
	}

	// 카카오 페이 결제창 요청
	@PostMapping("/kakaoPay")
	public String kakaoPay(@ModelAttribute Movie movie, HttpSession session,
			@ModelAttribute("movieInfo") MovieInfo movieInfo, Seat seat, @RequestParam("seatName") List<String> seatName) {
		log.info("seat :  "+ new Parser().stringParser(seat.getSeatName()) );
		log.info("seatName :  "+ seatName);
		
		log.info("kakaoPay post............................................");
		
		User user = (User) session.getAttribute("user");
		session.setAttribute("seatList", seat);
		// 유저아이디 없으면 메인페이지로 리턴
		try {
			if (user.getUserId() == null)
				return "redirect:/login";
		} catch (NullPointerException e) {
			session.setAttribute("kakaoPay", "screen");
			return "redirect:/login";
		}
		
		// 유저에 다른 정보 넣어주려면 User로 파라미터를 받고 필요없으면 session.userId쓰기
		user.setUserId(user.getUserId());
		// ↓ 필요한 parameter : 유저아이디, 영화이름, 표개수, 총액
		String kakaoPayUrl = null;
		try {
			kakaoPayUrl = "redirect:" + kakaoPay.kakaoPayReady(movie, user,movieInfo);
		}catch (Exception e) {
			e.printStackTrace();
			kakaoPayUrl = "400Error";
		}
		return kakaoPayUrl; 
	}

	@RequestMapping(value = "kakaoPayCancel")
	public String kakaoPayCancel() {
		log.info("kakaoPayCancel 결제 취소");
		return "screen";
	}

	@RequestMapping(value = "kakaoPaySuccessFail")
	public String kakaoPaySuccessFail() {
		log.info("kakaoPaySuccessFail 잘못된 요청, 돈없거나 파라미터 잘못던짐");
		return "screen";
	}

}
