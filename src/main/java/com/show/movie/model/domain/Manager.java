package com.show.movie.model.domain;

import org.apache.ibatis.type.Alias;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter @Getter @ToString
@Alias("manager")
@Configuration
public class Manager {
	@Bean("managerVO")
	public Manager getManager() {
		return new Manager();
	}
	
	private int managerCode;
	private String managerId;
	private String managerPassword;
	private String managerName;
}
