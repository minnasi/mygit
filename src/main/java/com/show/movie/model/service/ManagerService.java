package com.show.movie.model.service;

import java.sql.Date;
import java.util.HashMap;
import java.util.List;

import com.show.movie.model.domain.Branch;
import com.show.movie.model.domain.Location;
import com.show.movie.model.domain.Movie;
import com.show.movie.model.domain.MovieInfo;
import com.show.movie.model.domain.Theater;

public interface ManagerService {
	//재현
	public void insertMovie(Movie movie);
	public HashMap<String,Object> getMovieList(String managerId);
	public List<Branch> getBranchList(Location location);
	public List<Theater> getTheaterList(String branchName);
	public void insertTheater(String movieDate, String movieName ,
						 	  List<String> theaterName,List<String> movieStartTime, List<String> movieEndTime);
	public List<List<MovieInfo>> getTimeScheduleInTheater(List<String> theaterNo , String timeSchedule);
	public void insertSeat();
}
