package com.show.movie.model.domain;

import org.apache.ibatis.type.Alias;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Configuration
@Alias("user")
@Getter @Setter @ToString

public class User {
	@Bean(name="userVO")
	public User getUser() {
		return new User();
	}
	private String userId;
	private String userPassword;
	private String userName;
	private String userPhoneNumber;
	private String userBirth;
	private int userSignupCode;
}
