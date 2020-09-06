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
<script type="text/javascript">

//더보기 버튼
$('#btnAddMovie').on('click', function() {
	console.log("더보기 버튼");
	addMovieList();
});

//function addMovieList(){
//	$(function(){ //btn-more v1 ?
//		${".movie-list" }.slice(0,8).show();
//		$("#addMovieDiv").click(function(e){
//			e.preventDefault();
//			${".movie-list:hidden" }.slice(0,8).show();
//			if($(".movie-list:hidden").length==0){
//				$("#addMovieDiv").css("display","none");
//			}});
//	});
//}

</script>
</head>
<body>
	<c:import url="/resources/common/header.jsp"></c:import>
	<div class="container">

		<div class="page-util"></div>

		<!-- contents -->
		<div id="contents" class="">
			<!-- inner-wrap -->
			<div class="inner-wrap">
				<h2 class="tit">전체영화</h2>

				<div class="tab-list fixed">
					<ul id="topMenu">
						<li class="on"><a href="/movie" title="박스오피스 탭으로 이동">상영작</a></li>


						<li><a href="/movie/classic" title="클래식소사이어티 탭으로 이동" onclick="return false">큐레이션</a></li>

					</ul>
				</div>

				<!-- movie-list-util -->
				<div class="movie-list-util mt40">
					<!-- 박스오피스 -->

					<!--// 박스오피스 -->

					<!-- 상영예정작 -->
					<div class="topSort" style="display: none;">
						<div class="movie-sorting sortTab">
							<span><button type="button" class="btn on"
									sort-type="rfilmDe">개봉일순</button></span> <span><button
									type="button" class="btn" sort-type="title">가나다순</button></span>
						</div>
					</div>
					<!--// 상영예정작 -->

					<!-- 필름소사이어티 -->
					<div class="topSort" style="display: none;">
						<div class="movie-sorting sortTab">
							<span><button type="button" class="btn on"
									sort-type="ticketing" tab-cd="">전체</button></span>

						</div>


					</div>
					<!--// 필름소사이어티 -->

					<!-- 클래식소사이어티 -->
					<div class="topSort" style="display: none;">
						<div class="movie-sorting sortTab">
							<span><button type="button" class="btn on"
									sort-type="ticketing" tab-cd="">전체</button></span>

						</div>

						<div class="onair-condition">
							<button type="button" title="개봉작만 보기" class="btn-onair btnOnAir">개봉작만</button>
						</div>
					</div>
					<!--// 클래식소사이어티 -->


					

					<div class="movie-search">
						<input type="text" title="영화명을 입력하세요" id="ibxMovieNmSearch"
							name="ibxMovieNmSearch" placeholder="영화명 검색" class="input-text" value="${movieName}">
						<button type="button" class="btn-search-input" id="btnSearch">검색</button>
					</div>
				</div>
				<!--// movie-list-util -->
				<div class="bg-loading" style="display: none;">
					<div class="spinner-border" role="status">
						<span class="sr-only">Loading...</span>
					</div>
				</div>

				<!-- movie-list -->
				<div class="movie-list">
					<ol class="list" id="movieList">
					<c:forEach var="movie" items="${movies }" varStatus="vs"> 
						<li tabindex="0" class="no-img">
							<div class="movie-list-info">
								<input type="hidden" name="movieName"
									value="${movie.movieName }" class="movie-info-hidden">
								<p class="rank" style="">
									${vs.count }<span class="ir">위</span>
								</p>
								<img src="/img/${movie.moviePoster }" alt="${movie.movieName }"
									class="poster lozad" onerror="noImg(this)">
								<div class="movie-score" style="opacity: 0;">
									<a href="#" class="wrap movieBtn" data-no="20003000"
										title="${movie.movieName } 상세보기">
										<div class="summary"> ${movie.movieSynopsis} </div>
									</a>
								</div>
							</div>
							<div class="tit-area">
								<c:choose>
									<c:when test="${vs.index % 4 eq 0}">
										<span class="movie-grade small age-12">12세이상관람가</span>
									</c:when>
																						
									<c:when test="${vs.index % 3 eq 1}">
										<span class="movie-grade small age-15">15세이상관람가</span>
									</c:when>
									<c:when test="${vs.index % 4 eq 2}">
										<span class="movie-grade small age-15">15세이상관람가</span>
									</c:when>
																						
									<c:when test="${vs.index % 7 eq 5}">
										<span class="movie-grade small age-19">19세이상관람가</span>
									</c:when>
																						
									<c:otherwise>
										<span class="movie-grade small age-all">전체관람가</span>
									</c:otherwise>
								</c:choose>
								<p title="${movie.movieName }" class="tit">${movie.movieName }</p>
							</div>
							<div class="rate-date">
								 <span class="date">개봉일 ${movie.movieUpdate }</span>
							</div>
							<div class="btn-util">
								<div class="case movieStat4" style="">
									<button value="${movie.movieName }"
										class="button purple bokdBtn" data-no="20003000"
										title="영화 예매하기">예매</button>
								</div>
							</div>
						</li>
						</c:forEach>
					</ol>
				</div>
				<!--// movie-list -->

				<div class="btn-more v1" id="addMovieDiv" style="">
					<button type="button" class="btn" id="btnAddMovie">
						더보기 <i class="iconset ico-btn-more-arr"></i>
					</button>
				</div>

				<!-- 검색결과 없을 때 -->
				<div class="movie-list-no-result" id="noDataDiv"
					style="display: none;">
					<p>현재 상영중인 영화가 없습니다.</p>
				</div>


				<!-- 검색결과 없을 때 -->
				<div class="movie-list-no-favor" id="noMyGenre"
					style="display: none;">
					<p>선호장르가 등록되지 않았습니다. 선호하시는 장르를 등록해보세요.</p>
					<div class="btn-group center">
						<a href="/mypage/additionalinfo" class="button large purple"
							title="선호장르설정하기 페이지로 이동">선호장르설정하기</a>
					</div>
				</div>


			</div>
			<c:import url="/resources/common/footer.jsp"></c:import>
		</div>
	</div>
	<script src="/js/movie.js"></script>
    <script>
    
    $(function(){
    	search();
    })
    
        $(document).ready(function() {
            $('#ibxMovieNmSearch').on('change', search);
            $('#btnSearch').on('click', search);
        });
        function search(){
            var key =	 $('#ibxMovieNmSearch').val();
            console.log("key :  "+key);
            
            var movieList = $('#movieList > li');
         //   var movies = $('li.no-img');
            $.each(movieList, function(index, item){
                var title = $(this).find(".tit-area .tit").text();
                console.log("title :  "+title);
                
                if( title.includes(key) ){
                    $(this).show();
                }else{
                    $(this).hide();
                }
            });
        }

    </script>	
   
</body>
</html>