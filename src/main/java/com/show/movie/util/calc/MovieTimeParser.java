package com.show.movie.util.calc;

import com.show.movie.model.domain.MovieInfo;

public class MovieTimeParser {
	public String transStartTime(int time) {
		return transFormat(time, 0)[0] + ":" + transFormat(time, 0)[1];
	}

	public String transEndTime(int time, int movieTime) {
		return transFormat(time, movieTime)[0] + ":" + transFormat(time, movieTime)[1];
	}

	/**
	 * @param time : hour or min , movieTime : EndTime값을 구할때 넣어주고 아니면 0
	 */
	public String[] transFormat(int time, int movieTime) {
		String transStartTimeStringFormat = String.format("%02d", ((time + movieTime + 10) / 60));
		String transEndTimeStringFormat = String.format("%02d", ((time + movieTime + 10) % 60));
		String[] returnValue = new String[] { transStartTimeStringFormat, transEndTimeStringFormat };
		return returnValue;
	}

	public int parseTime(String time) {
		String[] parse = time.split(":");
		return (Integer.parseInt(parse[0]) * 60) + (Integer.parseInt(parse[1]));
	}

	public MovieInfo setTime(String startTime, String endTime) {
		MovieInfo movieInfo = new MovieInfo();
		movieInfo.setMovieStartTime(startTime);
		movieInfo.setMovieEndTime(endTime);
		return movieInfo;
	}
	public String[] times(int time, int movieTime) {
		String startTime = transStartTime(time);
		String endTime = transEndTime(time, movieTime);
		return new String[] { startTime, endTime };
	}
}
