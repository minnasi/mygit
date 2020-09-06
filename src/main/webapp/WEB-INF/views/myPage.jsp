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
<body>

	<div class="container">
		<c:import url="/resources/common/header.jsp"></c:import>
		<div class="inner-wrap">
			<div id="myLoactionInfo" style="display: none;">
				<div class="location">
					<span>Home</span> <a href="/mypage" title="나의 메가박스 페이지로 이동">나의
						메가박스</a> <a href="/mypage/bookinglist?tab=01" title="예매/구매내역 페이지로 이동">예매/구매내역</a>
				</div>
			</div>

			<!-- container -->
			<div id="contents" class="location-fixed">
				<h2 class="tit">예매/취소 내역</h2>

				<div class="tab-block tab-layer">
					<ul>
						<li data-url="/mypage/bookinglist?tab=01" data-tit="예매내역"
							title="예매내역 탭으로 이동" class="on"><a href="#myBokdArea"
							class="btn">예매 </a></li>

					</ul>
				</div>
				<div class="tab-cont-wrap">

					<!-- 예매내역 -->
					<div id="myBokdArea" class="tab-cont on">
						<a href="" class="ir">예매 탭 화면 입니다.</a>
						<div id="bokdList">
							<div class="board-list-util">
								
							</div>
							<div class="history-reservation">
								<ul>
									<c:forEach items="${bookingList.booking}" var="booking"
										varStatus="status">
										<input type="hidden" id="bookingCode" name="bookingCode" value="${booking.bookingCode }" >
										<li sell-tran-no="13722003170094915348">
											<div class="round" >           <!-- 여기에 추가 :) ->  -->                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
												<a href="" class="img" onclick="return false"
													title="${booking.movie.movieName } "><img
													src=" /img/${booking.movie.moviePoster} "
													alt="이미지없어요" ></a>
												<table class="table">
													<colgroup>
														<col style="width: 75px;">
														<col style="width: 230px;">
														<col style="width: 80px;">
														<col>
													</colgroup>
													<tbody>
														<tr>
															<th scope="row" class="a-r">예매번호</th>
															<td colspan="3"><em class="num">${booking.bookingCode}</em></td>
														</tr>
														<tr>
															<th scope="row" class="a-r">영화명</th>
															<td colspan="3">${booking.movie.movieName}
																<p class="tit-movie">
																	<!-- <span></span>  -->
																	<span>2D(자막)</span>
																</p>
															</td>
														</tr>
														<tr>
															<th scope="row" class="a-r">극장/상영관</th>
															<td>${booking.branch.branchName}/
																${booking.movieInfo.theater.theaterName}</td>
															<th scope="row">관람인원</th>
															<td>${booking.bookingPeople}</td>
														</tr>
														<tr>
															<th scope="row" class="a-r">관람일시</th>
															<td>${booking.movieInfo.movieDate}</td>
															<th scope="row">관람좌석</th>
															<td>${booking.bookingSeat}</td>
														</tr>

													</tbody>
												</table>
												<div class="bg-round">
													<table class="table">
														<colgroup>
															<col style="width: 75px;">
															<col style="width: 230px;">
															<col style="width: 100px;">
															<col>
														</colgroup>
														<tbody>
															<tr>
																<th scope="row" class="a-r">결제일시</th>
																<td>${booking.bookingDate}</td>
															</tr>
														</tbody>
													</table>
												</div>
												<div class="btn-group">
													<button class="button gray" id="btnCancelBokd"
														title="예매취소" >예매취소</button>
													

												</div>
											</div>
										</li>
									</c:forEach>
								</ul>
							</div>
						</div>

						<h3 class="tit mt70">예매취소내역</h3>

						<ul class="dot-list">
							<li>상영일 기준 7일간 취소내역을 확인하실 수 있습니다.</li>
						</ul>

						<!-- 취소한 예매 영화 목록 -->
						<div class="table-wrap mt10">
							<table class="board-list"
								summary="취소일시, 영화명, 극장, 상영일시, 취소금액 항목을 가진 취소내역 목록 표">
								<caption>취소일시, 영화명, 극장, 상영일시, 취소금액 항목을 가진 취소내역 목록 표</caption>
								<colgroup>
									<col style="width: 160px;">
									<col>
									<col style="width: 130px;">
									<col style="width: 188px;">
									<col style="width: 105px;">
								</colgroup>
								<thead>
									<tr>
										<th scope="col">취소일시</th>
										<th scope="col">영화명</th>
										<th scope="col">극장</th>
										<th scope="col">상영일시</th>
										<th scope="col">취소금액</th>
									</tr>
								</thead>
											<c:forEach items="${bookingList.cancellationList}" var="cancellation" varStatus="status">
								<tbody>
										<tr>
											<td>${cancellation.cancelDate}</td>
											<td scope="row">${cancellation.movieName}</td>
											<td>${cancellation.branchName}</td>
											<td>${cancellation.movieDate}${movieStartTime}</td>
											<td class="a-r"><span class="font-red">${cancellation.bookingPrice}</span></td>
										</tr>
												</c:forEach>
								</tbody>
							</table>
						</div>

						<nav class="pagination" id="navBokd"></nav>

						<!-- 예매 안내상황  -->
						<div class="box-pulldown mt30">
							<div class="tit">
								<button type="button" class="btn-toggle">
									이용안내<i class="iconset ico-arr-toggle-down"></i>
								</button>
							</div>
							<div class="cont">
								<strong>[예매 안내]</strong>
								<ul class="dot-list mb30">
									<li>만 4세(48개월) 이상부터는 영화티켓을 반드시 구매하셔야 입장 가능합니다.</li>
									<li>예매 변경은 불가능하며, 취소 후 재 예매를 하셔야만 합니다.</li>
									<li>메가박스 모바일앱을 이용할 경우 티켓출력없이 모바일티켓을 통해 바로 입장하실 수 있습니다.</li>
								</ul>

								<strong>[티켓교환 안내]</strong>
								<ul class="dot-list mb30">
									<li>극장의 무인발권기(KIOSK)를 통해 예매번호 또는 고객확인번호(생년월일+휴대폰번호)를 입력하여
										편리하게 티켓을 발권하실 수 있습니다.</li>
									<li>무인발권기 이용이 어려우신경우, 티켓교환권을 출력하여 매표소에 방문하시면 티켓을 발권하실 수
										있습니다.</li>
									<li>(티켓교환권 출력이 어려운경우 예매번호와 신분증을 지참하여 매표소에 방문하시면 티켓을 발권하실 수
										있습니다)</li>
								</ul>

								<strong>[예매취소 안내]</strong>
								<ul class="dot-list">
									<li>온라인(홈페이지/모바일) 예매 취소는 상영시간 20분전까지 입니다.</li>
									<li>위탁 예매 사이트 이용 시 취소 및 환불 규정은 해당 사이트 규정을 따릅니다.</li>
									<li>LIVE 공연 콘텐트는 취소 기준은 아래와 같습니다.
										<ul class="dash-list">
											<li>관람 4일전 : 취소 가능</li>
											<li>관람 3일 ~ 1일전 : 취소 수수료 부담 후 취소 가능</li>
											<li>관람 당일 : 취소 및 환불 불가</li>
										</ul>
									</li>
									<li>공연 관람시 시작 시간 이후에는 입장이 제한 됩니다.</li>
									<li>발권된 티켓은 상영시간 전까지 현장 방문 시에만 취소가 가능합니다.</li>
								</ul>
							</div>
						</div>
						<!-- 예매 안내상황 End -->
					</div>



				</div>
			</div>

		</div>
		<c:import url="/resources/common/footer.jsp"></c:import>
	</div>
	<script src="/js/user.js"></script>
</body>
</html>