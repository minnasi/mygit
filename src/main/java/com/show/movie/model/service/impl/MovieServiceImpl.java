package com.show.movie.model.service.impl;

import java.sql.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.show.movie.model.dao.MovieDAO;
import com.show.movie.model.dao.ViewTableDAO;
import com.show.movie.model.domain.Branch;
import com.show.movie.model.domain.Movie;
import com.show.movie.model.domain.MovieInfo;
import com.show.movie.model.domain.Seat;
import com.show.movie.model.service.MovieService;

import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class MovieServiceImpl implements MovieService {
	@Autowired
	MovieDAO movieDAO;
	@Autowired
	ViewTableDAO viewTableDAO;
	
	
	@Override
	public List<String> getBranch( String movieName,String movieDate, String locationName) {
		return movieDAO.getBranch(movieName, movieDate,locationName);
	}

	@Override
	public Movie getMovie(String movieName) {
		return movieDAO.getMovie(movieName);
	}

	@Override
	public List<MovieInfo> getMovieInfo(MovieInfo movieInfo) {
		try {
			if(viewTableDAO.isView("getMovieInfo") == 0) {
				viewTableDAO.createViewGetMovieInfo();
			}
			// 영화정보 가져오기
			List<MovieInfo> list = movieDAO.getMovieInfo(movieInfo);
			// 잔여좌석 가져오기
			for(int i = 0 ; i < list.size(); i++ ) {
				list.get(i).getTheater().setTheaterLeftSeat
				(movieDAO.getLeftSeat(list.get(i).getMoiveInfoCode()));
			}
			return list;
		}catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public String getMovieImages(String movieName) {
		return movieDAO.getMovieImages(movieName);
	}

	@Override
	public String getMovieSynopsis(String movieName) {
		return movieDAO.getMovieSynopsis(movieName);
	}
	
	@Override
	public List<Seat> getSeatList(int movieInfoCode) {
		return movieDAO.getSeatList(movieInfoCode);
	}

	@Override
	public List<Movie> moviePageList(Movie movie) {
		if(viewTableDAO.isView("moviePageList") == 0) {
			viewTableDAO.createViewMoviePageList();
		}
		
		return movieDAO.moviePageList();
	}

	@Override
	public List<Movie> getIndexMovie(Movie movie) {
		return movieDAO.getIndexMovie();
	}
	public Map<String, Object> getMovieAllList(String movieDate) {
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("movieList", movieDAO.getMovieAllList());
		map.put("movie",movieDAO.getNotRegisMovie(movieDate));
		return map;
	}

}
