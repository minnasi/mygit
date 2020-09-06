package com.show.movie.model.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.show.movie.model.dao.ManagerDAO;
import com.show.movie.model.dao.MovieDAO;
import com.show.movie.model.dao.ViewTableDAO;
import com.show.movie.model.domain.Branch;
import com.show.movie.model.domain.Location;
import com.show.movie.model.domain.Movie;
import com.show.movie.model.domain.MovieInfo;
import com.show.movie.model.domain.Theater;
import com.show.movie.model.service.ManagerService;

import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class ManagerServiceImpl implements ManagerService {

	@Autowired
	ManagerDAO managerDAO;
	
	@Autowired
	ViewTableDAO viewTableDAO;
	

	@Override
	public void insertMovie(Movie movie) {
		String images[] = movie.getMovieImages().split(",");
		movie.setMoviePoster(images[0]);
		if (images.length > 1)
			movie.setMoviePosterBG(images[1]);
		managerDAO.insertMovie(movie);
	}

	@Override
	public HashMap<String, Object> getMovieList(String managerId) {
		HashMap<String, Object> data = new HashMap<String, Object>();
		data.put("movie", managerDAO.getMovieList(managerId));
		data.put("location", managerDAO.getLocationList());
		data.put("branch", managerDAO.getBranchList());
		return data;
	}

	@Override
	public List<Branch> getBranchList(Location location) {
		return managerDAO.getBranchList(location);
	}

	@Override
	public List<Theater> getTheaterList(String branchName) {
		return managerDAO.getTheaterList(branchName);
	}

	@Override
	public void insertTheater(String movieDate,String movieName, 
			List<String> theaterName,List<String> movieStartTime, List<String> movieEndTime) {
		int lastTheaterCode = managerDAO.lastMovieInfoCode();
		
		managerDAO.insertTheater(movieDate,movieName, theaterName, movieStartTime, movieEndTime);
		
		// 메소드화 시켰어야됬는데 ㅜㅜ  시간이 없옹 . 하드코딩  ON !
		String data[] = {"A","B","C","D","E","F","G","H","I","J"};
		for(int i = 1 ; i <= managerDAO.countTheater()-lastTheaterCode; i++) {
			for(int j = 0 ; j < 10; j++) {
					for(int z = 1; z <= 10; z++) {
						managerDAO.insertSeat(lastTheaterCode+i, (data[j]+Integer.toString(z))  );
					}
				}
		}
		
	}

	
	@Override
	public void insertSeat() {
		
		String data[] = {"A","B","C","D","E","F","G","H","I","J"};
		
		for(int i = 1 ; i <= managerDAO.countTheater(); i++) {
			for(int j = 0 ; j < 10; j++) {
				for(int z = 1; z <= 10; z++) {
					managerDAO.insertSeat(i, (data[j]+Integer.toString(z))  );
				}
			}
		}
	}
	
	
	@Override
	public List<List<MovieInfo>> getTimeScheduleInTheater(List<String> theaterNumbers, String timeSchedule) {

		if (viewTableDAO.isView("timeSchedule") == 0) {
			viewTableDAO.createViewTimeSchedule();
		}
		
		List<List<MovieInfo>> list = new ArrayList<List<MovieInfo>>();
		try {
		for (String theaterNo : theaterNumbers) {
			List<MovieInfo> movieInfoList = managerDAO.getTimeScheduleInTheater(theaterNo, timeSchedule);
			if(movieInfoList.size() == 0 ) {
				MovieInfo movieInfo = new MovieInfo();
				Theater theater = new Theater();
				theater.setTheaterCode(Integer.parseInt(theaterNo));
				movieInfo.setTheater(theater);
				movieInfoList.add(movieInfo);
				list.add(movieInfoList);
			}else {
				list.add(movieInfoList);
			}
		}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
}
