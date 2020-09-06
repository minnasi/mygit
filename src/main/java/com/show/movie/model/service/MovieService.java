package com.show.movie.model.service;

import java.sql.Date;
import java.util.List;
import java.util.Map;

import com.show.movie.model.domain.Movie;
import com.show.movie.model.domain.MovieInfo;
import com.show.movie.model.domain.Seat;

public interface MovieService {
	//재현
	public List<String> getBranch(String movieDate,String movieName, String locationName);
	public Movie getMovie(String movieName);
	public List<MovieInfo> getMovieInfo(MovieInfo movieInfo) ;
	public String getMovieImages(String movieName);
	public String getMovieSynopsis(String movieName);
	public List<Seat> getSeatList(int movieInfoCode);
	
	//예나
	public List<Movie> moviePageList(Movie movie);


	public List<Movie> getIndexMovie(Movie movie);
	public Map<String, Object> getMovieAllList(String movieDate);

}
