package com.show.movie.model.domain;

import org.apache.ibatis.type.Alias;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Configuration
@Alias("seat")
@Getter @Setter @ToString
public class Seat {
	
	@Bean(name="seatVO")
	public Seat getSeat(Seat seat) {
		return new Seat();
	}
	
	public Seat() {};
	
	@Builder
	public Seat(MovieInfo movieInfo) {

		this.movieInfo = movieInfo;
	}
	
	@Autowired(required = false)
	private MovieInfo movieInfo;

	
	private int seatCode;
	private int moiveInfoCode;
	private String seatName;
	private int seatStatus;

	
}
