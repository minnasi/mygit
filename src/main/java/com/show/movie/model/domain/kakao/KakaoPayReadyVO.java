package com.show.movie.model.domain.kakao;

import java.util.Date;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Configuration
@Getter @Setter @ToString
public class KakaoPayReadyVO {
	
	@Bean("kakaoPayVO")
	public KakaoPayReadyVO kakaoPayReadyVO() {
		return new KakaoPayReadyVO();
	}
	
    //response
    private String tid;
    private String next_redirect_pc_url;
    private Date created_at;
    
    
    
}
