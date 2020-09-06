package com.show.movie.model.domain;

import java.sql.Date;

import org.apache.ibatis.type.Alias;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Configuration
@Getter
@Setter
@ToString
@Alias("cancellation")
public class Cancellation {
	   @Bean("cancellationVO")
	   public Cancellation getCancellation() {
	      return new Cancellation();
	   }
	   private Date cancelDate;
	    private String movieName;
	    private String branchName;
	    private Date movieDate;
	    private String movieStartTime;
	    private int bookingPrice;
}
