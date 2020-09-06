package com.show.movie.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.show.movie.model.domain.Booking;
import com.show.movie.model.domain.Seat;

public interface ViewTableDAO {
	// ViewTable 있는지 확인
	public int isView(String viewTableName);
	
	
	// ViewTable 만들기
	
	//예매페이지
	public void createViewGetMovieInfo();
	//영화페이지
	public void createViewMoviePageList();
	//관리자페이지 
	public void createViewTimeSchedule();
	//마이페이지 예매내역
	public void createViewGetBooking();
	//마이페이지 취소내역
	public void createViewCancellation();
	
	// Temp 
	public void createViewTable(String viewTableName);
	
	
}


