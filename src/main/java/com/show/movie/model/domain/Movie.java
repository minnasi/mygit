package com.show.movie.model.domain;


import java.sql.Date;

import org.apache.ibatis.type.Alias;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Configuration
@Alias("movie")
@Getter @Setter @ToString
public class Movie {
	@Bean("movieVO")
	public Movie getMovie() {
		return new Movie();
	}
	private int movieCode;
	private String movieName;
	private String movieAudience;
	private String movieTicketRate;
	private String movieTicketRatePersent;
	private String movieTitle;
	private String movieSynopsis;
	private String moviePrice;
	private String moviePoster;
	private String moviePosterBG;
	private String movieImages;
	
	private String branchName;
	private Date movieUpdate;
	private int movieTime;
	
	@Autowired(required = false)
	private Manager manager;
	
	public Movie(int movieCode, String movieName, String movieAudience, String movieTicketRate,
			String movieTicketRatePersent, String movieTitle, String movieSynopsis, String moviePrice,
			String moviePoster, String moviePosterBG, String movieImages, String branchName, Date movieUpdate,
			int movieTime, Manager manager) {
		super();
		this.movieCode = movieCode;
		this.movieName = movieName;
		this.movieAudience = movieAudience;
		this.movieTicketRate = movieTicketRate;
		this.movieTicketRatePersent = movieTicketRatePersent;
		this.movieTitle = movieTitle;
		this.movieSynopsis = movieSynopsis;
		this.moviePrice = moviePrice;
		this.moviePoster = moviePoster;
		this.moviePosterBG = moviePosterBG;
		this.movieImages = movieImages;
		this.branchName = branchName;
		this.movieUpdate = movieUpdate;
		this.movieTime = movieTime;
		this.manager = manager;
	}


	public Movie() {
		super();
		// TODO Auto-generated constructor stub
	} 
	
	
	
}
