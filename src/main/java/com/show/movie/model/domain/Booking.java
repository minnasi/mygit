package com.show.movie.model.domain;

import java.sql.Date;

import org.apache.ibatis.type.Alias;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Configuration
@Alias("booking")
@Getter
@Setter
@ToString
public class Booking {
	
	@Bean("bookingVO")
	public Booking getBooking() {
		return new Booking();
	}
	private int bookingCode;
	private Date bookingDate;
	private String bookingSeat;
	private int bookingPeople;
	private int bookingPrice;
	private int bookingState;
	
	@Autowired(required = false)
	User user;
	@Autowired(required = false)
	private Movie movie;
	@Autowired(required = false)
	private MovieInfo movieInfo;
	@Autowired(required = false)
	private Branch branch;

}
