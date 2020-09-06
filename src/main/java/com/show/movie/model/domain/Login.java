package com.show.movie.model.domain;

import org.apache.ibatis.type.Alias;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Configuration
@Alias("login")
@Getter @Setter @ToString

public class Login {
	@Bean(name="loginVO")
	public Login getLogin() {
		return new Login();
	}
	private String userId;
	private String userPassword;
	private int userSignupCode;
//	private boolean useCookie;
//	public String encrypt;

}
