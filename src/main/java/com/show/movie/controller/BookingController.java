package com.show.movie.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.show.movie.model.domain.User;
import com.show.movie.model.service.BookingService;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class BookingController {
	@Autowired
	private BookingService bookingService;
	
	
	/*
	 * public Map<String,Object> getMyPage(String userId) { Map<String,Object> map =
	 * new HashMap<String, Object>(); map.put("booking",
	 * bookingDAO.getAllbooking(userId)); map.put("cancellationList",
	 * cancellationDAO.getAllcancellation(1)); return map; }
	 */
	@RequestMapping(value = "/myPage", method = RequestMethod.GET)
	public String getMyPage(Model model, HttpSession session) {
		// Map 형태로  해당 유저의 예매내역, 취소내역을 담아준다
		
		model.addAttribute("bookingList", bookingService.getMyPage(
				( (User) session.getAttribute("user")).getUserId()
				));
		return "myPage";
	}
	//수정
	@RequestMapping(value = "/cancellation", method = RequestMethod.GET)
	public String cancellation(Model model , int  bookingCode , HttpSession sessoin) {
		//예매취소 버튼을 누르면 예매상태 코드 변경. (예매 취소 상태)
		bookingService.cancelDate(bookingCode); 
		return "redirect:/myPage"; //컨트롤러로 보냄
	}
	
}
//	@RequestMapping(value = "/myPage", method = RequestMethod.GET)
//	public String getEmpCount(Model model) {
//		model.addAttribute("bookingList", bookingService.getAllBooking("jeongmin"));
//		System.out.println(bookingService.getAllBooking("jeongmin"));
//		return "myPage";
//	}
//	@RequestMapping(value = "/myPage", method =RequestMethod.GET)
//	public String getAllcancellation (Model model) {
//		model.addAttribute("cancellationList",bookingService.getAllcancellation(1));
//		System.out.println(bookingService.getAllcancellation(1));
//		return "myPage";
//	}
	/* cancellation 불러와서 리턴할 자리. 
	 * 예매관련 controller와 view는 하나로만 할 예정 
	 */