<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
		<header id="header" class="none-ad">
			<h1 class="ci">
				<a href="/" title="SHOW ME THE MOVIE 메인으로 가기">SHOW ME THE MOVIE ^^*!</a>
			</h1>

			<!-- 공간확보용  -->
			<div class="util-area">
				<div class="link-area"></div>
			</div>

			<nav id="gnb" class="">
				<ul class="gnb-depth1">
					<li class=""><a href="/movie" class="gnb-txt-movies" title="영화">영화</a>
					</li>
					<li class=""><a href="/ticketing" class="gnb-txt-ticketting"
						title="예매">예매</a></li>
					<li class=""><a href="/ticketing" class="gnb-txt-theaters"
						title="극장" >극장</a></li>
						<c:choose>
							<c:when test="${empty user.userId}">
					<li><a href="/login" class="gnb-txt-login" title="로그인">로그인</a></li>
					<li><a href="/signUp" class="gnb-txt-sighup" title="회원가입">회원가입</a></li>
							</c:when>
							<c:otherwise>
							<li><h3 class="gnb-txt-user" title="${user.userName }">${user.userName}</h3></li>
						<li><a href="/myPage" class="gnb-txt-myPage"
						title="마이페이지">마이페이지</a></li>
						<li><a href="/logout" class="gnb-txt-logout"
						title="마이페이지">로그아웃</a></li>
							</c:otherwise>
						</c:choose>
						
				</ul>
			</nav>
		</header>