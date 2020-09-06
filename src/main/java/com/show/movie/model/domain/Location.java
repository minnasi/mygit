package com.show.movie.model.domain;

import org.apache.ibatis.type.Alias;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Configuration
@Alias("location")
@Getter @Setter @ToString
public class Location {
	public Location() {}
	@Bean(name="locationVO")
	public Location getLocation() {
		return new Location();
	}
	private int locationCode;
	private String locationName;
	private String countBranch;
	public Location(int locationCode, String locationName, String countBranch) {
		super();
		this.locationCode = locationCode;
		this.locationName = locationName;
		this.countBranch = countBranch;
	}
	
}
