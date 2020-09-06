package com.show.movie.controller.util.kakao;

import java.net.URI;
import java.net.URISyntaxException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;

import com.show.movie.model.domain.kakao.KakaoPayReadyVO;
import com.show.movie.model.domain.Movie;
import com.show.movie.model.domain.MovieInfo;
import com.show.movie.model.domain.User;
import com.show.movie.model.domain.kakao.KakaoPayApprovalVO;

import lombok.extern.log4j.Log4j;


@Service
@Log4j
public class KakaoPay {
	 private static final String HOST = "https://kapi.kakao.com";
	    
	 	@Autowired
	    private KakaoPayReadyVO kakaoPayReadyVO;
	    private KakaoPayApprovalVO kakaoPayApprovalVO;
	    
	    public String kakaoPayReady(Movie movie, User user,MovieInfo movieInfo) {
	 
	        RestTemplate restTemplate = new RestTemplate();
	 
	        // 서버로 요청할 Header
	        HttpHeaders headers = new HttpHeaders();
	        //카카오 개발자 인증. 꼭 Admin Key로 !
	        headers.add("Authorization", "KakaoAK " + "14a59f898ea44ffd7ef323e0ddcfa713");
	        //response.body를 JSON 타입으로 주기때문에 타입지정
	        headers.add("Accept", MediaType.APPLICATION_JSON_UTF8_VALUE);
	        //보낼때 JSON으로 보낸다.
	        headers.add("Content-Type", MediaType.APPLICATION_FORM_URLENCODED_VALUE + ";charset=utf-8");
	        
	        // 서버로 요청할 Body
	        MultiValueMap<String, String> params = new LinkedMultiValueMap<String, String>();
	        params.add("cid", "TC0ONETIME");					//카카오페이 테스트버전 명시
	        params.add("partner_order_id", "1001");    			//관리자번호
	        params.add("partner_user_id", user.getUserId());	//유저아이디
	        params.add("item_name", movie.getMovieName());		//영화이름
	        params.add("quantity", Integer.toString(movieInfo.getTotalPeople() ));						//영화표 몇 개 구매
	        params.add("total_amount",  Integer.toString(movieInfo.getTotalPrice() ));					//총액
	        params.add("tax_free_amount", "50");				//현금영수증용 
																// ↑ 모두 필수
	        // ↓고정


	        params.add("approval_url", "http://127.0.0.1:5000/kakaoPaySuccess");		
	        params.add("cancel_url", "http://127.0.0.1:5000/kakaoPayCancel");
	        params.add("fail_url", "http://127.0.0.1:5000/kakaoPaySuccessFail");

//	        params.add("approval_url", "http://localhost:5000/kakaoPaySuccess");		
//	        params.add("cancel_url", "http://localhost:5000/kakaoPayCancel");
//	        params.add("fail_url", "http://localhost:5000/kakaoPaySuccessFail");

	        HttpEntity<MultiValueMap<String, String>> body = 
	        		 new HttpEntity<MultiValueMap<String, String>>(params, headers);
	         System.out.println(body);
	        try {
	            kakaoPayReadyVO = restTemplate.postForObject(new URI(HOST + "/v1/payment/ready"), body, KakaoPayReadyVO.class);
	            log.info("kakao결제창 url요청 " + kakaoPayReadyVO);
	           
	            //결제창 url return
	            return kakaoPayReadyVO.getNext_redirect_pc_url();
	 
	        } catch (RestClientException e) {
	            e.printStackTrace();
	            return "/400Error";
	        } catch (URISyntaxException e) {
	        	System.out.println("urlEx");
	            e.printStackTrace();
	        }
	        
	        return "/screen";
	        
	    }
	    
	    public KakaoPayApprovalVO kakaoPayInfo(String pg_token, String userId) {
	 
	        log.info("KakaoPayInfoVO............................................");
	        log.info("-----------------------------");
	        
	        RestTemplate restTemplate = new RestTemplate();
	 
	        // 서버로 요청할 Header
	        HttpHeaders headers = new HttpHeaders();
	        //카카오 개발자 인증. 꼭 Admin Key로 !
	        headers.add("Authorization", "KakaoAK " + "14a59f898ea44ffd7ef323e0ddcfa713");
	        //response.body를 JSON 타입으로 주기때문에 타입지정
	        headers.add("Accept", MediaType.APPLICATION_JSON_UTF8_VALUE);
	        //보낼때 JSON으로 보낸다.
	        headers.add("Content-Type", MediaType.APPLICATION_FORM_URLENCODED_VALUE + ";charset=utf-8");
	 
	        // 서버로 요청할 Body
	        MultiValueMap<String, String> params = new LinkedMultiValueMap<String, String>();
	        params.add("cid", "TC0ONETIME");					//카카오페이 테스트버전 명시
	        params.add("tid", kakaoPayReadyVO.getTid());		//결제완료시 받는 Tid (Ok 표시라고 보면됨)
	        params.add("partner_order_id", "1001");				//관리자번호
	        params.add("partner_user_id", userId);				//유저아이디
	        params.add("pg_token", pg_token);					//결제정보가 담겨있는 url Token
	        
	        													// ↑ 모두 필수
	        HttpEntity<MultiValueMap<String, String>> body = new HttpEntity<MultiValueMap<String, String>>(params, headers);
	        try {
	            kakaoPayApprovalVO = restTemplate.postForObject(new URI(HOST + "/v1/payment/approve"), body, KakaoPayApprovalVO.class);
	            log.info("결제한 정보 가져오기   : " + kakaoPayApprovalVO);
	            
	            //결제정보 return
	            return kakaoPayApprovalVO;
	        
	        } catch (RestClientException e) {
	        	log.info("여기는 kakaoPayInfo ReslClientException   : ");
	            e.printStackTrace();
	            return null;
	        } catch (URISyntaxException e) {
	            // TODO Auto-generated catch block
	            e.printStackTrace();
	        }
	        log.info("null return해유 ㅠㅠ");
	        return null;
	    }
}
