<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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

		<div id="wrap" class="wrap">

			<header class="layer-header">
				<h3 class="tit">
					<a href="/" style="color: #fff;">로그인</a>
				</h3>
			</header>

			<div class="layer-con" style="height: 439px;">


				<!-- tab-cont-wrap -->
				<div class="tab-cont-wrap">
					<!-- tab 회원 로그인 -->
					<div id="login_tab_01" class="tab-cont on">
						<a href="" class="ir">회원 로그인 탭 화면 입니다.</a><a href="" class="ir"
							title="로그인">회원 로그인 탭 화면 입니다.</a>

						<div class="login-member col-2 pt00">
							<!-- col-wrap -->
							<div class="col-wrap">
								<div class="col left">
									<div class="login-input-area">
									
									<form action = "/loginPost" method="post">
										<input autocomplete="off" id="ibxLoginId" maxlength="20"
											type="text" placeholder="아이디" title="아이디를 입력하세요"
											class="input-text strTrim" name = "userId">
										<!--아이디-->
										<!--아이디를 입력하세요-->
										<input autocomplete="off" id="ibxLoginPwd" maxlength="20"
											type="password" placeholder="비밀번호" title="비밀번호를 입력하세요"
											class="input-text mt15" name = "userPassword">
										<!--비밀번호-->
										<!--비밀번호를 입력하세요-->
										<div class="alert"></div>
										
										<div class = "row">
											<div class="col-xs-8">
												
											</div>


										</div>
										<!-- chk-util -->
										<div class="chk-util"></div>
										
										

										
										<!--// chk-util -->

										<button id="btnLogin" type="submit"
											class="button purple large btn-login" >

											로그인
											<!--로그인-->
										</button> 
										</form>

										<div class="link">
											<a href="/user-find" title="ID/PW 찾기 선택" onclick="return false">ID/PW 찾기<!--ID/PW 찾기--></a>
											<a href="/signUp" title="회원가입 선택">회원가입<!--회원가입--></a>
										</div>

										<div class="sns-login">
											<a href="${naverAuthUrl}" lnkgty="NAVER" title="네이버로 로그인 선택"><img
												src="/images/ico-naver.png" alt="네이버"> <!--네이버--> 네이버로
												로그인<!--네이버로 로그인--></a> <a
												href="https://kauth.kakao.com/oauth/authorize?client_id=e7a638f0535094326fe38f8ae0fc6bde&

												redirect_uri=http://127.0.0.1:5000/kakaoCallback&response_type=code"

												lnkgty="KAKAO" title="카카오톡으로 로그인 선택"><img
												src="/images/ico-kakao.png" alt="카카오톡"> <!--카카오톡-->
												카카오톡으로 로그인<!--카카오톡으로 로그인--></a>
												
										<%-- 		
														<a href="${naverAuthUrl}" lnkgty="NAVER" title="네이버로 로그인 선택"><img
												src="/images/ico-naver.png" alt="네이버"> <!--네이버--> 네이버로
												로그인<!--네이버로 로그인--></a> <a
												href="https://kauth.kakao.com/oauth/authorize?client_id=e7a638f0535094326fe38f8ae0fc6bde&
												redirect_uri=http://192.168.0.23:5000/kakaoCallback&response_type=code"
												lnkgty="KAKAO" title="카카오톡으로 로그인 선택"><img
												src="/images/ico-kakao.png" alt="카카오톡"> <!--카카오톡-->
												카카오톡으로 로그인<!--카카오톡으로 로그인--></a> --%>
												
										</div>

									</div>
									<!--// chk-util -->


								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>