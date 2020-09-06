package com.show.movie.model.domain;

import org.apache.ibatis.type.Alias;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;


@Configuration
@Alias("branch")
@Getter @Setter @ToString
public class Branch {
	public Branch() {}
	
	@Bean(name="branchVO")
	public Branch getBranch() {
		return new Branch();
	}
	private int branchCode;
	private String branchName;
	private int movieCount;
	
	@Autowired(required = false)
	private Location location;
	
	public Branch(int branchCode, String branchName, Location location) {
		super();
		this.branchCode = branchCode;
		this.branchName = branchName;
		this.location = location;
	}
	
}
