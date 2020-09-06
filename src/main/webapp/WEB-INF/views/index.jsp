<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%request.setCharacterEncoding("UTF-8");%>

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
	<div class="container main-container area-ad">
		<div class="container">
			<c:import url="/resources/common/header.jsp"></c:import>
			
			<div class="main-page">
				<div id="main_section01" class="section main-movie">
					<div class="bg">
						<div class="bg-pattern"></div>
						<img
							src="https://img.megabox.co.kr/SharedImg/2020/02/14/BJ4fa4uF619oFERjOyuxvVYzvOeYDSYV_380.jpg"
							alt="다크워터스_티저포스터.jpg">
					</div>

					<!-- movie.js에 있는 함수 사용할 수 없음
					<script text = "text/javascript" src="movie.js"></script>
					 -->

					<!-- cont-area  -->
					<div class="cont-area">
						<!-- tab-sorting -->
						<div class="tab-sorting">
							<button type="button" class="on" sort="boxoRankList"
								name="btnSort">인기순위</button>
						</div>
						<!-- tab-sorting -->
						<a href="/movie" class="more-movie" title="더 많은 영화보기"> 더 많은
							영화보기 <i class="iconset ico-more-corss gray"></i>
						</a>
						<!-- main-movie-list -->
						<div class="main-movie-list">
						
							<ol class="list">
							
								<!-- 3개의 list를  loop 한다-->
								<!-- 박스오피스 시작 -->
								<!-- 각 map 별 첫번째 li 에 first클래스 추가 -->
							<c:forEach var = "movie" items="${indexMovie}" begin="0" end="3" varStatus="status" > 
								<li name="li_boxoRankList" <c:if test="${status.count eq 1}">class="first"</c:if> ><a  id= "imgOver${status.count }"
									href="/img/${movie.moviePoster}" onclick="return false"	class="movie-list-info" title="영화상세 보기">
									<input type="hidden"  name="movieName" value="${movie.movieName}" class="movie-info-hidden">
										<p class="rank" >
											<em>${movie.movieTicketRate }</em><span class="ir">위</span>
										</p> <!-- to 개발 : alt 값에 영화 제목 출력 --> <img
										src="/img/${movie.moviePoster }" alt ="${movie.movieName}" class="poster" >
										<div id = "wrap${status.count}" class="wrap" style = "display :none; opacity: 0.5;">
											<div class="summary">
											${movie.movieSynopsis}
											</div>
											
											<!--
														관람 전이 더 높을 때
														<div class="my-score small">

														관람 후가 더 높을 때
														<div class="my-score big">

														관람 후가 더 같을 때
														<div class="my-score equal">
													 -->
											<div class="score">
												<div class="preview">
													<p class="tit">기대평</p>
													<p class="number">
														9.${status.count*2+1}<span class="ir">점</span>
													</p>
												</div>
												<!--
															기대평이 클때
															<span class="sign small">보다 크다</span>

															관람후가 클때
															<span class="sign big">보다 작다</span>

															같을 때
															<span class="sign equal">같다</span>
														 -->
												<span class="/img/bg-arr-white-left.png">&gt;</span>
												<!-- 관람 전이 더 높을 때 -->
												<div class="review">
													<p class="tit">관람평</p>
													<p class="number">
													${(9.5) - (status.count*0.1) }<span class="ir">점</span>
													</p>
												</div>
											</div>
										</div>
								</a>
									<div class="btn-util">

										<div class="case">
											<!-- 개봉 예매가능 기본-->
											<!-- <input type="button" class="button gblue" value="darkWater"> -->
											<button class="button gblue" name="movieName" value="${movie.movieName }">예매</button>
											<!-- <a href="javascript:moveBokdPage('20003000');"
												class="button gblue" title="영화 예매하기">예매</a> -->
										</div>
									</div>
								</li>
							</c:forEach>	
							</ol>
						</div>
						<!--// main-movie-list -->

						<div class="search-link">
							<div class="cell" style="width:100%">
								<div class="search">
								<form action = "/movie" method="post">
									<input type="text" placeholder="영화명을 입력해 주세요" title="영화 검색"
										class="input-text" id="movieName" name="movieName" >
									<button type ="submit" class="btn" id="btnSearch">
										<i class="iconset ico-search-w"></i> 검색
									</button>
								</form>
								</div>
							</div>
						</div>
					</div>
					<!--// cont-area  -->

				</div>
			</div>
			<c:import url="/resources/common/footer.jsp"></c:import>
		</div>
	</div>
	
<script src="/js/movie.js"></script>

	
</body>
</html>