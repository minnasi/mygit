	<%@ page language="java" contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
	<%
		request.setCharacterEncoding("UTF-8");
	%>
	<!DOCTYPE html>
	<html>
	<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	
	<link href="/css/component.css" rel="stylesheet">
	<link href="/css/megabox.min.css" rel="stylesheet">
	<link href="/css/main.css" rel="stylesheet">
	<link href="/css/custom.css" rel="stylesheet">
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<!-- <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" rel="stylesheet"> -->
	</head>
	<body>
		<div class="container">
			<c:import url="/resources/common/header.jsp"></c:import>
			<div class="inner-wrap"
				style="padding-top: 40px; padding-bottom: 100px;">
				<div class="quick-reserve">
					<h2 class="tit">빠른예매</h2>
					<div class="topLevel">
						<div class="seat-select-section">
							<div class="seat-section">
								<div class="tit-util">
									<!-- 최대 8명까지만 선택 .. 그리고 화살표로 내려서 8까지만 나오게 하고 싶다. -->
									<h3 class="tit small">
	
										관람 인원 선택 <select class="selectBox" id="selectBox" name="numberOf" size="1" onchange="OnChange();">
											<option value="select">인원 선택</option>
											<option value="1">1</option>
											<option value="2">2</option>
											<option value="3">3</option>
											<option value="4">4</option>
											<option value="5">5</option>
											<option value="6">6</option>
											<option value="7">7</option>
											<option value="8">8</option>
										</select>
									</h3>
	
								</div>
	
								<div
									style="padding-left: 40px; padding-right: 40px; padding-top: 30px">
									<table width="90%" align="center">
										<tr>
											<td colspan="2" align="center"
												style="background-color: gray; height: 50px">스크린</td>
										</tr>
										<tr>
											<td colspan="2"><br></td>
										</tr>
																				
									</table>
	
	
								</div>
	
	
								<div class="seat-layout">
									<div class="plan plan--shown">
										<div class="rows rows--mini">
	
											<div class="row">
												<c:forEach items="${seatList}" var="seat"  begin="0" end="9">
												<div class="row__seat " id="${seat.seatName}" 
													data-area="${seat.seatStatus}">${seat.seatName}</div>
											</c:forEach>
											</div>
	
											<div class="row">
												<c:forEach items="${seatList}" var="seat"  begin="10" end="19">
												<div class="row__seat " id="${seat.seatName}" 
													data-area="${seat.seatStatus}">${seat.seatName}</div>
											</c:forEach>
											</div>
	
	
	
											<div class="row">
												<c:forEach items="${seatList}" var="seat"  begin="20" end="29">
												<div class="row__seat " id="${seat.seatName}" 
													data-area="${seat.seatStatus}">${seat.seatName}</div>
											</c:forEach>
											</div>
											<div class="row">
												<c:forEach items="${seatList}" var="seat"  begin="30" end="39">
												<div class="row__seat " id="${seat.seatName}" 
													data-area="${seat.seatStatus}">${seat.seatName}</div>
											</c:forEach>
											</div>
											<div class="row">
												<c:forEach items="${seatList}" var="seat"  begin="40" end="49">
												<div class="row__seat " id="${seat.seatName}" 
													data-area="${seat.seatStatus}">${seat.seatName}</div>
											</c:forEach>
											</div>
											<div class="row">
												<c:forEach items="${seatList}" var="seat"  begin="50" end="59">
												<div class="row__seat " id="${seat.seatName}" 
													data-area="${seat.seatStatus}">${seat.seatName}</div>
											</c:forEach>
											</div>
											<div class="row">
												<c:forEach items="${seatList}" var="seat"  begin="60" end="69">
												<div class="row__seat " id="${seat.seatName}" 
													data-area="${seat.seatStatus}">${seat.seatName}</div>
											</c:forEach>
											</div>
											<div class="row">
												<c:forEach items="${seatList}" var="seat"  begin="70" end="79">
												<div class="row__seat " id="${seat.seatName}" 
													data-area="${seat.seatStatus}">${seat.seatName}</div>
											</c:forEach>
											</div>
											<div class="row">
												<c:forEach items="${seatList}" var="seat"  begin="80" end="89">
												<div class="row__seat " id="${seat.seatName}" 
													data-area="${seat.seatStatus}">${seat.seatName}</div>
											</c:forEach>
											</div>
											<div class="row">
												<c:forEach items="${seatList}" var="seat"  begin="90" end="99">
												<div class="row__seat " id="${seat.seatName}" 
													data-area="${seat.seatStatus}" >${seat.seatName}</div>
											</c:forEach>
											</div>
							
	
										<!-- /rows -->
										<ul class="legend">
											<li class="legend__item legend__item--free">선택가능</li>
											<li class="legend__item legend__item--reserved">선택불가</li>
											<li class="legend__item legend__item--selected">선택된 좌석</li>
										</ul>
									</div>
								</div>
							</div>

	
							<form action="/kakaoPay" method="post" id="kakaoPay">
								<div class="seat-result">
									<div class="wrap">
										<div class="tit-area">
											<input type="hidden" name="movieName"
												value="${movieInfo.movie.movieName}"> <input
												type="hidden" name="moviePrice" value="8000"> <span
												class="movie-grade small age-all age-15">15세이상관람가</span>
											<p class="tit" name="movieName">${movieInfo.movie.movieName}</p>
											<p class="cate">2D(자막)</p>
										</div>
										<div class="info-area">
											<%-- <p class="theater">${movieInfo.branch.branchName }점</p> --%>
											<p class="special">${movieInfo.theater.theaterName}</p>
											<p class="date">
												<span>${movieInfo.movieDate}</span><em></em> 
												<script>
											 	var date = new Date( '2020-04-07' ).getDay();
											 	var week = new Array('일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일');
											 	var getDay = week[date];
											 	$('.date').find('em').text('('+getDay+')');
											 </script>
	
											</p>
											<div class="other-time">
												<button type="button" class="now">
													${movieInfo.movieStartTime}~${movieInfo.movieEndTime}<i
														class="arr"></i>
												</button>
												<ul class="other">
													<li><button type="button" choicnt="48"
															playschdlno="2003191372070" class="btn on ">
															${movieInfo.movieStartTime}~${movieInfo.movieEndTime}</button></li>
												</ul>
											</div>
											<p class="poster">
												<img src="/img/${movieInfo.movie.moviePoster}" alt="영화없오요">
											</p>
										</div>
										
										
									
										<div class="info-area" id="test" data-area="selectedSeat" value=""> 
										
										</div>
										
										
										
										
										
										
										<div class="pay-area">
											<p class="count"></p>
											<div class="pay">
												<p class="tit">최종결제금액</p>
												<div class="money" id="money">
													<input type="hidden" name="totalPeople" value="1" id="totalPeople">
													<input type="hidden" name="totalPrice" value="0" id="totalPrice">
													<p class="total" id="total"><em>0</em><span>원</span></p>
												</div>
											</div>
										</div>
										<div class="btn-group">
											 <a href="" class="button active"
												onclick="return false" id="pageNext" title="결제하기">결제하기</a>
										</div>                                                                       
									</div>
	
								</div>
							</form>
						</div>



					</div>
				</div>
			</div>
		</div>
</div>

		<script src="/js/common.js"></script>
		<script src="/js/ticketting.js"></script>
	</body>
	</html>