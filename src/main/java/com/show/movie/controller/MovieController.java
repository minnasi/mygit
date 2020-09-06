package com.show.movie.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.show.movie.model.domain.Movie;
import com.show.movie.model.service.MovieService;
import com.show.movie.util.parse.Parser;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
public class MovieController {
	@Autowired(required = false)
	Movie movie;
	@Autowired
	MovieService movieService;

	@RequestMapping(value = "/movie", method = { RequestMethod.GET, RequestMethod.POST })
	public String movie(Model model, Movie movie) {
		//검색된 영화이름 찾기  없으면 공백
		if (movie.getMovieName() != null) {
			model.addAttribute("movieName", movie.getMovieName());
		}else {
			model.addAttribute("movieName","");
		}
		// 영화전체리스트 불러오기
		List<Movie> movies = movieService.moviePageList(movie);
		log.info("this  Movie :  " + movie.getMovieName());
		model.addAttribute("movies", movies);

		return "movie";
	}

	@GetMapping(value = "/movieDetail")
	public String movieDetail(Model model, Movie movie) {
		movie = movieService.getMovie(movie.getMovieName());
		model.addAttribute("movie", movie);
		log.info(new Parser().stringParser(movie.getMovieImages()));
		model.addAttribute("movieImages", new Parser().stringParser(movie.getMovieImages()));
		return "movieDetail";
	}

	@GetMapping(value = "/getMovieImages", produces = "application/json; charset=utf8")
	@ResponseBody
	public String getMovieImages(String movieName) {
		return new Gson().toJson(new Parser().stringParser(movieService.getMovieImages(movieName)));
	}

	@GetMapping(value = "/getMovieSynopsis", produces = "application/json; charset=utf8")
	@ResponseBody
	public String getMovieSynopsis(String movieName) {
		return new Gson().toJson(movieService.getMovieSynopsis(movieName));
	}

}