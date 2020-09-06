package com.show.movie.controller;

import java.sql.Date;
import java.text.DateFormat;
import java.text.SimpleDateFormat;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.show.movie.model.domain.Location;
import com.show.movie.model.domain.Movie;
import com.show.movie.model.domain.MovieInfo;
import com.show.movie.model.domain.Seat;
import com.show.movie.model.service.MovieService;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
public class TicketController {
	
	@InitBinder
    protected void initBinder(WebDataBinder binder){
        DateFormat  dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat,true));
    }

	
	@Autowired
	MovieService movieService;
	
	@RequestMapping(value="/getBranch",  produces = "application/json; charset=utf8")
	@ResponseBody
	public String ticketGetBranch(String movieDate,String movieName, String locationName , Model model) {
		return new Gson().toJson(
				movieService.getBranch(movieName, movieDate,locationName)
				);
	}
	
	@RequestMapping(value="/getMovieInfoAndTime",  produces = "application/json; charset=utf8")
	@ResponseBody
	public String getMovieInfoAndTime(Model model, MovieInfo movieInfo) {
		return new Gson().toJson(movieService.getMovieInfo(movieInfo));
	}


	@RequestMapping(value="/getSelectScreen" ,method = {RequestMethod.GET, RequestMethod.POST})
	public String getSelectScreen(Model model, @ModelAttribute("movieInfo") MovieInfo movieInfo, 
									 Seat seat, HttpSession session) {
		if(session.getAttribute("movieInfo") == null) {
		session.setAttribute("movieInfo", movieInfo);
		}
		log.info(session.getAttribute("movieInfo"));
		movieInfo = (MovieInfo)session.getAttribute("movieInfo");
		model.addAttribute("movieInfo", movieInfo);
		model.addAttribute("seatList", movieService.getSeatList(movieInfo.getMoiveInfoCode()));
		//log.info(seat.getSeatName());

		return "screen";
	}
	
	@GetMapping("/ticketing")
	public String ticketing(Model model,Movie movie) {
		model.addAttribute("movies",movieService.getMovieAllList(null));
		return "ticketing";
	}
	
	@GetMapping(value="/getMovieForDate", produces = "application/json; charset=utf8")
	@ResponseBody
	public String getMovieForDate(Model model, String movieDate) {
		return new Gson().toJson(movieService.getMovieAllList(movieDate));
	}

	
	
//	if( session.getAttribute("user") == null ) {
//		session.setAttribute("screenInfo", movieInfo);
//	}else {
//		if( session.getAttribute("screenInfo") != null) {
//		model.addAttribute("movieInfo", session.getAttribute("screenInfo"));
//		log.info(session.getAttribute("screenInfo"));
//		//session.removeAttribute("screenInfo");
//		}
//	}

	
}
