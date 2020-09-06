package com.show.movie.model.domain;

import org.apache.ibatis.type.Alias;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Configuration
@Alias("theater")
@Getter @Setter @ToString
public class Theater {
	@Bean("theaterVO")
	public Theater getTheater() {
		return new Theater();
	}
	
	private int theaterCode;
	private int theaterAllSeat;
	private int theaterLeftSeat;
	private String theaterName;
	private Branch branch;
}
