package com.show.movie.controller;

import java.io.IOException;
import java.sql.Date;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.show.movie.model.domain.Location;
import com.show.movie.model.domain.Movie;
import com.show.movie.model.domain.MovieInfo;
import com.show.movie.model.domain.Theater;
import com.show.movie.model.service.ManagerService;
import com.show.movie.model.service.MovieService;
import com.show.movie.util.calc.MovieTime;
import com.show.movie.util.parse.Parser;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class ManagerController {

	// 웹에서 넘어온 Date 형식의 데이터를 java.sql.Date 형식에 맞춰 데이터 바인딩
	@InitBinder
	protected void initBinder(WebDataBinder binder) {
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
	}

	@Autowired
	ManagerService managerService;
	@Autowired
	MovieService movieService;
	
	@GetMapping("/addMovie")
	public void addMovie() {
	}

	@PostMapping("/insertMovie")
	public String insertMovie(Movie movie) {
		managerService.insertMovie(movie);
		return "redirect:/addMovie";
	}

	@RequestMapping(value = "/progress2")
	public String progress2(Model model) {
		return "progress2";

	}

	@PostMapping(value = "/fileUpload", produces = "application/json; charset=utf8")
	@ResponseBody
	public String fileUpload(MultipartHttpServletRequest multipartHttpServletRequest, Model model) throws IOException {
		return new Parser().fileParser(multipartHttpServletRequest);
	}

	@GetMapping("/addMovieInfo")
	public String addMovieInfo(Model model, HttpSession session) {
		session.setAttribute("managerId", "ko");
		String managerId = (String) session.getAttribute("managerId");
		model.addAttribute("data", managerService.getMovieList(managerId));
		return "addMovieInfo";
	}

	@GetMapping(value = "/getBranchList", produces = "application/json; charset=utf8")
	@ResponseBody
	public String getBranchList(Model model, Location location) {

		return new Gson().toJson(managerService.getBranchList(location));
	}

	@GetMapping(value = "/getTheaterInAddMovie", produces = "application/json; charset=utf8")
	@ResponseBody
	public String getTheaterInAddMovie(String branchName) {
		return new Gson().toJson(managerService.getTheaterList(branchName));
	}

	@PostMapping(value = "/getTheatersTimeTable", produces = "application/json; charset=utf8")
	@ResponseBody
	public String getTheatersTimeTable(Model model, 
			@RequestParam List<String> theaterNo, String timeSchedule, String movieName) {

		
		//		List<Object> canAddMovieTime = new Time<List<List<MovieInfo>>>().calcMovieTime(resigMovieTime);
//		for(Object test :  canAddMovieTime ) {
//			System.out.println( ( (MovieInfo) test) );
//		}
		
		//상영관별로 등록되어 있는 영화정보 갖고오기 
		List<List<MovieInfo>> resigMovieTime = managerService.getTimeScheduleInTheater(theaterNo, timeSchedule);
		//java.sql.date를   yyyy-MM-dd 형식에 맞게 바인딩
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
		// 상영관에 등록되지 않은 시간 계산해서 바인딩
		List<List<MovieInfo>> canAddMovieTime = new MovieTime<List<List<MovieInfo>>>().calcMovieTime(resigMovieTime);
			//결과값이 없으면 등록되지 않은 시간 전체값 구하기
				if(canAddMovieTime == null ) {
					canAddMovieTime = new ArrayList<List<MovieInfo>>();
					for(int i = 0 ; i < theaterNo.size(); i++) {
					try {
						
						canAddMovieTime.add( new MovieTime<List<List<MovieInfo>>>()
								.calcCanAddMovieFor24Hour("09:00", 
										movieService.getMovie(movieName).getMovieTime(), new ArrayList<MovieInfo>()));
						
						}catch(Exception e) {
							e.printStackTrace();
						}
				}	
		}		
			
			//디버그
			for(List<MovieInfo> list : canAddMovieTime) {
				for(MovieInfo info: list ) {
					System.out.println(info.getMovieStartTime()+"  :  "+info.getMovieEndTime());
				}
			}
//			//디버그
//		for(List<MovieInfo> test :  canAddMovieTime ) {
//			System.out.println("controller   : "+ test );
//		}
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("resigMovieTime", resigMovieTime);
		map.put("canAddMovieTime", canAddMovieTime);
		return gson.toJson(map);
	}

//	public String movieAddBranchAndTheater(@RequestBody Map<String, Object> map) {
//	public String movieAddBranchAndTheater(@RequestBody HashMap<String, Object> map) {
//	,
//	@RequestParam("theaterName") List<String> theaterName,
//	@RequestParam("movieStartTime") List<String> movieStartTime)

	@PostMapping(value = "/movieAddBranchAndTheater", produces = "application/json; charset=utf8")
	@ResponseBody
	public String movieAddBranchAndTheater(@RequestParam String movieDate, @RequestParam String movieName,
			@RequestParam List<String> branchName,
			@RequestParam List<String> theaterName, 
			@RequestParam List<String> movieStartTime,
			@RequestParam List<String> movieEndTime) {
		log.info(movieName);
		log.info(branchName);
		log.info(theaterName);
		log.info(movieStartTime);
		log.info(movieEndTime);

		 managerService.insertTheater(movieDate, movieName, theaterName,movieStartTime,movieEndTime);

		// log.info(movieStartTime);

		return "addMovieInfo";
	}
	
	
	
	@RequestMapping(value="/addSeatTable")
		public String addSeatTable() {
		
		managerService.insertSeat();
		
		return "redirect:/";
	}
	

//	@PostMapping(value="/movieAddBranchAndTheater",  produces = "application/json; charset=utf8")
//	@ResponseBody
//	public String movieAddBranchAndTheater(@RequestBody HashMap<String, Object> map) {
//		log.info(map);
//		log.info(map.get("theaterName"));
//		String aa = (String)map.get("theaterName");
//		String [] msg = (String[])map.get("theaterName");
//
//		log.info(aa);
//		log.info(msg);
//		//managerService.insertTheater(movieName, theaterName);
//		log.info(theaterName);
//		log.info(movieStartTime);
//		
//
//		return "addMovieInfo";
//	}

}
