<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<script type="text/javascript">	


// 아이디 중복 확인
//<input name="userId" id="abc" class="bbb">  input[name=userId]  #abc  .bbb 
function userIdCheck(){
	$.ajax({ //ajax 구버전...
		url : "/userIdCheck",
		type : "post",
		dataType : "json",
		data : {"userId" : $("input[name=userId]").val()}, // 데이터 url로 보내줌
		success : function(data){ //데이터 보내기 성공하면 url(컨트롤러) 반환값(result) 펑션에 넣어줌
			console.log(data);
			if(data == 1){
				alert("중복된 아이디입니다.");
			}else if (data == 0){
				$("#btnUserIdCheck").attr("value", "Y");
				alert("사용가능한 아이디입니다.");
			}else{
				alert("다시 시도해주세요.");				
			}
		}
//		error : function(jqXHR, exception){ //매개변수 2개로 받기
//			} else if (jqXHR.status == 500) {
//            alert('Internal server error. [500]');
//        } else {
//        	alert("뭘까요");
//        	console.log(data);

	})
}

	
//알러트 말고	
function validate(){
	//모든 공백 체크
	var allcheck = /\s/g; 
	//아이디
	var idcheck = /^[a-z0-9]{4,10}$/;
	//이름
	var namecheck = /^[가-힣]{2,6}$/;
	//비밀번호
	var pwcheck = /^[A-Za-z0-9]{8,15}$/; 
	//생년월일
	//var birthcheck = 
	//핸드폰 번호
	var phoneJ = /^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})-([0-9]{3,4})-([0-9]{4})$/;

	var id = document.getElementById("ibxJoinInfoRegLoginId");
	var name = document.getElementById("ibxJoinInfoRegLoginName");
    var pw = document.getElementById("ibxJoinInfoRegLoginPwd");
    
    //var num1 = document.getElementById("num1");
    //var num2 = document.getElementById("num2");
    
    var birth = document.getElementById("ibxJoinInfoRegLoginBirthConfirm");
    var phone = document.getElementById("ibxJoinInfoRegLoginPhoneNum");
    
    if(!check(idcheck,id,"아이디는 4~10자의 영문 소문자와 숫자로만 입력")) {
        return false;
    }
    
    
    
}

function check(idcheck, what, message) {
    if(idcheck.test(what.value)) {
        return true;
    }
    alert(message);
    what.value = "";
    what.focus();
    //return false;
}


//이름
$("#ibxJoinInfoRegLoginName").blur(function() {
	if (namecheck.test($(this).val())) {
			console.log(namecheck.test($(this).val()));
			$("#JoinInfoRegLoginId-error-text").text('');
	} else {
		$('#JoinInfoRegLoginId-error-text').text('이름을 확인해주세요');
		$('#JoinInfoRegLoginId-error-text').css('color', 'red');
	}
});

</script>
</head>
<body>
<body class="bg-member">
<form name="formname" method="post" action="/signUp.do" onsubmit="return validate();">
	<div class="body-wrap">
		<div class="member-wrap">

			<div class="col-wrap">
				<!-- col -->
				<div class="col">
					<p class="page-info-txt">
						<strong>안녕하세요.<!--님 안녕하세요.--></strong> <span>회원정보를 입력해주세요.<!--회원정보를 입력해주세요.--></span>
					</p>

					<div class="table-wrap">
						<table class="board-form">

							<colgroup>
								<col style="width: 130px;">
								<col>
							</colgroup>
							<tbody>
								<tr>
									<th scope="row"><label for="ibxJoinInfoRegLoginId">아이디<!--아이디--></label></th>
									<td><input maxlength="10" id="ibxJoinInfoRegLoginId"
										type="text" placeholder="영문,숫자 조합(4~10자)"
										class="input-text w260px" name="userId"> <!--영문,숫자 조합(5~10자)-->
										<button id="btnUserIdCheck" type="button" onclick="userIdCheck()" value="N"
											class="button gray-line small w75px ml08 disabled">
											중복확인
											<!--중복확인-->
										</button>
										<div id="JoinInfoRegLoginId-error-text" class="alert"></div></td>
								</tr>
								<tr>
									<th scope="row"><label for="ibxJoinInfoRegLoginName">이름<!-- 이름 -->
									</label></th>
									<td><input maxlength="6" id="ibxJoinInfoRegLoginName" type="text" placeholder="한글 (2~6자)" 
										class="input-text w260px" name="userName">
										<!-- 한글 2자 이상-->
										<div id="JoinInfoRegLoginName-error-text" class="alert"></div>
									</td>
								</tr>
								<tr>
									<th scope="row"><label for="ibxJoinInfoRegLoginPwd">비밀번호<!--비밀번호--></label></th>
									<td><input maxlength="15" id="ibxJoinInfoRegLoginPwd"
										type="password" placeholder="영문,숫자 조합(8자~15자)"
										class="input-text w260px" name="userPassword"> <!--영문,숫자,특수기호 중 2가지 이상 조합-->
										<div id="JoinInfoRegLoginPwd-error-text" class="alert"></div></td>
								</tr>
								<tr>
									<th scope="row"><label for="ibxJoinInfoRegLoginPwdConfirm">비밀번호 확인<!--비밀번호 확인-->
									</label></th>
									<td><input maxlength="15"
										id="ibxJoinInfoRegLoginPwdConfirm" type="password"
										placeholder="영문,숫자 조합(8자~15자)" class="input-text w260px">
										<!--영문,숫자,특수기호 중 2가지 이상 조합-->
										<div id="JoinInfoRegLoginPwdConfirm-error-text" class="alert"></div>
									</td>
								</tr>
								<tr>
									<th scope="row">생년월일<!--생년월일--></th>
									<td><input maxlength="6"
										id="ibxJoinInfoRegLoginBirthConfirm" type="text"
										placeholder="생년월일(ex.950623)" class="input-text w260px"
										name="userBirth"></td>
								</tr>
								<!-- 휴대폰 번호 불러올때 -->
								<tr id="trMblpTelno">
									<th scope="row">휴대폰 번호 <!--휴대폰 번호 --></th>
									<td><input maxlength="11" id="ibxJoinInfoRegLoginPhoneNum"
										type="text" placeholder="핸드폰번호 -제외"
										class="input-text w260px" name="userPhoneNumber"></td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="btn-member-bottom">
						<button id="btnJoinInfoRegButton" type="submit" 
							class="button purple large disabled">
							회원가입
							<!--회원가입-->
						</button>

					</div>
				</div>
				<!--// col -->
			</div>
			<!--// col-wrap -->
		</div>
	</div>
	<!--// body-wrap -->
	<script src="/js/sign.js"></script>
</form>
</body>
</html>