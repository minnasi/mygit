package com.show.movie.util.calc;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.show.movie.model.domain.MovieInfo;

public class MovieTime<T> extends MovieTimeParser{
	public MovieTime() {
	}

	private T t;

	public void set(T t) {
		this.t = t;
	}

	public T get() {
		return t;
	}

	public T calcMovieTime(T list)  {
		
		List<List<MovieInfo>> returnValue = new ArrayList<List<MovieInfo>>();
		 //List<Object> returnValue = new ArrayList<Object>();

		try {

			for (List<MovieInfo> mo : (List<List<MovieInfo>>) list) {
				List<MovieInfo> emptyAddMovie = new ArrayList<MovieInfo>();
				int afterTime = 0;
				int calcTime = 0;
				int beforeTime = 0;
				for (int i = 0; i < mo.size(); i++) {
					int movieTime = 0;
					try {
						movieTime = mo.get(i).getMovie().getMovieTime();
					} catch (NullPointerException e) {
						return null;
					}
					afterTime = parseTime(mo.get(i).getMovieStartTime());
					if (i != 0) {
						beforeTime = parseTime(mo.get(i - 1).getMovieEndTime());
					} else {
						beforeTime = afterTime;
					}
					// 9시부터 최초 등록된 영화상영시간까지 루프
					if (i == 0) {
						int firstMovie = afterTime - 540;
						int firstAddMovieTime = 540;
						int calcFirstMovieTimeCount = firstMovie / movieTime;
						for (int j = 0; j < calcFirstMovieTimeCount; j++) {
							String[] times = times(firstAddMovieTime, movieTime);
							emptyAddMovie.add(setTime(times[0], times[1]));
							firstAddMovieTime += (10 + movieTime);
						}
					}

					// 등록된 상영시간 다음 등록된 상영시간 계산해서 그 사이 등록하고 싶은 영화시간만큼 시간 비었으면 출력
					// ex) 11:00~ 13:00, 18:00 ~ 20:00. 영화시간 128분이면 13:15 ~ 15:23, 15:35~17:43이 뜨게
					calcTime = afterTime - beforeTime;
					int addMovieCount = calcTime / movieTime;
					if ((addMovieCount > 0)) {
						String[] times = times(beforeTime, movieTime);
						for (int j = 0; j < addMovieCount; j++) {
							emptyAddMovie.add(setTime(times[0], times[1]));
						}
					}

					// 마지막 등록된 시간이랑 25시랑 비교해서 그 사이에 무비시간만큼 넣음
					// ex) 마지막 등록된 영화 : 16:05 ~ 18:20 이면 18:35~20:43 .. 등등 3개뜸
					if (i == mo.size() - 1) {
						calcCanAddMovieFor24Hour(mo.get(i).getMovieEndTime(), movieTime, emptyAddMovie);
					}
				}
				returnValue.add(emptyAddMovie);

			}
			for (List<MovieInfo> movieInfos : returnValue) {
				for (MovieInfo movieInfo : movieInfos) {
					System.out.println("결과값   =  시작시간 :    " + movieInfo.getMovieStartTime() + "     끝 시간 :    "
							+ movieInfo.getMovieEndTime());

				}
			}

		} catch (IndexOutOfBoundsException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return (T) returnValue;
	}



	public List<MovieInfo> calcCanAddMovieFor24Hour(String time, int movieTime, List<MovieInfo> emptyAddMovie) {
		System.out.println("24 :  " + time);
		try {
			int registeredEndTime = parseTime(time);
			int canAddMovieTimeFor24hour = 1500 - registeredEndTime;
			int canAddMovieCount = canAddMovieTimeFor24hour / movieTime;
			for (int j = 0; j < canAddMovieCount; j++) {
				if (j == 0) {
					registeredEndTime += 10;
				} else {
					registeredEndTime += movieTime+10;
				}
				String[] times = times(registeredEndTime, movieTime);
				emptyAddMovie.add(setTime(times[0], times[1]));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return emptyAddMovie;
	}


}
