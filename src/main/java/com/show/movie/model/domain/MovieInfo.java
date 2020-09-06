package com.show.movie.model.domain;

import java.sql.Date;
import java.util.List;

import org.apache.ibatis.type.Alias;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Configuration
@Alias("movieInfo")
@Getter @Setter
@ToString
public class MovieInfo { 
	@Bean("movieInfoVO")
	public MovieInfo getMovieInfo() {
		return new MovieInfo();
	}
	public MovieInfo() {  
	}
	@Builder 
	public MovieInfo(Movie movie, Theater theater, Branch branch) {
		this.movie = movie;
		this.theater = theater;
		this.branch = branch;   
	}
	@Autowired(required = false) 
	private Movie movie;
	@Autowired(required = false)
	private Theater theater;
	@Autowired(required = false)
	private Branch branch;
	private int moiveInfoCode;
	private String movieStartTime; 
	private Date movieDate;
	private String movieEndTime;

	private int totalPrice;
	private int totalPeople;
	private List<MovieInfo> info;

	public MovieInfo(Movie movie, Theater theater, Branch branch, int moiveInfoCode, Date movieDate,
			String movieStartTime, String movieEndTime) {
		super();
		this.movie = movie;
		this.theater = theater;
		this.branch = branch;
		this.moiveInfoCode = moiveInfoCode;
		this.movieDate = movieDate;
		this.movieStartTime = movieStartTime;
		this.movieEndTime = movieEndTime;
	}
	
	
	
}
