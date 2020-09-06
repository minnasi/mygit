package com.show.movie.model.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.show.movie.model.dao.BookingDAO;
import com.show.movie.model.dao.CancellationDAO;
import com.show.movie.model.dao.ViewTableDAO;
import com.show.movie.model.domain.Booking;
import com.show.movie.model.service.BookingService;
import com.show.movie.util.parse.Parser;

@Service("bookingService")
public class BookingServiceImpl implements BookingService {
	
	@Autowired 
	private BookingDAO bookingDAO;
	@Autowired 
	private CancellationDAO cancellationDAO;
	@Autowired
	ViewTableDAO viewTableDAO;
		
	@Override
	public Map<String,Object> getMyPage(String userId) {
		if(viewTableDAO.isView("getBooking") == 0) {
			viewTableDAO.createViewGetBooking();
		}
		
		if(viewTableDAO.isView("cancellation ") == 0) {
			viewTableDAO.createViewCancellation();
		}
		
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("booking", bookingDAO.getAllbooking(userId));
		map.put("cancellationList", cancellationDAO.getAllcancellation(userId));
		return map;
	}
	
	@Override
	public List<Booking> getAllBooking(String userId) {
		return bookingDAO.getAllbooking(userId);
	}
//	@Override
//	public List<Cancellation> getAllcancellation(int bookingState) {
//		return cancellationDAO.getAllcancellation(bookingState);
//	}

//	public void update(int bookingCode) {
//		cancellationDAO.update(bookingCode);
//	}

	@Override
	public void cancelDate(int bookingCode) {
		for(String seatName : new Parser().stringParser(cancellationDAO.getBookingSeat(bookingCode))) {
		cancellationDAO.updateMovieSeat(bookingCode,seatName);
		}
		cancellationDAO.cancelDate(bookingCode);
	}

	@Override
	public void insertBookingInfo(Booking booking) {
		try {
		System.out.println("booking   " + booking);
		//bookingDAO.insertBookingInfo(booking, seatName);
		bookingDAO.insertBookingInfo(booking);
		}
		catch(Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public void updateSeatStatus(String seatNames, int movieInfoCode) {
		
		try {
		for( String seatName : new Parser().stringParser(seatNames)) {
				bookingDAO.updateSeatStatus(seatName, movieInfoCode);
		}
			
			}
			catch(Exception e) {
				e.printStackTrace();
			}
	}



}
