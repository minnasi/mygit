<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page trimDirectiveWhitespaces="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- <link href="<c:url value="/resources/css/megabox.min.css" />" rel="stylesheet"> -->
<link href="/css/megabox.min.css" rel="stylesheet">
<link href="/css/main.css" rel="stylesheet">
<link href="/css/custom.css" rel="stylesheet">
<link href="/css/movieDetail.css" rel="stylesheet">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
</head>
<body>

	<div class="body-wrap">

		<c:import url="/resources/common/header.jsp"></c:import>


		<div class="movie-detail-page">
			<div class="bg-img"
				style="background-image: url('/img/${movie.moviePosterBG}');"></div>
			<div class="bg-pattern"></div>
			<div class="bg-mask"></div>

			<!-- movie-detail-cont -->
			<div class="movie-detail-cont">
				<!-- 개봉 예매가능-->
				<p class="contents-type"></p>
				<p class="title">${movie.movieName}</p>
				<div class="btn-util"></div>
				<!-- info -->
				<div class="info">
					<div class="rate">
						<p class="tit">예매율</p>
						<p class="cont">
							<em>${movie.movieTicketRate}</em>위
							(${movie.movieTicketRatePersent}%)
						</p>
					</div>

					<div class="audience ">
						<div class="tit ">
							<span class="m-tooltip-wrap ">누적관객수 <!-- 2019-09-11 툴팁 보기 수정 -->
								<em class="m-tooltip ml05"> <i
									class="iconset ico-tooltip-gray">툴팁보기</i>
							</em>
							</span>
						</div>
						<p class="cont">
							<em>${movie.movieAudience}</em> 명
						</p>
					</div>

				</div>
				<!--// info -->
				<div class="poster">
					<div class="wrap">
						<img src="/img/${movie.moviePoster}" onerror="noImg(this)"
							alt="다크 워터스">
					</div>
				</div>
				<div class="reserve screen-type col-2">
					<div class="reserve">
						<a href="/ticketing?movieName=${movie.movieName}"
							class="btn reserve" title="영화 예매하기">예매</a>
					</div>
				</div>
			</div>
			<!--// movie-detail-cont -->
		</div>

		<div class="inner-wrap">
			<div class="tab-list fixed" style="display: block">
				<ul>
					<li class="on"><a
						href="/getMovieSynopsis?movieName=${movie.movieName }"
						title="시놉시스 탭으로 이동" onclick="return false">시놉시스</a></li>
					<li><a href="/getMovieImages?movieName=${movie.movieName }"
						title="예고편/스틸컷 탭으로 이동" onclick="return false">이미지/스틸컷</a></li>

				</ul>

			</div>
			<div class="movie-summary infoContent on" id="info">

				<div class="txt" style="height:140px;">${movie.movieSynopsis }</div>
				<div class="btn-more toggle">
					<button type="button" class="btn">
						<span>더보기</span> <i class="iconset ico-btn-more-arr"></i>
					</button>
				</div>

			</div>
			<div class="tit-util mt70 mb15 oneContent on">
				<h2 class="tit small">
					${movie.movieName}에 대한 <span class="font-gblue">1</span>개의 이야기가 있어요!
				</h2>
			</div>
			<div class="movie-idv-story oneContent on">
				<ul>
					<!-- 댓글 영역 -->
					<li class="type01 oneContentTag">
						<div class="story-area">
							<div class="user-prof">
								<div class="prof-img">
									<img src="/img/userIcon.png" alt="프로필 사진" title="프로필 사진"
										onerror="noImg(this, 'human')">
								</div>
								<p class="user-id">koj**</p>
							</div>
							<div class="story-box">
								<div class="story-wrap review">
									<div class="tit">관람평</div>
									<div class="story-cont">
										<div class="story-point">
											<span>10</span>
										</div>
										<div class="story-recommend">
											<em>연출</em><em>OST</em>
										</div>
										<div class="story-txt">다시 봐도 최고</div>
										<div class="story-like">
											<button type="button" class="oneLikeBtn" title="댓글 추천"
												data-no="613571" data-is="N">
												<i class="iconset ico-like-gray"></i> <span>0</span>
											</button>
										</div>
										<div class="story-util">
											<div class="post-funtion">
												<div class="wrap">
													<button type="button" class="btn-alert">옵션보기</button>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="story-date">
							<div class="review on">
								<span>16 분전</span>
							</div>
						</div>
					</li>
				</ul>
			</div>
			<div class="pb100 top700">

				<div class="stair-slide" id="tab2">
					<h2 class="tit small">
						${movie.movieName}에 대한 <span class="font-gblue" id="stilCnt">${fn:length(movieImages)}</span>개의 스틸컷이
						있어요!
					</h2>
					<div class="stair-slide-list" style="height: 1040px;">
				
					<c:forEach items="${movieImages}" var="movieImages"  varStatus="status">
						<div class="thumb" row="0" col="0"
							style="display: block; opacity: 1; transform: translate(0px, 0px); transition: transform 0s ease 0s, opacity 0.2s ease-out 0.2s;">
							<a href="#" title="스틸컷 보기"> <!-- 포스터 --> <img
								src="/img/${movieImages}"
								alt="이미지가 없오" >
							</a>
						</div>
					</c:forEach>	
					
					</div>
				</div>
				<div class="layer-stillcut-view">
					<div class="layer-wrap">

						<div class="movie-detail-cont">
							<!-- 영화 이미지 배경이미지로 출력 -->
							<div class="bg-img"
								style="background-image: url('../../../static/pc/images/movie/img-movie-detail.jpg');"></div>
							<div class="bg-pattern"></div>
							<div class="bg-mask"></div>

						</div>
						<div class="view-content">
							<span><a href="" title="클릭시 창 닫힘"><img
									src="/static/pc/images/movie/img-movie-detail.jpg" alt="이미지상세"></a></span>
						</div>
						<div class="btn-group a-c">
							<button type="button" class="btn-prev">
								<i class="iconset ico-prev"></i> 이전 이미지 보기
							</button>
							<button type="button" class="btn-next">
								<i class="iconset ico-next"></i> 다음 이미지 보기
							</button>
							<button type="button" class="btn-close">
								<i class="iconset ico-layer-close"></i> 스틸컷 레이어 닫기
							</button>
						</div>
					</div>
				</div>
				<!--// layer-stillcut-view -->
			</div>
		</div>
		<c:import url="/resources/common/footer.jsp"></c:import>
	</div>
	<script src="/js/movie.js"></script>
</body>
</html>


