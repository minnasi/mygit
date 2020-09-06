package com.show.movie.model.dao;

import java.sql.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.show.movie.model.domain.Branch;
import com.show.movie.model.domain.Location;
import com.show.movie.model.domain.Movie;
import com.show.movie.model.domain.MovieInfo;
import com.show.movie.model.domain.Theater;

public interface ManagerDAO {
	//재현
	public void insertMovie(Movie movie);
	public List<Movie> getMovieList(String managerId);
	public List<Location> getLocationList();
	public List<Branch> getBranchList();
	public List<Branch> getBranchList(Location location);
	public List<Theater> getTheaterList(String branchName);
	public void insertTheater(@Param("movieDate") String movieDate, 
			@Param("movieName")String movieName, @Param("theaterName") List<String> theaterName,
			@Param("movieStartTime") List<String> movieStartTime, @Param("movieEndTime") List<String> movieEndTime);
	public List<MovieInfo> getTimeScheduleInTheater(@Param("theaterNo") String theaterNo , @Param("timeSchedule") String timeSchedule);
	public int isViewTimeSchedule();
	public void createViewTimeSchedule();
	
    // SEAT 테이블용 DAO .. (데이터넣기..)
    void insertSeat(@Param("movieInfoCode") int movieInfoCode, @Param("seatName") String seatName);
    int countTheater();
    int lastMovieInfoCode();
	
}
