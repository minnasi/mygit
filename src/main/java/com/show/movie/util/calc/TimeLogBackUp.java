package com.show.movie.util.calc;

import java.util.ArrayList;
import java.util.List;

import com.show.movie.model.domain.MovieInfo;

public class TimeLogBackUp<T> {
	public TimeLogBackUp() {}
		private T t;
		public void set(T t) {
			this.t = t;
		}
		public T get() {
			return t;
		}
	
		
		public String transStartTime(int time) {
			return  transFormat(time, 0)[0]+":"+transFormat(time, 0)[1];
		}
		public String transEndTime(int time, int movieTime) {
			return transFormat(time, movieTime)[0]+":"+transFormat(time, movieTime)[1];
		}
		
		/**
		 * @param time : hour or min
		 *        movieTime : EndTime값을 구할때 넣어주고 아니면 0     
		 * */
		public String[] transFormat(int time, int movieTime) {
			String transStartTimeStringFormat = String.format("%02d", ( (time+10) / 60 ) );
			String transEndTimeStringFormat = String.format("%02d", ( (time+10) % 60 ) );
			String[] returnValue = new String[] {transStartTimeStringFormat, transEndTimeStringFormat};
			return returnValue;
		}
		
		public int parseTime(String time) {
			String[] parse = time.split(":");
			return ( Integer.parseInt(parse[0]) * 60 ) + ( Integer.parseInt(parse[1]) );
		}
		public MovieInfo setTime(String startTime, String endTime) {
			MovieInfo movieInfo = new MovieInfo();
			movieInfo.setMovieStartTime(startTime);
			movieInfo.setMovieEndTime(endTime);
			return movieInfo;
		}
		
		
	public List<MovieInfo> calcMovieTime(T list ){ 
		List<MovieInfo> emptyAddMovie = new ArrayList<MovieInfo>();
		try {
			for(List<MovieInfo> mo : (List<List<MovieInfo>>) list) {
				
				int afterTime = 0;
				int calcTime = 0;
				int beforeTime = 0;
				for(int i = 0 ; i < mo.size(); i++) {
					
					afterTime = parseTime(mo.get(i).getMovieStartTime());
					
					if(i != 0 ) {
					beforeTime = parseTime(mo.get(i-1).getMovieStartTime());
					}else {
						beforeTime = afterTime;
					}

					calcTime = afterTime - beforeTime;
					
					int movieTime = mo.get(i).getMovie().getMovieTime();
					System.out.println("-------------------------------------------------------");
					
					System.out.println("앞 시간    :  " +afterTime );
					System.out.println("전 시간    :  " +beforeTime );
					System.out.println("계산한 시간    :  " +calcTime );
					System.out.println("영화 시간    :  "+movieTime);
					System.out.println("지금 상영 시작 시간 :   " +mo.get(i).getMovieStartTime());
					System.out.println("지금 상영 끝 시간 :   " +mo.get(i).getMovieEndTime());
					System.out.println("-------------------------------------------------------");
					int addMovieCount = calcTime / movieTime;
					if( ( addMovieCount > 0  ) ){
						
						System.out.println(" 영화 등록가능 갯수  "+addMovieCount);
						System.out.println(" 영화 등록할 수 있는 시간은  "+ (10+beforeTime));
		
						String startTime = transStartTime(beforeTime);
						String endTime =transEndTime(beforeTime,movieTime); 
						
						for(int j = 0 ; j < addMovieCount; j++) {
							System.out.println(" 영화 등록 가능 시간 시간  "+ startTime);
							System.out.println(" 영화 등록 가능 끝 시간  "+  endTime);
							
							emptyAddMovie.add(setTime(startTime,endTime));
						}
					}
					 
					if(i == mo.size()-1  ) {
						System.out.println("=====================================================");
						System.out.println("영화 등록 시간 ~~ 24시 이전   "+ mo.get(i).getMovieEndTime() );
						int registeredEndTime = parseTime(mo.get(i).getMovieEndTime());
						System.out.println("last 시간"+registeredEndTime);
						int canAddMovieTimeFor24hour = 1500 - registeredEndTime;
						int canAddMovieCount = canAddMovieTimeFor24hour / movieTime;
						System.out.println("영화 끝 ~ 24시까지 몇개 등록할 수 있나여  : "+ canAddMovieCount);
						for(int j = 0 ; j < canAddMovieCount; j++) {
							if( j == 0 ) {
								registeredEndTime += 10;
							}else {
							registeredEndTime += movieTime;
							}
							String startTime = transStartTime(registeredEndTime);
							String endTime =transEndTime(registeredEndTime,movieTime); 
							
							System.out.println(" 영화 등록 가능 시작 시간  "+ startTime);
							System.out.println(" 영화 등록 가능  끝 시간  "+  endTime);
					
							emptyAddMovie.add(setTime(startTime,endTime));
						}
					}
				}
			}
			for(MovieInfo movieInfo : emptyAddMovie) {
				System.out.println("결과값  -  시작시간 :    "+movieInfo.getMovieStartTime() +"     끝 시간 :    "+movieInfo.getMovieEndTime());
			}
		}catch(IndexOutOfBoundsException e) {
			e.printStackTrace();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return emptyAddMovie;
	}

	
}
