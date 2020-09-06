package com.show.movie.util.calc;

import java.util.ArrayList;
import java.util.List;

import com.show.movie.model.domain.MovieInfo;

public class TimeDoneBackUp<T> {
	public TimeDoneBackUp() {}
		private T t;
		public void set(T t) {
			this.t = t;
		}
		public T get() {
			return t;
		}
	
	public List<MovieInfo> calcMovieTime(T list ){ 
		List<MovieInfo> emptyAddMovie = new ArrayList<MovieInfo>();
		try {
			for(List<MovieInfo> mo : (List<List<MovieInfo>>) list) {
				
				int afterTime = 0;
				int calcTime = 0;
				for(int i = 0 ; i < mo.size(); i++) {
					String[] beforeParse = null;
					int beforeTime = 0;
					
					String[] afterParse = mo.get(i).getMovieStartTime().split(":");
					afterTime = ( Integer.parseInt(afterParse[0]) * 60 ) + Integer.parseInt(afterParse[1]);
					
					if(i != 0 ) {
					beforeParse = mo.get(i-1).getMovieEndTime().split(":");
					beforeTime = ( Integer.parseInt(beforeParse[0]) * 60 ) + Integer.parseInt(beforeParse[1]);
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
						String hour = String.format("%02d", ( (beforeTime+10) / 60 ) );
						String min = String.format("%02d", ( (beforeTime+10) % 60 ) );
						String endHour = String.format("%02d", ( (beforeTime+10+movieTime) / 60 ) ); 
						String endMin = String.format("%02d", ( (beforeTime+10+movieTime) % 60 ) );
						String startTime = hour+":"+min;
						String endTime = endHour+":"+endMin;
						MovieInfo movieInfo = new MovieInfo();
						for(int j = 0 ; j < addMovieCount; j++) {
							System.out.println(" 영화 등록 가능 시간 시간  "+ startTime);
							System.out.println(" 영화 등록 가능 끝 시간  "+  endTime);
							movieInfo.setMovieStartTime(startTime);
							movieInfo.setMovieEndTime(endTime);
							emptyAddMovie.add(movieInfo);
						}
					}
					 
					if(i == mo.size()-1  ) {
						System.out.println("=====================================================");
						System.out.println("영화 등록 시간 ~~ 24시 이전   "+ mo.get(i).getMovieEndTime() );
						String[] parse = mo.get(i).getMovieEndTime().split(":");
						int last = ( Integer.parseInt(parse[0]) * 60 ) + Integer.parseInt(parse[1]);
						System.out.println("last 시간"+last);
						int getLast = 1500 - last;
						int getLastMovie = getLast / movieTime;
						System.out.println("영화 끝 ~ 24시까지 몇개 등록할 수 있나여  : "+ getLastMovie);
						for(int j = 0 ; j < getLastMovie; j++) {
							if( j == 0 ) {
								last += 10;
							}else {
							last += movieTime;
							}
							String hour = String.format("%02d", ( (last+10) / 60 ) );
							String min = String.format("%02d", ( (last+10) % 60 ) ); 
							String endHour = String.format("%02d", ( (last+10+movieTime) / 60 ) );
							String endMin = String.format("%02d", ( (last+10+movieTime) / 60 ) );
							String startTime = hour+":"+min;
							String endTime = endHour+":"+endMin;
							System.out.println(" 영화 등록 가능 시작 시간  "+  hour+":"+min);
							System.out.println(" 영화 등록 가능  끝 시간  "+  endHour+":"+endMin);
							MovieInfo movieInfo = new MovieInfo();
							movieInfo.setMovieStartTime(startTime);
							movieInfo.setMovieEndTime(endTime);
							emptyAddMovie.add(movieInfo);
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
