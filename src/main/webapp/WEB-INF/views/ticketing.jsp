<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="/css/megabox.min.css" rel="stylesheet">
<link href="/css/main.css" rel="stylesheet">
<link href="/css/custom.css" rel="stylesheet">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
</head>
<body class="body-iframe">
	<div class="container">
		<c:import url="/resources/common/header.jsp"></c:import>
		<div class="inner-wrap"
			style="padding-top: 40px; padding-bottom: 100px;">
			<input type="hidden" id="playDe" name="playDe" value="2020-03.17">
			<input type="hidden" id="crtDe" name="crtDe" value="2020-03.17">

			<!-- quick-reserve -->
			<div class="quick-reserve">
				<div class="tit-util">
					<h2 class="tit">빠른예매</h2>
				</div>


				<!-- mege-quick-reserve-inculde : 다른 페이지에서 iframe 으로 설정될 영역 -->
				<div class="mege-quick-reserve-inculde">

					<!-- time-schedule -->
					<div class="time-schedule quick">
						<div class="wrap">

							<!-- 이전날짜 -->
							<button type="button" title="이전 날짜 보기" class="btn-pre"
								disabled="true">
								<i class="iconset ico-cld-pre"></i> <em>이전</em>
							</button>
							<!--// 이전날짜 -->

							<div class="date-list">
								<!-- 년도, 월 표시 -->
								<div class="year-area">
									<div class="year" style="left: 30px; z-index: 1; opacity: 1;">2020-04</div>
									<div class="year" style="left: 450px; z-index: 1; opacity: 0;"></div>
								</div>


								<div class="date-area" id="formDeList">
									<div class="wrap"
										style="position: relative; width: 2100px; border: none; left: -70px;">
										<button class="disabled" type="button" value="2020-04-05"
											month="4" tabindex="-1">
											<span class="ir">2020년 4월</span><em
												style="pointer-events: none;">05<span
												style="pointer-events: none;" class="ir">일</span></em><span
												class="day-kr"
												style="pointer-events: none; display: inline-block">일</span><span
												class="day-en" style="pointer-events: none; display: none">Sun</span>
										</button>
										
										<button class="on" type="button" value="2020-04-10"
											month="4">
											<span class="ir">2020년 4월</span><em
												style="pointer-events: none;">10<span
												style="pointer-events: none;" class="ir">일</span></em><span
												class="day-kr"
												style="pointer-events: none; display: inline-block">오늘</span><span
												class="day-en" style="pointer-events: none; display: none">Fri</span>
										</button>
										<button class="sat" type="button" value="2020-04-11"
											month="2">
											<span class="ir">2020년 4월</span><em
												style="pointer-events: none;">11<span
												style="pointer-events: none;" class="ir">일</span></em><span
												class="day-kr"
												style="pointer-events: none; display: inline-block">내일</span><span
												class="day-en" style="pointer-events: none; display: none">Sat</span>
										</button>
										<button class="holi" type="button" value="2020-04-12"
											month="4">
											<span class="ir">2020년 4월</span><em
												style="pointer-events: none;">12<span
												style="pointer-events: none;" class="ir">일</span></em><span
												class="day-kr"
												style="pointer-events: none; display: inline-block">일</span><span
												class="day-en" style="pointer-events: none; display: none">Sun</span>
										</button>
										<button class="" type="button" value="2020-04-13"
											month="4">
											<span class="ir">2020년 4월</span><em
												style="pointer-events: none;">13<span
												style="pointer-events: none;" class="ir">일</span></em><span
												class="day-kr"
												style="pointer-events: none; display: inline-block">월</span><span
												class="day-en" style="pointer-events: none; display: none">Mon</span>
										</button>
										<button class="" type="button" value="2020-04-14"
											month="4">
											<span class="ir">2020년 4월</span><em
												style="pointer-events: none;">14<span
												style="pointer-events: none;" class="ir">일</span></em><span
												class="day-kr"
												style="pointer-events: none; display: inline-block">화</span><span
												class="day-en" style="pointer-events: none; display: none">Tue</span>
										</button>
										<button class="disabled" type="button" value="2020-04-15"
											month="4">
											<span class="ir">2020년 4월</span><em
												style="pointer-events: none;">15<span
												style="pointer-events: none;" class="ir">일</span></em><span
												class="day-kr"
												style="pointer-events: none; display: inline-block">수</span><span
												class="day-en" style="pointer-events: none; display: none">Wen</span>
										</button>
										<button class="disabled" type="button" value="2020-04-16"
											month="4">
											<span class="ir">2020년 4월</span><em
												style="pointer-events: none;">16<span
												style="pointer-events: none;" class="ir">일</span></em><span
												class="day-kr"
												style="pointer-events: none; display: inline-block">목</span><span
												class="day-en" style="pointer-events: none; display: none">Thu</span>
										</button>
										<button class="disabled" type="button" value="2020-04-17"
											month="4">
											<span class="ir">2020년 4월</span><em
												style="pointer-events: none;">17<span
												style="pointer-events: none;" class="ir">일</span></em><span
												class="day-kr"
												style="pointer-events: none; display: inline-block">금</span><span
												class="day-en" style="pointer-events: none; display: none">Fri</span>
										</button>
										<button class="disabled" type="button" value="2020-04-18"
											month="4">
											<span class="ir">2020년 4월</span><em
												style="pointer-events: none;">18<span
												style="pointer-events: none;" class="ir">일</span></em><span
												class="day-kr"
												style="pointer-events: none; display: inline-block">토</span><span
												class="day-en" style="pointer-events: none; display: none">Sat</span>
										</button>
										<button class="disabled" type="button" value="2020-04-19"
											month="4">
											<span class="ir">2020년 4월</span><em
												style="pointer-events: none;">19<span
												style="pointer-events: none;" class="ir">일</span></em><span
												class="day-kr"
												style="pointer-events: none; display: inline-block">일</span><span
												class="day-en" style="pointer-events: none; display: none">Sun</span>
										</button>
										<button class="" type="button" value="2020-04-20">
											<span class="ir">2020년 4월</span><em
												style="pointer-events: none;">20<span
												style="pointer-events: none;" class="ir">일</span></em><span
												class="day-kr"
												style="pointer-events: none; display: inline-block">월</span><span
												class="day-en" style="pointer-events: none; display: none">Mon</span>
										</button>
										<button class="" type="button" value="2020-04-21"
											month="4">
											<span class="ir">2020년 4월</span><em
												style="pointer-events: none;">21<span
												style="pointer-events: none;" class="ir">일</span></em><span
												class="day-kr"
												style="pointer-events: none; display: inline-block">화</span><span
												class="day-en" style="pointer-events: none; display: none">Tue</span>
										</button>
										<button class="" type="button" value="2020-04-22"
											month="4">
											<span class="ir">2020년 4월</span><em
												style="pointer-events: none;">22<span
												style="pointer-events: none;" class="ir">일</span></em><span
												class="day-kr"
												style="pointer-events: none; display: inline-block">수</span><span
												class="day-en" style="pointer-events: none; display: none">Wen</span>
										</button>
										<button class="" type="button" value="2020-04-23"
											month="4">
											<span class="ir">2020년 4월</span><em
												style="pointer-events: none;">23<span
												style="pointer-events: none;" class="ir">일</span></em><span
												class="day-kr"
												style="pointer-events: none; display: inline-block">목</span><span
												class="day-en" style="pointer-events: none; display: none">Thu</span>
										</button>
										
										<button class="disabled" type="button" value="2020-04-24"
											month="4" tabindex="-1">
											<span class="ir">2020년 4월</span><em
												style="pointer-events: none;">24<span
												style="pointer-events: none;" class="ir">일</span></em><span
												class="day-kr"
												style="pointer-events: none; display: inline-block">금</span><span
												class="day-en" style="pointer-events: none; display: none">Fri</span>
										</button>
									</div>
								</div>
							</div>

							<!-- 다음날짜 -->
							<button type="button" title="다음 날짜 보기" class="btn-next">
								<i class="iconset ico-cld-next"></i> <em>다음</em>
							</button>
							<!--// 다음날짜 -->

							<!-- 달력보기 -->
							<div class="bg-line">
								<input type="hidden" id="datePicker" value="2020-04-17"
									class="hasDatepicker">
								<button type="button" id="calendar"
									onclick="$('#datePicker').datepicker('show')"
									class="btn-calendar-large" title="달력보기">달력보기</button>

							</div>
							<!--// 달력보기 -->
						</div>
					</div>
					<!--// time-schedule -->

					<!-- quick-reserve-area -->
					<div class="quick-reserve-area">

						<!-- movie-choice : 영화 선택  -->
						<div class="movie-choice">
							<p class="tit">영화</p>

							<!-- list-area -->
							<div class="list-area">

								<!-- all : 전체 -->
								<div class="all-list">
									<button type="button" class="btn-tab on" id="movieAll">전체</button>
									<div class="list">
									<input type="hidden" value="${movie.movieName}" id="ticketMovieName">
										<div class="scroll m-scroll mCustomScrollbar _mCS_1"
											id="movieList">
											<div id="mCSB_1"
												class="mCustomScrollBox mCS-light mCSB_vertical mCSB_inside"
												style="max-height: none;" tabindex="0">
												<div id="mCSB_1_container" class="mCSB_container"
													style="position: relative; left: 0px;"
													dir="ltr">
													<ul>
														<c:forEach items="${movies.movieList }" var="movieList" varStatus="status">
																<li>
																	<button type="button" class="btn" value="${movieList.movieName }" disabled>
																		<i
																			class="iconset ico-heart-small">보고싶어 설정안함</i>
																			<c:choose>
																				<c:when test="${status.index % 4 eq 0}">
																					<span class="movie-grade small age-12">12세이상관람가</span>
																				</c:when>
																				
																				<c:when test="${status.index % 4 eq 2}">
																					<span class="movie-grade small age-15">15세이상관람가</span>
																				</c:when>
																				
																				<c:when test="${status.index % 8 eq 5}">
																					<span class="movie-grade small age-19">19세이상관람가</span>
																				</c:when>
																				
																				<c:otherwise>
																					<span class="movie-grade small age-all">전체관람가</span>
																				</c:otherwise>
																			</c:choose>
																			<span
																			class="txt">${movieList.movieName }</span>
																	</button>
																</li>
														</c:forEach>
														
														<c:forEach items="${movies.movie }" var="movie">
															<input type="hidden" value="${movie.movieName }" class="regisMovie" name="regisMovie">
														</c:forEach>
														
													</ul>
												</div>
											</div>
										</div>
									</div>
								</div>
								
								<!--// 영화탭 끝  -->
								<div class="other-list">
									<button type="button" class="btn-tab" id="movieCrtn">큐레이션</button>
								</div>

							</div>
						</div>
						<!--// 영화선택 끝  -->
						<!--// movie-choice : 영화 선택  -->

						<!-- theater-choice : 극장 선택  -->
						<div class="theater-choice">
							<div class="tit-area">
								<p class="tit">극장</p>
							</div>

							<!-- list-area -->
							<div class="list-area" id="brchTab">

								<!-- all-list : 전체 -->
								<div class="all-list">
									<button type="button" class="btn-tab on">전체</button>
									<div class="list">
										<div class="scroll" id="brchList">
											<ul>
												<li><button type="button" class="btn" id="10" value="강북구">
														<span calss="txt">강북구</span>
													</button>
													<%--  실제 구현할때 style 빼세요 --%>
													<div class="depth" style="display:flex; " >
														<div
															class="detail-list m-scroll area-cd10 mCustomScrollbar _mCS_4 mCS_no_scrollbar">
															<div id="mCSB_4"
																class="mCustomScrollBox mCS-light mCSB_vertical mCSB_inside"
																style="max-height: none;" tabindex="0">
																<div id="mCSB_4_container"
																	class="mCSB_container mCS_no_scrollbar_y"
																	style="position: relative; top: 0; left: 0;" dir="ltr">
																	<ul>
																		

																	</ul>
																</div>
															</div>
														</div>
													</div></li>
												<li><button type="button" class="btn" id="30" value="노원구">
														<span calss="txt">노원구</span>
													</button>
													<div class="depth">
														<div
															class="detail-list m-scroll area-cd30 mCustomScrollbar _mCS_5 mCS_no_scrollbar">
															<div id="mCSB_5"
																class="mCustomScrollBox mCS-light mCSB_vertical mCSB_inside"
																style="max-height: none;" tabindex="0">
																<div id="mCSB_5_container"
																	class="mCSB_container mCS_no_scrollbar_y"
																	style="position: relative; top: 0; left: 0;" dir="ltr">
																	<ul>
																		

																	</ul>
																</div>
																<div id="mCSB_5_scrollbar_vertical"
																	class="mCSB_scrollTools mCSB_5_scrollbar mCS-light mCSB_scrollTools_vertical">
																	<div class="mCSB_draggerContainer">
																		<div id="mCSB_5_dragger_vertical" class="mCSB_dragger"
																			style="position: absolute; min-height: 30px; display: none; top: 0px;">
																			<div class="mCSB_dragger_bar"
																				style="line-height: 30px;"></div>
																		</div>
																		<div class="mCSB_draggerRail"></div>
																	</div>
																</div>
															</div>
														</div>
													</div></li>
												<li><button type="button" class="btn" id="35" value="동대문구">
														<span calss="txt">동대문구</span>
													</button>
													<div class="depth">
														<div
															class="detail-list m-scroll area-cd35 mCustomScrollbar _mCS_6 mCS_no_scrollbar">
															<div id="mCSB_6"
																class="mCustomScrollBox mCS-light mCSB_vertical mCSB_inside"
																style="max-height: none;" tabindex="0">
																<div id="mCSB_6_container"
																	class="mCSB_container mCS_no_scrollbar_y"
																	style="position: relative; top: 0; left: 0;" dir="ltr">
																	<ul>
																	

																	</ul>
																</div>
																<div id="mCSB_6_scrollbar_vertical"
																	class="mCSB_scrollTools mCSB_6_scrollbar mCS-light mCSB_scrollTools_vertical">
																	<div class="mCSB_draggerContainer">
																		<div id="mCSB_6_dragger_vertical" class="mCSB_dragger"
																			style="position: absolute; min-height: 30px; display: none; top: 0px;">
																			<div class="mCSB_dragger_bar"
																				style="line-height: 30px;"></div>
																		</div>
																		<div class="mCSB_draggerRail"></div>
																	</div>
																</div>
															</div>
														</div>
													</div></li>
												<li><button type="button" class="btn" id="45" value="성동구">
														<span calss="txt">성동구</span>
													</button>
													<div class="depth">
														<div
															class="detail-list m-scroll area-cd45 mCustomScrollbar _mCS_7 mCS_no_scrollbar">
															<div id="mCSB_7"
																class="mCustomScrollBox mCS-light mCSB_vertical mCSB_inside"
																style="max-height: none;" tabindex="0">
																<div id="mCSB_7_container"
																	class="mCSB_container mCS_no_scrollbar_y"
																	style="position: relative; top: 0; left: 0;" dir="ltr">
																	<ul>
																		

																	</ul>
																</div>
																<div id="mCSB_7_scrollbar_vertical"
																	class="mCSB_scrollTools mCSB_7_scrollbar mCS-light mCSB_scrollTools_vertical">
																	<div class="mCSB_draggerContainer">
																		<div id="mCSB_7_dragger_vertical" class="mCSB_dragger"
																			style="position: absolute; min-height: 30px; display: none; top: 0px;">
																			<div class="mCSB_dragger_bar"
																				style="line-height: 30px;"></div>
																		</div>
																		<div class="mCSB_draggerRail"></div>
																	</div>
																</div>
															</div>
														</div>
													</div></li>
												<li><button type="button" class="btn" id="55" value="강남구">
														<span calss="txt">강남구</span>
													</button>
													<div class="depth">
														<div
															class="detail-list m-scroll area-cd55 mCustomScrollbar _mCS_8 mCS_no_scrollbar">
															<div id="mCSB_8"
																class="mCustomScrollBox mCS-light mCSB_vertical mCSB_inside"
																style="max-height: none;" tabindex="0">
																<div id="mCSB_8_container"
																	class="mCSB_container mCS_no_scrollbar_y"
																	style="position: relative; top: 0; left: 0;" dir="ltr">
																	<ul>
																	
																	</ul>
																</div>
																<div id="mCSB_8_scrollbar_vertical"
																	class="mCSB_scrollTools mCSB_8_scrollbar mCS-light mCSB_scrollTools_vertical">
																	<div class="mCSB_draggerContainer">
																		<div id="mCSB_8_dragger_vertical" class="mCSB_dragger"
																			style="position: absolute; min-height: 30px; display: none; top: 0px;">
																			<div class="mCSB_dragger_bar"
																				style="line-height: 30px;"></div>
																		</div>
																		<div class="mCSB_draggerRail"></div>
																	</div>
																</div>
															</div>
														</div>
													</div></li>
												<li><button type="button" class="btn" id="65" value="서초구">
														<span calss="txt">서초구</span>
													</button>
													<div class="depth">
														<div
															class="detail-list m-scroll area-cd65 mCustomScrollbar _mCS_9 mCS_no_scrollbar">
															<div id="mCSB_9"
																class="mCustomScrollBox mCS-light mCSB_vertical mCSB_inside"
																style="max-height: none;" tabindex="0">
																<div id="mCSB_9_container"
																	class="mCSB_container mCS_no_scrollbar_y"
																	style="position: relative; top: 0; left: 0;" dir="ltr">
																	<ul>
																		
																	</ul>
																</div>
																<div id="mCSB_9_scrollbar_vertical"
																	class="mCSB_scrollTools mCSB_9_scrollbar mCS-light mCSB_scrollTools_vertical">
																	<div class="mCSB_draggerContainer">
																		<div id="mCSB_9_dragger_vertical" class="mCSB_dragger"
																			style="position: absolute; min-height: 30px; display: none; top: 0px;">
																			<div class="mCSB_dragger_bar"
																				style="line-height: 30px;"></div>
																		</div>
																		<div class="mCSB_draggerRail"></div>
																	</div>
																</div>
															</div>
														</div>
													</div></li>
												<li><button type="button" class="btn" id="70" value="동작구">
														<span calss="txt">동작구</span>
													</button>
													<div class="depth">
														<div
															class="detail-list m-scroll area-cd70 mCustomScrollbar _mCS_10 mCS_no_scrollbar">
															<div id="mCSB_10"
																class="mCustomScrollBox mCS-light mCSB_vertical mCSB_inside"
																style="max-height: none;" tabindex="0">
																<div id="mCSB_10_container"
																	class="mCSB_container mCS_no_scrollbar_y"
																	style="position: relative; top: 0; left: 0;" dir="ltr">
																	<ul>
																	

																	</ul>
																</div>
																<div id="mCSB_10_scrollbar_vertical"
																	class="mCSB_scrollTools mCSB_10_scrollbar mCS-light mCSB_scrollTools_vertical">
																	<div class="mCSB_draggerContainer">
																		<div id="mCSB_10_dragger_vertical"
																			class="mCSB_dragger"
																			style="position: absolute; min-height: 30px; display: none; top: 0px;">
																			<div class="mCSB_dragger_bar"
																				style="line-height: 30px;"></div>
																		</div>
																		<div class="mCSB_draggerRail"></div>
																	</div>
																</div>
															</div>
														</div>
													</div></li>
												<li><button type="button" class="btn" id="80" value="관악구">
														<span calss="txt">관악구</span>
													</button>
													<div class="depth">
														<div
															class="detail-list m-scroll area-cd80 mCustomScrollbar _mCS_11 mCS_no_scrollbar">
															<div id="mCSB_11"
																class="mCustomScrollBox mCS-light mCSB_vertical mCSB_inside"
																style="max-height: none;" tabindex="0">
																<div id="mCSB_11_container"
																	class="mCSB_container mCS_no_scrollbar_y"
																	style="position: relative; top: 0; left: 0;" dir="ltr">
																	<ul>
																
																	</ul>
																</div>
																<div id="mCSB_11_scrollbar_vertical"
																	class="mCSB_scrollTools mCSB_11_scrollbar mCS-light mCSB_scrollTools_vertical">
																	<div class="mCSB_draggerContainer">
																		<div id="mCSB_11_dragger_vertical"
																			class="mCSB_dragger"
																			style="position: absolute; min-height: 30px; display: none; top: 0px;">
																			<div class="mCSB_dragger_bar"
																				style="line-height: 30px;"></div>
																		</div>
																		<div class="mCSB_draggerRail"></div>
																	</div>
																</div>
															</div>
														</div>
													</div></li>
											</ul>
										</div>
									</div>
								</div>
								<!--// all-list : 전체 -->

								<!-- other-list : 특별관 -->
								<div class="other-list">
									<button type="button" class="btn-tab">특별관</button>
									<!-- list -->
									<div class="list" id="specialBrchTab">
										<div class="scroll" id="specialBrchList">
											<ul>
												
												
											</ul>
										</div>
									</div>
									<!--// list -->
								</div>
								<!--// other-list : 특별관 -->
							</div>
							<!--// list-area -->

							<!-- view-area -->

							<!--// view-area -->


						</div>
						<!--// theater-choice : 영화관 선택  -->

						<!-- time-choice : 상영시간표 선택 -->
						<div class="time-choice">
							<div class="tit-area">
								<p class="tit">시간</p>


							</div>

							<!-- hour-schedule : 시간 선택  : 00~30 시-->

							<!--// hour-schedule : 시간 선택  : 00~30 시-->

							<!-- movie-schedule-area : 시간표 출력 영역-->
							<div class="movie-schedule-area">




								<!-- 영화, 영화관 선택 했을때 -->
								<div class="result">
									<div
										class="scroll m-scroll mCustomScrollbar _mCS_21 mCS_no_scrollbar"
										id="playScheduleList" >
										<div id="mCSB_21"
											class="mCustomScrollBox mCS-light mCSB_vertical mCSB_inside"
											style="max-height: none;" tabindex="0">
											<div id="mCSB_21_container"
												class="mCSB_container mCS_no_scrollbar_y"
												style="position: relative; top: 0; left: 0;" dir="ltr">
												<ul>
													
												</ul>
											</div>
											
																			<!-- 영화, 영화관 선택 안했을때 -->
								<!---->
								<div class="no-result" id="playScheduleNonList" style="display: block;">
									<i class="iconset ico-movie-time"></i>

									<p class="txt">
										영화와 극장을 선택하시면<br> 상영시간표를 비교하여 볼 수 있습니다.
									</p>
								</div>
								
								<div class="result0 no-result" id="playScheduleNonList" style="display:none">
									
									 <!-- <i class="iconset ico-tab-theater"></i> -->
									 <!-- <i class="iconset ico-tab-special"></i> --> 
									 <i class="iconset ico-tab-movie"></i>

									<p class="txt">죄송합니다. 극장에 해당 영화를 상영중이지 않습니다.<br></p>
								</div>
										</div>
									</div>

								</div>

							</div>
						</div>
						<!--// movie-schedule-area : 시간표 출력 영역-->

					</div>
					<!--// time-choice : 상영시간표 선택 -->
				</div>
				<!--// quick-reserve-area -->
			</div>
			<!--// mege-quick-reserve-inculde : 다른 페이지에서 iframe 으로 설정될 영역 -->

		</div>
		<!--// quick-reserve -->

		<c:import url="/resources/common/footer.jsp"></c:import>
	</div>
	<script src="/js/ticketting.js"></script>
</body>
</html>