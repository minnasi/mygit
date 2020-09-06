package com.show.movie.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.show.movie.model.dao.BookingDAO;
import com.show.movie.model.domain.Booking;
import com.show.movie.model.domain.Cancellation;
import com.show.movie.model.domain.Seat;

import lombok.extern.log4j.Log4j;



public interface BookingService {
	public Map<String,Object> getMyPage(String userId);
	List<Booking> getAllBooking(String userId);
//    List<Cancellation> getAllcancellation(String userId);
    void cancelDate(int bookingCode); 
  //  public void update(int bookingCode) ;
    
   
    
    //정민
    public void insertBookingInfo(Booking booking);
    //public void insertBookingInfo(Booking booking, List<String> seatName);
    public void updateSeatStatus(String seatName,int theaterCode);
}
