<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<body>

	<div class="skip" title="스킵 네비게이션">
		<a href="#contents" title="본문 바로가기">본문 바로가기</a> <a href="#footer"
			title="푸터 바로가기">푸터 바로가기</a>
	</div>

	<div class="body-wrap">









		<!--  ko_KR -->

		<!-- <script async defer src="https://connect.facebook.net/en_US/sdk.js"></script>
<script type="text/javascript" src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.0.js" charset="utf-8"></script> -->
		<script src="/static/mb/js/hmac-sha256.js"></script>
		<script src="/static/mb/js/enc-base64-min.js"></script>
		<script type="text/javascript">
/*전역변수
아이디
패스워드  입력 완료 체크 변수 필요
*/
var sValidateLoginIdAt  = 'N';	//로그인ID  입력 검증 여부
var sValidateLoginPwdAt = 'N';	//로그인PWD 입력 검증 여부
var submitIng = false;
var sCookieVal = "";	//쿠키값
/*
window.fbAsyncInit = function() {
	FB.init({
    	appId            : '',
      	autoLogAppEvents : true,
      	xfbml            : true,
      	version          : ''
   });
};

var naverLogin = new naver.LoginWithNaverId({
	clientId: '',
	callbackUrl: location.href,
	isPopup: false,
	callbackHandle: false
	// callback 페이지가 분리되었을 경우에 callback 페이지에서는 callback처리를 해줄수 있도록 설정합니다.
});
*/

$(function(){
	/*로그인 버튼 비활성*/
	$("#btnLogin").attr("disabled", true);

	/*쿠키조회 pc 아이디값 입력 및 자동로그인 체크*/
	sCookieVal = fn_getCookie('loginId');
	if (!(sCookieVal == null || sCookieVal == "")){
		$("#ibxLoginId").val(sCookieVal);
		$("input:checkbox[id='chkIdSave']").prop("checked",true);
		fn_validateInputVal("loginId",sCookieVal);
	}

	/*이벤트*/
	/*로그인*/
	$("#btnLogin").click(function(){
		var sLoginId   = $("#ibxLoginId").val();
		var sLloginPwd = $("#ibxLoginPwd").val();

// 		//아이디 생성규칙 확인
// 		if(!fn_validateInputVal("loginId" ,$("#ibxLoginId").val(), 'Y')) {
// 			$("#ibxLoginId").focus();
// 			return;
// 		}
// 		//패스워드 생성규칙확인
// 		if(!fn_validateInputVal("loginPwd",$("#ibxLoginPwd").val(), 'Y')) {
// 			$("#ibxLoginPwd").focus();
// 			return;
// 		}

		$('#error-text').text('');

		//아이디 저장 버튼 체크시 쿠키 설정
		if($("input:checkbox[id='chkIdSave']").is(":checked")){
			fn_setCookie('loginId',$("#ibxLoginId").val(),730);
		}
		//아이디 저장 체크 안했을때 쿠키 삭제
		else if(!$("input:checkbox[id='chkIdSave']").is(":checked")){
			fn_deleteCookie('loginId');
		}

		fn_selectMbLogin(sLoginId, sLloginPwd);	//로그인
	});

	/*아이디 입력시 체크 */
	$("#ibxLoginId").on("keyup", function(e){
		if(fn_validateInputVal("loginId", $(this).val())){
			if(e.keyCode == 13){$("#btnLogin").click();}
		} else {
			if(e.keyCode == 13){$("#ibxLoginPwd").focus();}
		}

		return;
	});

	/*비밀번호 입력체크 */
	$("#ibxLoginPwd").on("keyup", function(e){
		if(fn_validateInputVal("loginPwd", $(this).val())){
			if(e.keyCode == 13){$("#btnLogin").click();}
		}
		return;
	});


	// 페이스북 로그인
	$('.login-facebook').on('click', function(e) {
		e.preventDefault();

		var type = $(this).data('type');

		FB.login(function(response){
			if(response.authResponse.userID) {
				$.ajaxMegaBox({
					url: '/on/oh/ohg/MbLogin/selectMbSimpleLogin.rest',
					data: JSON.stringify({ simpleLoginId: response.authResponse.userID, type: type }),
					success: function (data) {
						if(data.result) {
							AppHandler.Common.goMain();  // 메인페이지로 이동
						} else {
							AppHandler.Common.alert('본 서비스는 메가박스 회원인 경우에만  이용하실 수 있습니다.\n회원가입 후 이용 부탁 드립니다.');
						}
					}
				});
			}
		});
	});
});

//쿠키설정
function fn_setCookie(cname, cvalue, exdays) {
	var d = new Date();
	d.setTime(d.getTime() + (exdays*24*60*60*1000));
	var expires = "expires="+d.toUTCString();
	document.cookie = cname + "=" + cvalue + "; " + expires + ";path=/";
}

//쿠키조회
function fn_getCookie(name) {
	var value = document.cookie.match('(^|;) ?' + name + '=([^;]*)(;|$)');
	return value? value[2] : null;

}

//쿠키삭제
function fn_deleteCookie(name){
	var d = new Date();
	d.setTime(d.getDate() -1);
	var expires = "expires="+d.toUTCString();
	document.cookie = name + "=;" + expires + ";path=/";
}


//입력 문자 체크
function fn_validateInputVal(type,sVal,submitAt){
	if(type == "loginId") {		  //아이디

		if(sVal == ""){
			sValidateLoginIdAt = 'N';
		}
// 		if (!/((?=.{8,})(?=.*[0-9])(?=.*[a-zA-Z]).*$)/g.test(sVal)) {
// 			$('#error-text').text('아이디는 영문,숫자 조합 8자리 이상 12자리 이하 입니다.');
// 			sValidateLoginIdAt = 'N';
// 		}
// 		else if (/((?=.{8,})(?=.*[~!@#$%^&*+=-]).*$)/g.test(sVal)) {
// 			$('#error-text').text('아이디는 영문,숫자 조합 8자리 이상 12자리 이하 입니다.');
// 			sValidateLoginIdAt = 'N';
// 		}
		else{
			$('#error-text').text('');
			sValidateLoginIdAt = 'Y';
		}
	}
	else if(type == "loginPwd") { //패스워드
		if(sVal == ""){
			sValidateLoginPwdAt = 'N';
		}
// 		if (!/((?=.{10,})(?=.*[0-9])(?=.*[a-zA-Z]).*$)|((?=.{10,})(?=.*[~!@#$%^&*+=-])(?=.*[a-zA-Z]).*$)|((?=.{10,})(?=.*[!@#$%^&*+=-])(?=.*[0-9]).*$)/g.test(sVal)) {
// 			$('#error-text').text('비밀번호는 영문,숫자,특수기호 중 2가지 이상 조합하여 10자리 이상 16자리 이하 입니다.');
// 			sValidateLoginPwdAt = 'N';
// 		}
		else {
			$('#error-text').text('');
			sValidateLoginPwdAt = 'Y';
		}
	}

	if(submitAt != 'Y'){
		if(sValidateLoginIdAt == 'Y' && sValidateLoginPwdAt =='Y') {
			$("#btnLogin").attr("disabled", false);	//버튼활성화
		}
		else {
			$("#btnLogin").attr("disabled", true);	//버튼비활성화
		}
	}

	if(sValidateLoginIdAt == 'N' || sValidateLoginPwdAt =='N') {
		return false;
	}

	return true;
}


//패스워드 3개월 초과시 다음에 하기 버튼 누를경우 비밀번호 변경일자 오늘날자로 셋팅
//비번 재설정은 3개월 미변경시, 변경 안하면 로그인 할때마다 alert 나옴 20190507
function fn_updatePwdUptDt(sLoginId){
	var paramData = { loginId:sLoginId };
	$.ajaxMegaBox({
		url: "/on/oh/ohg/MbLogin/updateMbPwdReSet.rest",
		type: "POST",
		contentType: "application/json;charset=UTF-8",
		dataType: "json",
		data: JSON.stringify(paramData),
		success: function (data, textStatus, jqXHR) {
			//메인 화면으로 이동
			$(location).attr('href','/main');
		},
		error: function(xhr,status,error){
			var err = JSON.parse(xhr.responseText);
			alert(xhr.status);
			alert(err.message);
		}
	});
}

//로그인
function fn_selectMbLogin(sLoginId, sLloginPwd, snsLoginAt, redisKey){
	if(submitIng) return;

	/* 폼데이터 초기화 */
	$('#loginForm input[name=certType]').val();								//본인인증 모듈 코드값 초기화
	var sMenuId = $('input[name=menuId]').val();							//호출화면id
	var sMappingId = $('input[name=mappingId]').val();						//리턴URL
	var sSnsLogin = typeof snsLoginAt == 'undefined' ? "N" : snsLoginAt;	//sns로그인 여부

	var validLoginId  = sLoginId != null ? sLoginId.replace(/ /gi,"") : "";
	var validLoginPwd = sLloginPwd != null ? sLloginPwd.replace(/ /gi,"") : "";

	if(validLoginPwd != "simpleLogin"){
		if(validLoginId == "" || validLoginPwd == ""){
			gfn_alertMsgBoxSize('로그인 정보를 입력해 주세요.',400,250);	//로그인 정보를 입력해 주세요.
			return;
		}
	}

	var paramData = { loginId:sLoginId
					, loginPwd:sLloginPwd
					, menuId:sMenuId
					, mappingId:sMappingId
					, snsLogin:sSnsLogin
					, redisKey:redisKey
					};

	$.ajaxMegaBox({
		url: "/on/oh/ohg/MbLogin/selectMbLoginInfo.rest",
		data: JSON.stringify(paramData),
		//async: false,
		success: function (data, textStatus, jqXHR) {
			var revStr                 = data.revStr;
			var redisKey               = data.redisKey;
			var pwdErrCnt              = data.pwdErrCnt+1;
			var loginPwdLstUptDt       = data.loginPwdLstUptDt;
			var pwdUptDayco            = data.pwdUptDayco;
			var menuId                 = data.menuId;
			var mappingId              = data.mappingId;
			var marketRcvStr           = data.marketRcvStr
			var loginIdStar            = data.loginIdStar;

			//비밀번호 5회 오류	//본인인증 수단 선택 M-ME-DA-01
			if (revStr == "acctLock") {
				$('#loginForm input[name=redisKey]').attr('value',redisKey);
				$('#loginForm input[name=certType]').attr('value','SCRC05');
				var options = {};
				options.msg = '로그인정보가 5회 이상 잘못 입력되었습니다.\n회원인증 후 새로운 비밀번호를 설정해 주세요.';	//비밀번호 5회 이상 잘못 입력되었습니다.\n본인인증 후 새로운 비밀번호를 설정해 주세요.
				options.callback  = fn_mvPage;
				options.param = {confirm:'/on/oh/ohg/MbLogin/viewMbSimpleCertPage.rest'};	//간편인증페이지
				options.minWidth  = 400;
				options.minHeight = 250;
				gfn_alertMsgBox(options);
				return;
			}
			//비밀번호 변경9개월 초과 //비밀번호 재설정 M-ME-FI-04	비밀번호변경 9개월 체크 하지 않음. 무조건 3개월 연장
// 			else if (revStr == "loginPwdUpt9mm") {
// 				$('input[name=loginId]').attr('value',loginId);
// // 				mbLayer.toggle({id:revStr, msg:'회원님의 개인정보 보호를 위해 3개월마다 비밀번호 변경 안내해드리고 있습니다.\n마지막 변경일 : '+loginPwdLstUptDt+'('+pwdUptDayco+'일전)', btn:'비밀번호 변경', callback:fn_mvPage, param:'/pw-register', minHeight:200, type:'single' });
// 				var options      = {};
// 				options.msg      = '회원님의 개인정보 보호를 위해 3개월마다 비밀번호 변경 안내해드리고 있습니다.\n마지막 변경일 : '+loginPwdLstUptDt+'('+pwdUptDayco+'일전)';
// 				options.okBtnTxt = "비밀번호 변경";
// 				options.callback = fn_mvPage;
// 				options.param    = {confirm:'/pw-register'};
// 				options.minWidth  = 400;
// 				options.minHeight = 250;
// 				gfn_alertMsgBox(options);
// 				return;
// 			}
			//비밀번호 변경3개월 초과	//다음에하기, 비밀번호 재설정 M-ME-FI-04
			else if (revStr == "loginPwdUpt3mm") {
				$('#loginForm input[name=redisKey]').attr('value',redisKey);
				var options = {};
				options.msg        = '회원님의 개인정보 보호를 위해 3개월마다 비밀번호 변경안내를 시행하고 있습니다.\n안전한 서비스 이용을 위해 비밀번호 변경 후 이용바랍니다.\n지금 변경 하시겠습니까?\n\n마지막 변경일 : '+loginPwdLstUptDt+'('+pwdUptDayco+'일전)';
				options.confirmFn  = fn_mvPage;
				options.cancelFn   = fn_loginSuccessEvent;
				options.okBtnTxt     = "비밀번호 재설정";
			    options.cancelBtnTxt = "다음에 하기";
			    options.minWidth  = 400;
				options.minHeight = 300;
				options.param      = {confirm:"/pw-register" };
				gfn_confirmMsgBox(options);
				return;
// 				if(confirm('회원님의 개인정보 보호를 위해 3개월마다 비밀번호 변경안내를 시행하고 있습니다.\n안전한 서비스 이용을 위해 비밀번호 변경 후 이용바랍니다.\n지금 변경 하시겠습니까?\n\n마지막 변경일 : '+loginPwdLstUptDt+'('+pwdUptDayco+'일전)')){
// 					$('input[name=loginId]').attr('value',loginId);
// 					fn_mvPage('/pw-register');
// 					return;
// 				}
// 				else {
// 					fn_mvPage("/main");	//메인페이지로 이동
// 					return;
// 				}
			}
			//마케팅 수신일 2년 초과	//todo 다음에하기, 수신동의 설정 내정보 수정화면 개발후연결
			else if (revStr == "marketRcv") {
				var options        = {};
				options.msg        = '마케팅 수신 동의일로부터 2년이 경과되어, 수신에 대한 재동의 안내를 시행하고 있습니다. \n메가박스의 다양한 소식 및 이벤트를 받고 싶으시면 수신동의 재설정이 필요합니다.  \n수신동의 재설정을 진행 하시겠습니까?\n\n[수신동의 정보]\n'+marketRcvStr+'';
				//options.msg        = '마케팅 수신 동의일로부터 2년이 경과되어, 수신에 대한 재동의 안내를 시행하고 있습니다. \n메가박스의 다양한 소식 및 이벤트를 받고 싶으시면 수신동의 재설정이 필요합니다.  \n수신동의 재설정을 진행 하시겠습니까?\n\n[수신동의 정보]\n&#39;+lstSmsRcvAgreeDt+&#39;'.replaceAll('\n','<br/>');
				options.confirmFn  = fn_mvPage;
				options.cancelFn   = fn_loginSuccessEvent;
				options.okBtnTxt     = "수신동의 설정";
			    options.cancelBtnTxt = "다음에 하기";
				options.param      = {confirm:"/on/oh/ohh/Mypage/userAdditInfoPage.do?marketRcvReAgree=Y"};
				options.minWidth  = 400;
				options.minHeight = 300;
				gfn_confirmMsgBox(options);
				return;
			}
			//관리자에의한 패스워드 초기화 //비밀번호 재설정 M-ME-FI-04	관리자에 의한 패스워드 초기화는 없다.
// 			else if (revStr == "loginPwdReset") {
// // 				mbLayer.toggle({id:revStr, msg:'비밀번호 재설정이 완료되었습니다. 다시 로그인해 주시기 바랍니다.', btn:'확인', callback:fn_mvPage, param:'/pw-register', minHeight:200, type:'single' });
// 				var options = {};
// 				options.msg = '비밀번호 재설정이 완료되었습니다. 다시 로그인해 주시기 바랍니다.';
// 				options.callback  = fn_mvPage;
// 				options.param = {confirm:'/pw-register'};
// 				options.minWidth  = 400;
// 				options.minHeight = 250;
// 				gfn_alertMsgBox(options);
// 				return;
// 			}
			//휴면계정복구 안내	//TODO 다음에하기, 휴면계정복구 본인인증 수단 선택 M-ME-DA-01
			else if (revStr == "mbSchIdGuideDormAcct") {
				$('#loginForm input[name=certType]').attr('value','SCRC03');
				$('#loginForm input[name=redisKey]').attr('value',redisKey);
				var options = {};
				options.msg        = '회원님의 아이디는 ['+loginIdStar+'] 메가박스 온라인 서비스를 1년이상 이용하지 않아 휴면계정으로 전환되었습니다. 휴면계정 복구 후 서비스 이용이 가능합니다.\n휴면계정 복구를 진행하시겠습니까?';
				options.okBtnTxt = "휴면계정복구";
				options.callback = fn_mvPage;
				options.param    = {confirm:"/member-check"};
				options.minWidth  = 400;
				options.minHeight = 300;
				gfn_alertMsgBox(options);
				return;
			}
			//탈퇴회원안내
			else if (revStr == "quitMb") {
				gfn_alertMsgBoxSize('회원탈퇴 후 1개월 이내 재가입할 수 없습니다.\n메가박스 고객센터로 문의해 주세요',400,250);	//회원탈퇴 후 1개월 이내 재가입할 수 없습니다. 메가박스 고객센터로 문의해 주세요
				return;
			}
			//loginPwdFail 패스워드실패안내, mbJoinReq 회원가입안내, mbInfoSearchUnable 탈퇴회원안내
			else if (revStr == "loginPwdFail" || revStr == "mbJoinReq" || revStr == "mbInfoSearchUnable") {
// 				$('.alert').text('로그인 정보가 잘못되었습니다. (로그인 '+pwdErrCnt+'/5회 실패)');	2020-02-06 메가박스 차세대 이행/안정화 결함대장 28번
				$("#ibxLoginId").val("");
				$("#ibxLoginPwd").val("");
				gfn_alertMsgBoxSize('아이디 또는 비밀번호가 맞지 않습니다.\n로그인 정보를 다시 확인바랍니다.',400,250);	//msg.ch.ohg.ME031=아이디 또는 비밀번호가 맞지 않습니다.\\n로그인 정보를 다시 확인바랍니다.
				$("#btnLogin").attr("disabled", true);	//버튼비활성화
				sValidateLoginPwdAt ='N';
				return;
			}

		    if(typeof loginPopupCallScn === "undefined"){
		    	loginPopupCallScn = "";
		    }
// 		    console.log("this : "+loginPopupCallScn);
			//화면이동
			if(menuId != "" && menuId != null){  //화면으로 띄웠을떄
				fn_mvPage(mappingId);
				return;
			}
			else {

				fn_loginSuccessEvent();

			}
			return;
		},
		error: function(xhr,status,error){
			 var err = JSON.parse(xhr.responseText);
			 alert(xhr.status);
			 alert(err.message);
		},
		beforeSend: function() {
			submitIng = true;
		},
		complete: function() {
			submitIng = false;
		}
	});

	function fn_loginSuccessEvent(){

		var bokdLoginAt = $('#loginForm input[name=bokdLoginAt]').val();
		var reloadYn = $('#loginForm input[name=reloadYn]').val();
		var validDataRevisnYn = $('#loginForm input[name=validDataRevisnYn]').val();				//데이터 보정 여부

		if(bokdLoginAt == "Y"){
			//예매로그인일경우
			//오입력값을 체크한다.
			$('.before').hide();
			$('.after').show();
			$('.after .notice').show();
			$('#layer_login_select button.btn-modal-close').trigger("click");
			fn_validDataRevisn(JSON.parse($('#loginForm input[name=bokdLoginParam]').val()));
		}
		else {
			if (reloadYn == "N") {
				$('.before').hide();
				$('.after').show();
				$('.after .notice').show();
				$('#layer_login_select button.btn-modal-close').trigger("click");
				if(validDataRevisnYn == "Y"){
					fn_validDataRevisn();
				}
			} else {
				//화면 리로드
				//location.reload();
				//post submit시 브라우저 경고창 관련
				window.document.location.href = window.document.URL;
			}
		}
	}

	//페이지 이동 submit
	function fn_mvPage(page){
// 		console.log("MbLoginScriptDV.fn_mvPage : "+page);

		var rtnParam = $("#loginForm [name=rtnParam]").val();

		if (rtnParam.trim() != ""){

			var arr;
			var html = '<input type="hidden" name="#1" value="#2" />';

			$.each(rtnParam.split(','), function(i, val){

				arr = val.split(':');
				arr[0] = arr[0].trim();
				arr[1] = arr[1].trim();
				arr[2] = '[name='+arr[0]+']';

				if ($("#loginForm").find(arr[2]).length > 0) {
					$("#loginForm").find(arr[2]).val(arr[1]);
				} else {
					$("#loginForm").append(html.replace('#1', arr[0]).replace('#2', arr[1]));
				}
			});
		}

		$("#loginForm").attr("method","post");
		$("#loginForm").attr("action",page);
		$("#loginForm input[name=preUrl]").val(document.location.pathname)
		$("#loginForm").submit();
	}
}
/* 비회원 */
var sValidateNonMbNmAt               = "N";
var sValidateNonMbByymmddAt          = "N";
var sValidateNonMbTelnoAt            = "N";

var sValidateMblpCharCertNo          = "N";

var sValidateNonMbPwdAt              = "N";
var sValidateNonMbPwdConfirmAt       = "N";
var sValidateNonMbPwdEqualAt         = "N";
var sValidateNonMbBokdPersonInfoProc = "N";
var sValidateMblpCertNoSuccess      = "N";

var AuthTimer;
var bokdCnfmAt                       = "N";

//이벤트
$(function(){
	if(typeof $("#ibxNonMbPwdConfirm").val() == 'undefined'){
		bokdCnfmAt = "Y";
	}
	fn_validateNonMbInputVal();
	/*비회원 로그인 버튼 비활성화*/
	$("#btnMbLogin").attr("disabled", true);

	/*비회원 정보 확인 버튼 비활성화*/
	$("#btnChkNonMbLogin").attr("disabled", true);
	$("#btnNonMbLogin").attr("disabled", true);

	/* 이름 숫자를 제외한 입력 여부판단 */
	$("#ibxNonMbNm").on("keyup", function(e){
		var partton = /[^ㄱ-힣a-zA-Z]/g;
		if(partton.test($(this).val())) {
			var value = $(this).val().replace(/[^ㄱ-힣a-zA-Z]/g,"");
			$(this).val(value);
		}
		if(fn_validateNonMbInputVal()){
			if(e.keyCode == 13) {$("#btnChkNonMbLogin").click();}
		} else {
			if(e.keyCode == 13) {$("#ibxNonMbByymmdd").focus()};
		}
	});
	$("#ibxNonMbNm").focusout(function(){
		var partton = /[^ㄱ-힣a-zA-Z]/g;
		if(partton.test($(this).val())) {
			var value = $(this).val().replace(/[^ㄱ-힣a-zA-Z]/g,"");
			$(this).val(value);
		}
		fn_validateNonMbInputVal();
	});

	/* 생년월일 숫자만 입력 여부판단 */
	$("#ibxNonMbByymmdd").on("keyup", function(e){
		$(this).val($(this).val().replace(/[^0-9]/g,""));
		if(fn_validateNonMbInputVal()){
			if(e.keyCode == 13) {$("#btnChkNonMbLogin").click();}
		} else {
			if(e.keyCode == 13) {$("#ibxNonMbTelno").focus();}
		}
	});
	$("#ibxNonMbByymmdd").focusout(function(){
		$(this).val($(this).val().replace(/[^0-9]/g,""));
		fn_validateNonMbInputVal();
	});

	/* 휴대폰번호 숫자만 입력 여부판단 */
	$("#ibxNonMbTelno").on("keyup", function(e){
		$(this).val($(this).val().replace(/[^0-9]/g,""));

		//휴대폰 번호
		if($("#ibxNonMbTelno").val() != "") {
			var frontNm = $("#ibxNonMbTelno").val().substr(0,2);
			if(frontNm != '01'){
				$('#mblpInput-error-text').text('휴대폰번호를 정확히 입력해주세요.');
				ibxNonMbTelno = 'N';
				return false;
			}
			else if($("#ibxNonMbTelno").val().length < 10){
				$('#mblpInput-error-text').text('휴대폰번호를 정확히 입력해주세요.');
				sValidateNonMbTelnoAt = 'N';
				return false;
			}
			else {
				sValidateNonMbTelnoAt = 'Y';
				$('#mblpInput-error-text').text('');
			}
		}
		else {
			sValidateNonMbTelnoAt = 'N';
		}

		//console.log("sValidateNonMbTelnoAt", sValidateNonMbTelnoAt);
		//console.log("sValidateMblpCertNoSuccess", sValidateMblpCertNoSuccess);

		//인증번호 전송 버튼 활성화
		if( sValidateNonMbTelnoAt   == 'Y' && sValidateMblpCertNoSuccess == 'N') {
			$("#nonMbCertNoSend").attr("disabled", false);
			$("#nonMbCertNoSend").removeClass("disabled");
			if(window.fn_validateJoinInfoRegInputVal) {
				//sValidateMblpCertNoSuccess = "Y";
				fn_validateJoinInfoRegInputVal();
			}
		}
		else{
			$("#nonMbCertNoSend").attr("disabled", true);
			$("#nonMbCertNoSend").addClass("disabled");
			if(window.fn_validateJoinInfoRegInputVal) {
				//sValidateMblpCertNoSuccess = "N";
				fn_validateJoinInfoRegInputVal();
			}
		}

		if(e.keyCode != 9){
			if(typeof AuthTimer != 'undefined'){
				AuthTimer.fnStop();
				$('#timer').html("3:00");
				$('#nonMbCertNoSend').html("인증요청");
				sValidateMblpCertNoSuccess = "N";
				$('#nonMbCertRow').show();
				$('#mblpCharCertNo').val("");
				$("#nonMbCertNoSend").removeClass("disabled");
				$("#nonMbCertNoSend").attr("disabled", false);
				$("#btnMblpCharCert").attr("disabled", true);
				$("#btnMblpCharCert").addClass("disabled");
				if(fn_validateNonMbInputVal()){
					if(e.keyCode == 13) {$("#btnChkNonMbLogin").click();}
				} else {
					if(e.keyCode == 13) {$("#nonMbCertNoSend").click();}
				}
			}
			else {
				if(fn_validateNonMbInputVal()){
					if(e.keyCode == 13) {$("#btnChkNonMbLogin").click();}
				} else {
					if(e.keyCode == 13) {$("#ibxNonMbPwd").focus();}
				}
			}
		}
	});
	$("#ibxNonMbTelno").focusout(function(){
		$(this).val($(this).val().replace(/[^0-9]/g,""));
		fn_validateNonMbInputVal();
	});

	/* 인증번호 숫자만 입력 여부 판단*/
	$("#mblpCharCertNo").on("keyup", function(e){
		$(this).val($(this).val().replace(/[^0-9]/g,""));

		if($("#mblpCharCertNo").val().length >= 4) {
			$("#btnMblpCharCert").removeClass("disabled");
			$("#btnMblpCharCert").attr("disabled", false);
		}
		else {
			$("#btnMblpCharCert").attr("disabled", true);
			$("#btnMblpCharCert").addClass("disabled");
		}

		if(e.keyCode == 13) {$("#btnMblpCharCert").click();}
	});
	$("#mblpCharCertNo").focusout(function(){
		$(this).val($(this).val().replace(/[^0-9]/g,""));
		if($("#mblpCharCertNo").val().length >= 4) {
			$("#btnMblpCharCert").removeClass("disabled");
			$("#btnMblpCharCert").attr("disabled", false);
		}
		else {
			$("#btnMblpCharCert").attr("disabled", true);
			$("#btnMblpCharCert").addClass("disabled");
		}
	});

	/* 비밀번호 숫자만 입력 여부판단 */
	$("#ibxNonMbPwd").on("keyup", function(e){
		$(this).val($(this).val().replace(/[^0-9]/g,""));
		if(fn_validateNonMbInputVal()){
			if(e.keyCode == 13) {$("#btnChkNonMbLogin").click();}
		} else {
			if(e.keyCode == 13) {$("#ibxNonMbPwdConfirm").focus();}
		}
	});
	$("#ibxNonMbPwd").focusout(function(){
		$(this).val($(this).val().replace(/[^0-9]/g,""));
		fn_validateNonMbInputVal();
	});

	/* 비밀번호 확인 숫자만 입력 여부판단 */
	$("#ibxNonMbPwdConfirm").on("keyup", function(e){
		$(this).val($(this).val().replace(/[^0-9]/g,""));
		if(fn_validateNonMbInputVal()) {
			if(e.keyCode == 13) {$("#btnChkNonMbLogin").click();}
		}
	});
	$("#ibxNonMbPwdConfirm").focusout(function(){
		$(this).val($(this).val().replace(/[^0-9]/g,""));
		fn_validateNonMbInputVal();
	});

	//체크박스 변경여부
	$("#chkNonMbBokdPersonInfoProcTrue").change(function() {
		if($('#chkNonMbBokdPersonInfoProcTrue').is(":checked")) {
			fn_validateNonMbInputVal();
		}
		else {
			fn_validateNonMbInputVal();
		}
	});

	$("#chkNonMbBokdPersonInfoProcFalse").change(function() {
		if($('#chkNonMbBokdPersonInfoProcFalse').is(":checked")) {
			fn_validateNonMbInputVal();
		}
		else {
			fn_validateNonMbInputVal();
		}
	});

	/*이벤트*/
	/* 인증번호 전송 버튼 클릭*/
	$("#nonMbCertNoSend").click(function(){
		if($("#nonMbCertNoSend").hasClass("disabled")){
			return;
		}

		var sRedisKey     = $('#loginForm input[name=nonMbCertRedisKey]').val();
		var sNonMbTelno   = $('#ibxNonMbTelno').val();
		var paramData = { redisKey : sRedisKey
						, nonMbTelno : sNonMbTelno
						};

		$('#nonMbCert-error-text').text('');

		$.ajaxMegaBox({
			url: "/on/oh/ohg/MbLogin/selectNonMbCertNoSend.rest",
			type: "POST",
			contentType: "application/json;charset=UTF-8",
			dataType: "json",
			data: JSON.stringify(paramData),
			success: function (data, textStatus, jqXHR) {
				$('input[name=nonMbCertRedisKey]').attr('value',data.resultMap.redisKey);

				if(data.resultMap.successAt == "N"){
					//비회원로그인-예매
					var bokdLoginAt = $('#loginForm input[name=bokdLoginAt]').val();
    				if(bokdLoginAt == "Y"){
    					//예매로그인일경우
    					//인증시간이 만료된 경우
    					if(data.resultMap.msg == "ME061"){
    						gfn_alertMsgBoxSize('인증시간이 만료되었습니다. 인증번호를 재전송 후 입력바랍니다.', 400, 250);	//인증시간이 만료되었습니다. 인증번호를 재전송 후 입력바랍니다.
    					}
    					//동일번호로 3회 이상 요청하는경우
    					else if(data.resultMap.msg == "ME062"){
    						//오입력값을 체크한다.
        					$('.before').hide();
            				$('.after').show();
            				$('#btnNonMbModalClose').trigger("click");
        					$('#layer_login_select button.btn-modal-close').trigger("click");
    						gfn_alertMsgBoxSize('동일번호로 연속적인 인증이 발생하여 창을 닫습니다.\n3분후 다시 시도해 주세요.', 400, 250);	//동일번호로 연속적인 인증이 발생하여 창을 닫습니다.\\n번호를 확인 한 후 처음부터 다시 진행바랍니다.
    					}

    				}
    				else {
    					//회원가입
    					var options = {};
						options.msg = '동일번호로 연속적인 인증이 발생하여 창을 닫습니다.\n3분후 다시 시도해 주세요.';	//동일번호로 연속적인 인증이 발생하여 창을 닫습니다.\\n처음부터 다시 이용바랍니다.
						options.callback  = fn_mvMainPage;
						options.minWidth  = 400;
						options.minHeight = 250;
						gfn_alertMsgBox(options);
    				}
					return;
				}
				else {
					//nonMbCertRedisKey
					//console.log("certNo", data.resultMap.certNo);
					$('#nonMbCertNoSend').html("재전송");
					$('#loginForm input[name=nonMbCertedMblpNo]').attr('value',sNonMbTelno);
					gfn_alertMsgBoxSize('인증번호를 전송했습니다.\n인증번호가 도착하지 않았을 경우 재전송을 눌러 주세요.', 400, 250);

					if(typeof AuthTimer != 'undefined'){
						AuthTimer.fnStop();
						$('#timer').html("3:00");
					}
					else {
						AuthTimer = new $ComTimer();
					}
					AuthTimer.comSecond = 180;
					AuthTimer.fnCallback = function(){alert("다시인증을 시도해주세요.")}
					AuthTimer.timer = setInterval(function(){AuthTimer.fnTimer()},1000);
					AuthTimer.domId = document.getElementById("timer");
					//입력하신 휴대폰 번호로 인증번호가 발송되었습니다. 확인 후 인증번호를 입력해주세요!
				}
			},
			error: function(xhr,status,error){
				var err = JSON.parse(xhr.responseText);
				alert(xhr.status);
				alert(err.message);
			}
		});
	});


	//인증번호 확인 버튼 클릭
	$("#btnMblpCharCert").click(function(){
		if($("#btnMblpCharCert").hasClass("disabled")){
			return;
		}

		var sRedisKey     = $('#loginForm input[name=nonMbCertRedisKey]').val();
		var sMblpCharCertNo = $('#mblpCharCertNo').val();
		var sNonMbTelno     = $('#ibxNonMbTelno').val();
		var paramData = { redisKey : sRedisKey
						, certNo : sMblpCharCertNo
						, nonMbTelno : sNonMbTelno
						};

		$.ajaxMegaBox({
			url: "/on/oh/ohg/MbLogin/selectNonMbCertNoCnfn.rest",
			type: "POST",
			contentType: "application/json;charset=UTF-8",
			dataType: "json",
			data: JSON.stringify(paramData),
			success: function (data, textStatus, jqXHR) {
				var successAt = data.resultMap.successAt;
				var msg = data.resultMap.msg;
				var redisKey = data.resultMap.redisKey;

				if(successAt == "Y"){
					sValidateMblpCertNoSuccess = "Y";
					fn_validateNonMbInputVal();
					$('#loginForm input[name=nonMbCertRedisKey]').attr('value',data.resultMap.redisKey);
					$('#nonMbCert-error-text').text('');
					$("#nonMbCertNoSend").attr("disabled", true);
					$("#nonMbCertNoSend").addClass("disabled");
					$("#nonMbCertRow").hide();
					gfn_alertMsgBoxSize('휴대폰 인증을 완료했습니다.\n확인 버튼을 눌러주세요.', 400, 250);	//휴대폰 인증을 완료했습니다.
					if(typeof fn_validateJoinInfoRegInputVal != "undefined"){
						fn_validateJoinInfoRegInputVal()	//회원가입에서 검증함수 호출
					}
				}
				else {
					sValidateMblpCertNoSuccess = "N";
					if(msg == "ME019"){
						$('#nonMbCert-error-text').text('인증번호가 일치하지 않습니다.\n인증번호를 다시 입력해주세요.');	//msg.ch.ohg.ME019 인증번호를 다시 확인 후 입력해 주세요.
					}
					else if(msg == "ME040"){
						$('#nonMbCert-error-text').text('인증시간이 만료되었습니다. 인증번호를 재전송 후 입력바랍니다.');	//msg.ch.ohg.ME040	유효시간이 지났습니다.  인증번호 재전송을 통해서 다시 인증해주세요.
					}
					else if(msg == "ME061"){
						$('#nonMbCert-error-text').text('인증시간이 만료되었습니다. 인증번호를 재전송 후 입력바랍니다.');	//msg.ch.ohg.ME061	유효시간이 지났습니다.  인증번호 재전송을 통해서 다시 인증해주세요.
						gfn_alertMsgBoxSize('인증시간이 만료되었습니다. 인증번호를 재전송 후 입력바랍니다.',400,250);	//입력정보를 확인해주세요.
					}

					$("#nonMbCertNoSend").removeClass("disabled");
					$("#nonMbCertNoSend").attr("disabled", false);
					$("#nonMbCertRow").show();
				}
			},
			error: function(xhr,status,error){
				var err = JSON.parse(xhr.responseText);
				alert(xhr.status);
				alert(err.message);
			}
		});
	});

	// 비회원 정보 확인 팝업 요청
	$("#btnChkNonMbLogin").click(function(){

		if(submitIng) return;

		if(typeof $("#ibxNonMbPwdConfirm").val() != 'undefined'){
			if($("#ibxNonMbPwd").val() != $("#ibxNonMbPwdConfirm").val()) {
				gfn_alertMsgBoxSize('입력정보를 확인해주세요.',400,250);	//입력정보를 확인해주세요.
				return;
			}
		}

		//생년월일 날짜형태 확인
// 		if(!fn_validateDateYn($("#ibxNonMbByymmdd").val())) {
// 			alert("생년월일 입력이 잘못 되었습니다.");
// 			$("#ibxNonMbByymmdd").focus();
// 			return;
// 		}
		$("#btnNonMbLogin").attr("disabled", false);
		fn_chkNonMbLogin();
	});

	// 비회원 로그인
	$("#btnNonMbLogin").click(function(){

		var paramData = { nonMbNm:$("#ibxNonMbNm").val()
						, nonMbByymmdd:$("#ibxNonMbByymmdd").val()
						, nonMbTelno:$("#ibxNonMbTelno").val()
						, nonMbPwd:$("#ibxNonMbPwd").val()
						, bokdCnfmAt:bokdCnfmAt
						};

		$.ajaxMegaBox({
			url: "/on/oh/ohg/NonMbLogin/selectNonMbLoginInfo.rest",
			type: "POST",
			contentType: "application/json;charset=UTF-8",
			dataType: "json",
			data: JSON.stringify(paramData),
			success: function (data, textStatus, jqXHR) {

				var menuId                 = data.menuId;
	            var mappingId              = data.mappingId;
	            var statCd                 = data.result.statCd;


	            if(typeof loginPopupCallScn === "undefined"){
			    	loginPopupCallScn = "";
			    }
	            //화면이동
	            if(menuId != "" && menuId != null){    //화면으로 띄웠을떄
	                fn_mvPage(mappingId);
	                return;
	            }
	            else {
	                if(loginPopupCallScn != "" && loginPopupCallScn != null){  //팝업으로 띄었을때 파라메타는 팝업 호출화면에 전역으로 정의
	                    $(".btn-layer-close").trigger("click");
	                    if(loginPopupCallScn == "SimpleBokdM"){
	                    	$('.before').hide();
	            			$('.after').show();
	                        alert("콜백함수호출");
	                    } else if(loginPopupCallScn == "StoreDtlV"){
	                    	$('.before').hide();
	            			$('.after').show();
	                    } else if(loginPopupCallScn == "MySbscDtlsL"){
	                    	$('.before').hide();
	            			$('.after').show();
	            			location.href = '/on/oh/ohh/MySbscDtls/mySbscDtlsListPage.do?currPage=1&searchText=';
	                    }
	                }
	                else {
	                	var bokdLoginAt = $('#loginForm input[name=bokdLoginAt]').val();
	    				if(bokdLoginAt == "Y"){
	    					//예매로그인일경우
	    					//오입력값을 체크한다.
	    					$('.before').hide();
	        				$('.after').show();
	        				$('#btnNonMbModalClose').trigger("click");
	    					$('#layer_login_select button.btn-modal-close').trigger("click");
	    					fn_validDataRevisn(JSON.parse($('#loginForm input[name=bokdLoginParam]').val()));
	    					return;
	    				}

	                	if(bokdCnfmAt == "Y"){
	                		$('#nonMbBokdCnfmForm input[name=nonMbNm]').attr('value',$('#ibxNonMbNm').val());
	                		$('#nonMbBokdCnfmForm input[name=nonMbTelno]').attr('value',$('#ibxNonMbTelno').val());
	                		$('#nonMbBokdCnfmForm input[name=nonMbPwd]').attr('value',$('#ibxNonMbPwd').val());
	                		$('#nonMbBokdCnfmForm input[name=nonMbByymmdd]').attr('value',$('#ibxNonMbByymmdd').val());

                            /////////////////////////////////////////////////////////////////////
	                		// 예매정보가 없을 시 메세지 팝업처리 /////////////////////////////////
                            /////////////////////////////////////////////////////////////////////
                            if(statCd == 0) {
                                fn_mvNonMbBokdCnfm("/non-member"); //비회원 예매 확인일때
                            }else{
                                alert("입력하신 정보와 일치하는 예매내역이 없습니다.");
                            }
                            /////////////////////////////////////////////////////////////////////
                            /////////////////////////////////////////////////////////////////////

	                		//fn_mvNonMbBokdCnfm("/non-member"); //비회원 예매 확인일때
	                	}
	                	else {
	                		location.reload();
	                	}

	                }
	            }
	            return;
			},
			error: function(xhr,status,error){
				 var err = JSON.parse(xhr.responseText);
				 alert(xhr.status);
				 alert(err.message);
			},
			beforeSend: function() {
	            submitIng = true;
	        },
	        complete: function() {
	            submitIng = false;
	        }
	    });

	    //페이지 이동 submit
	    function fn_mvNonMbBokdCnfm(page){
// 	        console.log("fn_mvNonMbBokdCnfm : "+page);
	        $("#nonMbBokdCnfmForm").attr("method","post");
	        $("#nonMbBokdCnfmForm").attr("action",page);
	        $("#nonMbBokdCnfmForm").submit();
	    }

	  	//비회원 예매 확인 페이지 이동 submit
	    function fn_mvPage(page){
// 	        console.log("MbLoginScriptDV.fn_mvPage : "+page);
	        $("#loginForm").attr("method","post");
	        $("#loginForm").attr("action",page);
	        $("#loginForm").submit();
	    }
	});
});

function fn_adTracking(url){
	$.ajax({
        type: "get"
        , url: url
        , data: ""
        , dataType: "json"
        , success: function(result) {

        }
        , error: function(err) {
            console.log('fn_adEventCall error : ' + err.status);
        }
    });
}

/*호출 화면에 따른 분기처리*/
function fn_viewLoginPopup(viewId,deviceType,bokdLoginAt,bokdLoginParam,reloadYn){

  	//로그인 폼 호출시 광고영역 노출
    if( $("#Rw6jtk0hQTuOBSzFbvGGlw").html() == "" ){

    	$("#Rw6jtk0hQTuOBSzFbvGGlw").append('<a href="" target="_blank"><img id="pageBannerRnbImage" src="/static/pc/images/common/bg/bg-noimage-main.png" /></a>');

    	var header ={"typ": "JWT","alg": "HS256"}
        var data = {
            "device": {"devicetype": 2},
            "imp": [{"native": {"ext" : {"slots" : 1}}}],
            "site": {"name": "megabox"},
            "id": ""
        };
    	var secret = "Rw6jtk0hQTuOBSzFbvGGlw";

    	var stringifiedHeader = CryptoJS.enc.Utf8.parse(JSON.stringify(header));
        var encodedHeader = base64url(stringifiedHeader);
        var stringifiedData = CryptoJS.enc.Utf8.parse(JSON.stringify(data));
        var encodedData = base64url(stringifiedData);
        var signature = encodedHeader + "." + encodedData;
        signature = CryptoJS.HmacSHA256(signature, secret);
        signature = base64url(signature);
        var pram = encodedHeader+"."+encodedData+"."+signature;
        var adUrl = "https://cast.imp.joins.com/bid/"+secret+"/"+pram; //상용

    	$.ajax({
            type: "get"
            , url: adUrl
            , data: ""
            , success: function(result) {
                if(result) {
                    $("#pageBannerRnbImage").attr("src", result.image_file);
                    $("#pageBannerRnbImage").attr("alt", result.alternative_text);
                    $("#pageBannerRnbImage").attr("clickThrough", result.click_tracking);
                    $("#pageBannerRnbImage").parent().attr("href", result.click_through);



                    $("#pageBannerRnbImage").css("height", result.height);
                    $("#Rw6jtk0hQTuOBSzFbvGGlw").css("background-color", result.bgcolor);
                    fn_adTracking(result.impression_tracking);
                }
            }
            , error: function(err) {
                console.log('fn_getBannerAd error : ' + err.status);
            }
        });

    	//광고링크
   	    $("#pageBannerRnbImage").on("click", function() {
   	        var clickThrough = $(this).attr("clickThrough");
   	        if(clickThrough != undefined && clickThrough != '') {
   	        	fn_adTracking(clickThrough);
   	        }
   	    });
    }

	//
	$(".alert").html("");
	if(sCookieVal == ""){	//아이디 저장 체크 안했을경우
		$(".login-input-area #ibxLoginId").val("");			//아이디
	}
	$(".login-input-area #ibxLoginPwd").val("");		//비밀번호
	$(".no-member-login-table #ibxNonMbNm").val("");	//비회원 이름
	$(".no-member-login-table #ibxNonMbByymmdd").val("");	//비회원 생년월일
	$(".no-member-login-table #ibxNonMbTelno").val("");		//비회원 휴대폰 번호
	$(".no-member-login-table #mblpCharCertNo").val("");	//비회원 휴대폰인증번호
	$(".no-member-login-table #ibxNonMbPwd").val("");		//비회원 비밀번호
	$(".no-member-login-table #ibxNonMbPwdConfirm").val("");	//비회원 비밀번호확인
	$("input[name=chkNonMbBokdPersonInfoProc]").prop("checked",false);	//비회원 라디오버튼 해제
	if(typeof AuthTimer != 'undefined'){
	    AuthTimer.fnStop();
	    $('#timer').html("3:00");
	    $('#nonMbCertNoSend').html("인증요청");
	    sValidateMblpCertNoSuccess = "N";
	    $('#nonMbCertRow').show();
	    $('#mblpCharCertNo').val("");
	    $("#nonMbCertNoSend").removeClass("disabled");
	    $("#nonMbCertNoSend").attr("disabled", false);
	}
	fn_validateNonMbInputVal();

	$('#loginForm input[name=bokdLoginAt]').val("");				//예매 로그인 여부
	$('#loginForm input[name=bokdLoginParam]').val("");				//예매 로그인 파라메타
	$('#loginForm input[name=validDataRevisnYn]').val("");				//데이터 보정 여부
	fn_validateInputVal();

	if('pc' == deviceType){
		if('SimpleBokdM' == viewId) {
			var sBokdLoginAt = typeof bokdLoginAt == 'undefined' ? "" : bokdLoginAt;//예매 로그인 여부
			$('#layer_login_select .layer-con .tab-list').show();			//로그인 비회원로그인 선택창
			$('#layer_login_select .layer-con .tab-cont-wrap .login-member').removeClass('pt00');	//레이어 사이즈 줄임
			$("#loginPupupATag").attr("h-data",'556');	//높이값 변경
			$("#loginPupupATag").trigger("click");	//레이어띄움
			$('#loginForm input[name=bokdLoginAt]').attr('value',sBokdLoginAt);			//예매 로그인 여부 값 설정
			$('#loginForm input[name=bokdLoginParam]').attr('value',bokdLoginParam);	//예매 로그인 파라메타
			if(bokdLoginAt == "Y"){
				$('#loginForm input[name=nonMbCertRedisKey]').val("");
				$('#loginForm input[name=nonMbCertedMblpNo]').val("");
			}

		}
		else if('StoreDtlV' == viewId || 'MySbscDtlsL' == viewId) {
			$("#loginPupupATag").trigger("click");	//레이어띄움
			$("#mbPopLayer").show();		//회원 레이어
			$("#nonMbLogoLayer").hide();	//비회원 로고
			$("#nonMbPopLayer").hide();		//비회원 레이어
			$("#mbMbChoiLayer").hide();	//회원 비회원 선택

			$("#nonMbBokdCnfm").attr("style","display:none");
		}
		else if('BoutiqPrivateL' == viewId){	//부티크
			$('#layer_login_select .layer-con .tab-list li:eq(0) a').trigger("click");	//회원로그인만 클릭되도록
			$('#layer_login_select .layer-con .tab-list').hide();						//로그인 비회원로그인 선택창
			$('#layer_login_select .layer-con .tab-cont-wrap .login-member').addClass('pt00');	//레이어 사이즈 줄임
			$("#loginPupupATag").attr("h-data",'484');	//높이값 변경
			$("#loginPupupATag").trigger("click");	//레이어띄움

			$('#loginForm input[name=reloadYn]').attr('value',reloadYn); // 화면 리로드 설정
			$('#loginForm input[name=validDataRevisnYn]').val("Y");				//데이터 보정 여부
		}
		else {
			var sReloadYn = typeof reloadYn == 'undefined' ? "" : reloadYn;// 화면 리로드 여부
			$('#layer_login_select .layer-con .tab-list li:eq(0) a').trigger("click");	//회원로그인만 클릭되도록
			$('#layer_login_select .layer-con .tab-list').hide();						//로그인 비회원로그인 선택창
			$('#layer_login_select .layer-con .tab-cont-wrap .login-member').addClass('pt00');	//레이어 사이즈 줄임
			$("#loginPupupATag").attr("h-data",'484');	//높이값 변경
			$("#loginPupupATag").trigger("click");	//레이어띄움

			$('#loginForm input[name=reloadYn]').attr('value',sReloadYn); // 화면 리로드 설정
		}
	}
}

//입력 문자 체크
function fn_validateNonMbInputVal(){
	//이름
	if($("#ibxNonMbNm").val() != "") {
		sValidateNonMbNmAt = 'Y';
	}
	else {
		sValidateNonMbNmAt = 'N';
	}

	//생년월일
	if($("#ibxNonMbByymmdd").val() != "") {
		if(fn_validateDateYn($("#ibxNonMbByymmdd").val(),6)){
			sValidateNonMbByymmddAt = 'Y';
			//비회원예매확인
			if(bokdCnfmAt == "Y"){
				$('#ErrTextNonMbByymmdd').text('');
			}
			//비회원로그인
			else {
				$('#mblpInput-error-text').text('');
			}
		}
		else {
			sValidateNonMbByymmddAt = 'N';
			//비회원예매확인
			if(bokdCnfmAt == "Y"){
				$('#ErrTextNonMbByymmdd').text('생년월일을 정확히 입력해주세요.');
			}
			//비회원로그인
			else {
				$('#mblpInput-error-text').text('생년월일을 정확히 입력해주세요.');
			}
			return false;
		}
	}
	else {
		sValidateNonMbByymmddAt = 'N';
		$('#mblpInput-error-text').text('');
	}

	//휴대폰 번호
	if($("#ibxNonMbTelno").val() != "") {
		var frontNm = $("#ibxNonMbTelno").val().substr(0,2);
		if(frontNm != '01'){
			$('#mblpInput-error-text').text('휴대폰번호를 정확히 입력해주세요.');
			ibxNonMbTelno = 'N';
			return false;
		}
		else if($("#ibxNonMbTelno").val().length < 10){
			$('#mblpInput-error-text').text('휴대폰번호를 정확히 입력해주세요.');
			sValidateNonMbTelnoAt = 'N';
			return false;
		}
		else {
			sValidateNonMbTelnoAt = 'Y';
			$('#mblpInput-error-text').text('');
		}
	}
	else {
		sValidateNonMbTelnoAt = 'N';
	}


	if($("#ibxNonMbPwd").val().length == 4) {
		sValidateNonMbPwdAt = 'Y';
	}
	else {
		sValidateNonMbPwdAt = 'N';
	}
	if(bokdCnfmAt == "Y"){
		sValidateNonMbPwdConfirmAt       = 'Y';
		sValidateNonMbPwdEqualAt         = 'Y';
		sValidateNonMbBokdPersonInfoProc = 'Y';
		sValidateMblpCertNoSuccess       = 'Y';
	}
	else{
		if($("#ibxNonMbPwdConfirm").val().length == 4) {
			sValidateNonMbPwdConfirmAt = 'Y';
		}
		else {
			sValidateNonMbPwdConfirmAt = 'N';
		}

		if($("#ibxNonMbPwd").val().length > 0 && $("#ibxNonMbPwdConfirm").val().length > 0 && $("#ibxNonMbPwd").val() == $("#ibxNonMbPwdConfirm").val()) {
			sValidateNonMbPwdEqualAt = 'Y';
			$('#nonMbPwdErrText').text('');
		}
		else if($("#ibxNonMbPwd").val().length > 0 && $("#ibxNonMbPwdConfirm").val().length > 0 && $("#ibxNonMbPwd").val() != $("#ibxNonMbPwdConfirm").val()){
			sValidateNonMbPwdEqualAt = 'N';
			$('#nonMbPwdErrText').text('비밀번호와 비밀번호 확인의 입력값이 일치하지 않습니다.');
			return false;
		}

		if($('#chkNonMbBokdPersonInfoProcTrue').prop("checked")){
			sValidateNonMbBokdPersonInfoProc = 'Y';
		}
		else {
			sValidateNonMbBokdPersonInfoProc = 'N';
		}

		if($('#chkNonMbBokdPersonInfoProcFalse').prop("checked")){
			sValidateNonMbBokdPersonInfoProc = 'N';
		}
	}

// 	$('#error-text1').text
// 	("sValidateNonMbNmAt:"             +sValidateNonMbNmAt              +("/")+$("#ibxNonMbNm").val().length        +("\n\n")+
// 			"sValidateNonMbByymmddAt:"         +sValidateNonMbByymmddAt         +("/")+$("#ibxNonMbByymmdd").val().length   +("\n\n")+
// 			"sValidateNonMbTelnoAt:"           +sValidateNonMbTelnoAt           +("/")+$("#ibxNonMbTelno").val().length     +("\n\n")+
// 			"sValidateNonMbPwdAt:"             +sValidateNonMbPwdAt             +("/")+$("#ibxNonMbPwd").val().length       +("\n\n")+
// 			"sValidateNonMbPwdConfirmAt:"      +sValidateNonMbPwdConfirmAt      +("/")+$("#ibxNonMbPwdConfirm").val().length+("\n\n")+
// 			"sValidateNonMbPwdEqualAt:"        +sValidateNonMbPwdEqualAt        +("/\n\n")+
// 			"sValidateNonMbBokdPersonInfoProc:"+sValidateNonMbBokdPersonInfoProc+("/\n\n")
// 		+$("input:checkbox[id='chkNonMbBokdPersonInfoProc']").is(":checked"));

	if(    bokdCnfmAt                       == "N"
		&& sValidateNonMbNmAt               == 'Y'
		&& sValidateNonMbByymmddAt          == 'Y'
		&& sValidateNonMbTelnoAt            == 'Y'
		&& sValidateNonMbPwdAt              == 'Y'
		&& sValidateNonMbPwdConfirmAt       == 'Y'
		&& sValidateNonMbBokdPersonInfoProc == 'Y'
 		&& sValidateNonMbPwdEqualAt         == 'Y'
 		&& sValidateMblpCertNoSuccess       == 'Y'){
		$("#btnChkNonMbLogin").attr("disabled", false);
		return true;
	}
	else if (bokdCnfmAt == "Y"
			&& sValidateNonMbNmAt       == 'Y'
			&& sValidateNonMbByymmddAt         == 'Y'
			&& sValidateNonMbTelnoAt == 'Y'
			&& sValidateNonMbPwdAt       == 'Y'){
		$("#btnNonMbLogin").attr("disabled", false);
		return true;
	}
	else{
		$("#btnChkNonMbLogin").attr("disabled", true);
		$("#btnNonMbLogin").attr("disabled", true);
		return false;
	}
}

/*날짜 형태 확인*/
function fn_validateDateYn(param, length) {
	try
	{
		var year  = 0;
		var month = 0;
		var day   = 0;

		param = param.replace(/-/g,'');

		// 자리수가 맞지않을때
		if( isNaN(param) || param.length < Number(length) || param.length > Number(length)) {
			return false;
		}

		if( param.length == 6){
			year  = Number(param.substring(0, 2));
			month = Number(param.substring(2, 4));
			day   = Number(param.substring(4, 6));
		}
		else if(param.length == 8){
			year  = Number(param.substring(0, 4));
			month = Number(param.substring(4, 6));
			day   = Number(param.substring(6, 8));

			var sysYear = Number(new Date().getFullYear());
			//년도입력이 현재 년도보다 클때.
			if(sysYear < year){
				return false;
			}
		}
		else {
			return false;
		}


		var dd = day / 0;


		if( month<1 || month>12 ) {
			return false;
		}

		var maxDaysInMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
		var maxDay = maxDaysInMonth[month-1];

		// 윤년 체크
		if( month==2 && ( year%4==0 && year%100!=0 || year%400==0 ) ) {
			maxDay = 29;
		}

		if( day<=0 || day>maxDay ) {
			return false;
		}
		return true;

	} catch (err) {
		return false;
	}
}


function $ComTimer(){
    //prototype extend
}

$ComTimer.prototype = {
    comSecond : ""
    , fnCallback : function(){}
    , timer : ""
    , domId : ""
    , fnTimer : function(){
        var m = Math.floor(this.comSecond / 60) + ":" + String((this.comSecond % 60)).lpad(2,"0");	// 남은 시간 계산
        this.comSecond--;					// 1초씩 감소
        this.domId.innerText = m;
        if (this.comSecond < 0) {			// 시간이 종료 되었으면..
            clearInterval(this.timer);		// 타이머 해제
            $('#nonMbCert-error-text').text('인증시간이 만료되었습니다. 인증번호를 재전송 후 입력바랍니다.');	//msg.ch.ohg.ME061	인증시간이 만료되었습니다. 인증번호를 재전송 후 입력바랍니다.
            $("#btnMblpCharCert").attr("disabled", true);	//인증확인버튼 비활성
			$("#btnMblpCharCert").addClass("disabled");		//인증확인버튼 비활성
        }
    }
    ,fnStop : function(){
        clearInterval(this.timer);
    }
}

</script>
		<script type="text/javascript">
var simpleLoginWithPopup;
var simpleLoginWith = function(lnkgTy){
    var url = "/on/oc/ocz/SimpleLogin/simpleLogin.do?lnkgTy=" + lnkgTy;
    if ( simpleLoginWithPopup ) {
        simpleLoginWithPopup.close();
    }
    if(lnkgTy != "FACEBOOK"){
		simpleLoginWithPopup = window.open(url, 'simpleLoginWithPopup', 'width=420, height=550');
	}
	else {
		simpleLoginWithPopup = window.open(url, 'simpleLoginWithPopup', 'width=650, height=600, scrollbars=yes');
	}
}

var fn_LoginPopUpCall = function(paramData){
    if ( lnkgInfoObj.attr("connTy") != undefined ) {
        fn_ConnWithCallBack(paramData);
    } else {
        fn_LoginWithCallBack(paramData);
    }

}
var fn_LoginPopUpCallError = function(msg){
    gfn_alertMsgBoxSize(msg, 400, 250);
}

//비회원 확인 팝업
function fn_chkNonMbLogin() {

	var $td = $(document).find('#layer_no_member_chk td');

	var telTmp = $('#ibxNonMbTelno').val();

	switch(telTmp.length){
	case 10 : telTmp = telTmp.format('XXX-XXX-XXXX'); break;
	case 11 : telTmp = telTmp.format('XXX-XXXX-XXXX');break;
	}

	$td.eq(0).html($('#ibxNonMbNm').val());
	$td.eq(1).html($('#ibxNonMbByymmdd').val());
	$td.eq(2).html(telTmp);

	// 레이어 호출
	$(document).find('#aNonMbLogin').click();
}
</script>
		<script type="text/javascript">
var fn_LoginWithCallBack = function(paramData){
    $.ajaxMegaBox({
        url: "/on/oc/ocz/SimpleLogin/selectSimpleLogin.do",
        type: "POST",
        contentType: "application/json;charset=UTF-8",
        dataType: "json",
        data: JSON.stringify(paramData),
        success: function (data, textStatus, jqXHR) {
            if ( data.userMap == null ) {
            	//var simpleLoginTyCd = data.userMap.simpleLoginTyCd;
                gfn_alertMsgBoxSize('['+paramData.simpleLoginTyCd+'] 계정으로 연동된 메가박스 계정이 없습니다.\n연동을 원하시면 나의메가박스 > 개인정보수정에서\n간편로그인 계정연동을 진행해 주세요.', 400, 250);
            } else {
                var loginId = data.userMap.loginId;
                var mbNo    = data.userMap.mbNo;
                fn_selectMbLogin(loginId, "simpleLogin", "Y", paramData.redisKey);
            }
        },
        error: function(xhr,status,error){
            var err = JSON.parse(xhr.responseText);
            alert(xhr.status);
            alert(err.message);
        }
    });
}
var lnkgInfoObj;
$(function(){
    $("div.sns-login > a").off("click").on("click",function(){
        lnkgInfoObj = $(this);
        simpleLoginWith($(this).attr("lnkgTy"));
    });
});
</script>
		<form id="loginForm">
			<input type="hidden" name="redisKey" value=""> <input
				type="hidden" name="menuId" value=""> <input type="hidden"
				name="mappingId" value=""> <input type="hidden"
				name="rtnParam" value=""> <input type="hidden"
				name="certType" value=""> <input type="hidden" name="preUrl"
				value="">

			<!-- 좌석도 로그인 프로세스 여부PARAM-->
			<input type="hidden" name="bokdLoginAt" value=""> <input
				type="hidden" name="bokdLoginParam" value=""> <input
				type="hidden" name="nonMbCertRedisKey" value=""> <input
				type="hidden" name="nonMbCertedMblpNo" value=""> <input
				type="hidden" name="reloadYn" value=""> <input type="hidden"
				name="validDataRevisnYn" value="N">

		</form>







		<!--  ko_KR -->

		<!-- 로그인 레이어팝업 시작 -->
		<!-- 화면ID  M-ME-LO-01 -->
		<!-- 화면ID  M-ME-CC-01 -->
		<div style="display: none;">
			<a id="loginPupupATag" href="#layer_login_select"
				class="button active btn-modal-open" w-data="850" h-data="484"></a>
		</div>

		<section id="layer_login_select" class="modal-layer"
			style="z-index: 501;">
			<a href="" class="focus">레이어로 포커스 이동 됨</a><a href="#" class="focus"
				title="레이어로 포커스 이동 됨">레이어로 포커스 이동 됨<!--레이어로 포커스 이동 됨--></a>
			<div class="wrap"
				style="width: 850px; height: 556px; margin-left: -425px; margin-top: -278px;">
				<header class="layer-header">
					<h3 class="tit">로그인</h3>
				</header>

				<div class="layer-con" style="height: 511px;">

					<div class="tab-list tab-layer">
						<ul>
							<li class="on"><a href="#login_tab_01" title="회원 로그인 선택">회원
									로그인<!--회원 로그인-->
							</a></li>
							<li><a href="#login_tab_02" title="비회원 로그인 선택">비회원 로그인<!--비회원 로그인--></a></li>
						</ul>
					</div>

					<!-- tab-cont-wrap -->
					<div class="tab-cont-wrap">
						<!-- tab 회원 로그인 -->
						<div id="login_tab_01" class="tab-cont on">
							<a href="" class="ir"></a><a href="" class="ir" title="로그인"></a>

							<div class="login-member col-2">
								<!-- col-wrap -->
								<div class="col-wrap">
									<div class="col left">
										<div class="login-input-area">
											<input autocomplete="off" id="ibxLoginId" maxlength="20"
												type="text" placeholder="아이디" title="아이디를 입력하세요"
												class="input-text strTrim">
											<!--아이디-->
											<!--아이디를 입력하세요-->
											<input autocomplete="off" id="ibxLoginPwd" maxlength="20"
												type="password" placeholder="비밀번호" title="비밀번호를 입력하세요"
												class="input-text mt15">
											<!--비밀번호-->
											<!--비밀번호를 입력하세요-->
											<div class="alert"></div>

											<!-- chk-util -->
											<div class="chk-util">
												<div class="left">
													<input id="chkIdSave" type="checkbox"> <label
														for="chkIdSave">아이디 저장<!--아이디 저장--></label>
												</div>

												<div class="right">
													<div class="hp-ad">
														<a
															href="https://www.sepay.org/spm/join?regSiteCode=XF&amp;ctgCode=1&amp;subCode=1"
															title="휴대폰 간편 로그인 선택" target="_blank"><span>휴대폰
																간편로그인<!--휴대폰 간편로그인-->
														</span> <em>광고<!--광고--></em></a>
													</div>
												</div>
											</div>
											<!--// chk-util -->

											<button id="btnLogin" type="button"
												class="button purple large btn-login" disabled="disabled">
												로그인
												<!--로그인-->
											</button>

											<div class="link">
												<a href="/user-find" title="ID/PW 찾기 선택">ID/PW 찾기<!--ID/PW 찾기--></a>
												<a href="/join" title="회원가입 선택">회원가입<!--회원가입--></a> <a
													href="/on/oh/ohg/MbLogin/viewNonMbLogin.rest"
													title="비회원 예매확인 선택">비회원 예매확인<!--비회원 예매확인--></a>
											</div>

											<div class="sns-login">
												<a href="javaScript:void(0)" lnkgty="FACEBOOK"
													title="페이스북으로 로그인 선택"><img
													src="../../../static/pc/images/member/ico-facebook.png"
													alt="페이스북">
												<!--페이스북--> 페이스북으로 로그인<!--페이스북으로 로그인--></a> <a
													href="javaScript:void(0)" lnkgty="NAVER"
													title="네이버로 로그인 선택"><img
													src="../../../static/pc/images/member/ico-naver.png"
													alt="네이버">
												<!--네이버--> 네이버로 로그인<!--네이버로 로그인--></a> <a
													href="javaScript:void(0)" lnkgty="KAKAO"
													title="카카오톡으로 로그인 선택"><img
													src="../../../static/pc/images/member/ico-kakao.png"
													alt="카카오톡">
												<!--카카오톡--> 카카오톡으로 로그인<!--카카오톡으로 로그인--></a> <a
													href="javaScript:void(0)" lnkgty="PAYCO"
													title="페이코로 로그인 선택"><img
													src="../../../static/pc/images/member/ico-payco.png"
													alt="페이코">
												<!--페이코--> 페이코로 로그인<!--페이코로 로그인--></a>
											</div>
										</div>
									</div>

									<div class="col right">
										<div class="login-ad" id="Rw6jtk0hQTuOBSzFbvGGlw"></div>
									</div>
								</div>
								<!--// col-wrap -->
							</div>
						</div>
						<!--// tab 회원 로그인 -->

						<!-- tab 비회원 로그인 -->
						<div id="login_tab_02" class="tab-cont">
							<a href="" class="ir"></a><a href="" class="ir" title="비회원 로그인"></a>

							<div class="login-member col-2">
								<!-- col-wrap -->
								<div class="col-wrap">
									<div class="col left">

										<div class="no-member-login-table">
											<table
												summary="이름, 생년월일, 휴대폰번호, 인증번호, 비밀번호, 비밀번호 확인 항목을 가진 비회원 로그인 입력 표">
												<caption>
													이름, 생년월일, 휴대폰번호, 인증번호, 비밀번호, 비밀번호 확인 항목을 가진 비회원 로그인 입력 표
													<!--이름, 생년월일, 휴대폰번호, 인증번호, 비밀번호, 비밀번호 확인 항목을 가진 비회원 로그인 입력 표-->
												</caption>
												<colgroup>
													<col style="width: 110px;">
													<col>
												</colgroup>
												<tbody>
													<tr>
														<th scope="row"><label for="ibxNonMbNm">이름<!--이름--></label>
														</th>
														<td><input maxlength="20" id="ibxNonMbNm" type="text"
															placeholder="이름" class="input-text">
														<!--이름--></td>
													</tr>
													<tr>
														<th scope="row"><label for="ibxNonMbByymmdd">생년월일<!--생년월일--></label>
														</th>
														<td><input maxlength="6" id="ibxNonMbByymmdd"
															type="text" placeholder="생년월일 앞6자리" class="input-text">
														<!--주민번호 앞 6자리--></td>
													</tr>
													<tr>
														<th scope="row"><label for="ibxNonMbTelno">휴대폰번호<!--휴대폰번호--></label>
														</th>
														<td>
															<div class="hp-input">
																<input maxlength="11" id="ibxNonMbTelno" type="text"
																	placeholder="- 없이 입력" class="input-text">
																<!--- 없이 입력-->
																<button id="nonMbCertNoSend" type="button"
																	class="button gray" disabled="disabled">
																	인증요청
																	<!--인증요청-->
																</button>
															</div>
															<div id="mblpInput-error-text" class="alert"></div>
														</td>
													</tr>
													<tr id="nonMbCertRow">
														<th scope="row"><label for="mblpCharCertNo">인증번호<!--인증번호--></label>
														</th>
														<td>
															<div class="chk-num">
																<div class="line">
																	<input maxlength="4" id="mblpCharCertNo" type="text"
																		class="input-text">

																	<div class="time-limit" id="timer">3:00</div>
																</div>

																<button id="btnMblpCharCert" type="button"
																	class="button purple" disabled="disabled">
																	확인
																	<!--확인-->
																</button>
															</div>
															<div id="nonMbCert-error-text" class="alert"></div>
														</td>
													</tr>
													<tr>
														<th scope="row"><label for="ibxNonMbPwd">비밀번호</label>
														<!--비밀번호--></th>
														<td><input maxlength="4" id="ibxNonMbPwd"
															type="password" placeholder="비밀번호(숫자 4자리)"
															class="input-text">
														<!--비밀번호(숫자 4자리)--></td>
													</tr>
													<tr>
														<th scope="row"><label for="ibxNonMbPwdConfirm">비밀번호<!--비밀번호-->확인<!--확인--></label>
														</th>
														<td><input maxlength="4" id="ibxNonMbPwdConfirm"
															type="password" placeholder="비밀번호(숫자 4자리) 확인"
															class="input-text">
														<!--비밀번호(숫자 4자리) 확인-->
															<div id="nonMbPwdErrText" class="alert"></div></td>
													</tr>
												</tbody>
											</table>
										</div>
									</div>

									<div class="col right">

										<div class="no-member-privacy-rule">
											<p class="tit">
												비회원예매 개인정보 처리방침
												<!--비회원예매 개인정보 처리방침-->
											</p>

											<div class="cont">
												<dl>
													<dt>수집목적</dt>
													<dd>비회원예매 서비스 제공 / 이용자식별 / 구매 및 결제</dd>
													<dt>수집항목</dt>
													<dd>이름, 생년월일, 휴대폰번호, 비밀번호</dd>
													<dt>보유기간</dt>
													<dd>관람 또는 취소 후 7일 이내</dd>
													<!--<dt>수집목적</dt><dd>비회원예매 서비스 제공 / 이용자식별 / 구매 및  결제</dd><dt>수집항목</dt><dd>이름, 생년월일, 휴대폰번호, 비밀번호</dd><dt>보유기간</dt><dd>관람 또는 취소 후 7일 이내</dd>-->
												</dl>

												<div class="btn-agree">
													<input type="radio" id="chkNonMbBokdPersonInfoProcTrue"
														name="chkNonMbBokdPersonInfoProc"> <label
														for="chkNonMbBokdPersonInfoProcTrue">동의<!--동의--></label> <input
														type="radio" id="chkNonMbBokdPersonInfoProcFalse"
														name="chkNonMbBokdPersonInfoProc" class="ml20"> <label
														for="chkNonMbBokdPersonInfoProcFalse">미동의<!--미동의--></label>
												</div>

												<ul class="dot-list gblue mt20">
													<li class="font-gblue">정보수집에 동의를 거부할 수 있으며, 동의하지 않을 경우
														비회원 예매서비스를 이용하실 수 없습니다.<!--정보수집에 동의를 거부할 수 있으며, 동의하지 않을 경우 비회원 예매서비스를 이용하실 수 없습니다.-->
													</li>
												</ul>
											</div>
										</div>
									</div>
								</div>
								<!--// col-wrap -->

								<div class="btn-group">
									<button id="btnChkNonMbLogin" type="button"
										class="button purple" disabled="disabled">확인</button>
									<a id="aNonMbLogin" href="#layer_no_member_chk"
										class="button purple btn-modal-open" w-data="600" h-data="320"
										style="display: none;"></a>
								</div>
							</div>
						</div>
						<!--// tab 비회원 로그인 -->
					</div>
					<!--// tab-cont-wrap -->
				</div>

				<button type="button" class="btn-modal-close">
					레이어 닫기
					<!--레이어 닫기-->
				</button>
			</div>
		</section>

		<section id="layer_no_member_chk" class="modal-layer">
			<a href="" class="focus">레이어로 포커스 이동 됨</a>
			<div class="wrap">
				<header class="layer-header">
					<h3 class="tit">알림</h3>
				</header>

				<div class="layer-con">
					<p>티켓 발권을 위한 입력정보를 확인해 주세요.</p>

					<div class="table-wrap v1">
						<table class="data-table"
							summary="이름, 생년월일, 휴대폰번호 항목을 가진 비회원 티켓 발권을 위한 입력정보 표">
							<caption>이름, 생년월일, 휴대폰번호 항목을 가진 비회원 티켓 발권을 위한 입력정보 표</caption>
							<colgroup>
								<col style="width: 80px;">
								<col>
							</colgroup>
							<tbody>
								<tr>
									<th scope="row" class="a-l">이름</th>
									<td></td>
								</tr>
								<tr>
									<th scope="row" class="a-l">생년월일</th>
									<td></td>
								</tr>
								<tr>
									<th scope="row" class="a-l">휴대폰번호</th>
									<td></td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>

				<div class="btn-group-fixed">
					<button type="button" class="button close-layer small">취소</button>
					<button id="btnNonMbLogin" type="button"
						class="button purple small" disabled="disabled">확인</button>
				</div>

				<button id="btnNonMbModalClose" type="button"
					class="btn-modal-close">레이어 닫기</button>
			</div>
		</section>
		<!--  ko_KR -->


		<script type="text/javascript">
    $(function(){
        
            
                $('#header .right-link .before').show();
                $('#header .right-link .after').hide();
                //session 관련 처리를 위한 부분
                $.ajaxMegaBox({
                    url: '/sessionChk.do',
                    success: function(data) {
                        var loginYn = data.loginYn;
                        if(loginYn == 'Y'){
                            $('.right-link .before').hide();
                        $('.right-link .after').show();
                        }else{
                            $('.right-link .before').show();
                        $('.right-link .after').hide();
                        }
                     }
               });
            
            
        

        // 웹에서만 실행 -> facebook을 로드하지 않는 템플릿에서 반복적인 오류 발생으로 hreader로 이전
        if(!MegaboxUtil.Common.isMobile() && !MegaboxUtil.Common.isApp())
            MegaboxUtil.Share.init();
    });

    //로그인 버튼
    $(document).on('click', '#moveLogin', function() {

        fn_viewLoginPopup('default','pc');

    });

    var sysCd = 'ON';

  	//넷퍼넬 스킨 타입 지정
	NetfunnelChk.setting( sysCd, MegaboxUtil.Common.isApp() );

</script>


		<!-- 메인에만 광고영역 노출 -->

		<!-- 메인 영화에만 광고영역 노출 -->


		<!-- header -->
		<header id="header">
			<h1 class="ci">
				<a href="/" title="MEGABOX 메인으로 가기">MEGABOX : Life Theater</a>
			</h1>

			<!-- 브라우저 다운로드 -->


			<script type="text/javascript">
    $(function(){
	  	//닫기 버튼 클릭
		$('.ie-update').on('click', '.close-chk .closeDl', function() {
			 if ($(":checkbox[id='one_month_no_update']:checked").length > 0) {
				fn_setCookie("BROWDER_DL", "Y", 30);
			}

			$('.ie-update').hide();
		});

		//다시보지 않기
		 if (fn_getCookie("BROWDER_DL") == null || fn_getCookie("BROWDER_DL") == 'N') {
			if ( $(".lt-ie9").length > 0 && $('.ie-update').length > 0 ) {
				$('.ie-update').show();
			}
		}
    });
    </script>
			<!-- ie-update : ie 9 이하 일때만 출력 -->
			<div class="ie-update">
				<div class="dimd"></div>
				<div class="wrap">
					<p class="tit">
						<img src="../../../static/pc/images/ie/txt-update.png"
							alt="megabox 홈페이지는 internet explrer10이상에서 최적화된 서비스 이용이 가능합니다. ie9 이하에서는 예매가 정상적으로 진행되지 않을 수 있으니, 브라우저를 업그레이드하시거나 다른 예매수단을 이용해 주세요!">
					</p>

					<div class="box">
						<div class="col">
							<p class="txt">
								브라우저를 최신 버전으로<br>업그레이드 해보세요!
							</p>

							<div class="link">
								<a
									href="https://www.microsoft.com/ko-kr/download/internet-explorer.aspx"
									title="internet explorer 새 버전 다운로드" target="_blank"> <img
									src="../../../static/pc/images/ie/btn-ie.png"
									alt="internet explorer 새 버전 다운로드">
								</a>
							</div>

							<div class="link">
								<a href="http://www.google.com/chrome?hl=ko" title="chrome 다운로드"
									target="_blank"> <img
									src="../../../static/pc/images/ie/btn-chrome.png"
									alt="chrome 다운로드">
								</a>
							</div>
						</div>

						<div class="col">
							<p class="txt">
								megabox 모바일 app을<br>이용해 보세요!
							</p>

							<div class="link">
								<a
									href="https://itunes.apple.com/us/app/megabox/id894443858?l=ko&amp;ls=1&amp;mt=8"
									title="available on the app store" target="_blank"> <img
									src="../../../static/pc/images/ie/btn-appstore.png"
									alt="available on the app store">
								</a>
							</div>

							<div class="link">
								<a
									href="https://play.google.com/store/apps/details?id=com.megabox.mop&amp;hl=ko"
									title="available on the google play" target="_blank"> <img
									src="../../../static/pc/images/ie/btn-google.png"
									alt="available on the google play">
								</a>
							</div>
						</div>
					</div>

					<div class="close-chk">
						<input type="checkbox" id="one_month_no_update"> <label
							for="one_month_no_update" class="ml05">한 달 동안 이 창을 열지 않음</label>

						<button type="button" class="closeDl button purple x-small ml20">닫기</button>
					</div>
				</div>
			</div>
			<!--// ie-update : ie 9 이하 일때만 출력 -->
			<!--// 브라우저 다운로드 -->

			<!-- topGnb -->




			<!-- 2019-04-15 마크업 수정 : 고객요청  -->
			<div class="util-area">
				<div class="left-link">
					<a href="/benefit/viplounge" title="VIP LOUNGE">VIP LOUNGE</a> <a
						href="/benefit/membership" title="멤버십">멤버십</a> <a href="/support"
						title="고객센터">고객센터</a>
				</div>

				<div class="right-link">
					<!-- 로그인전 -->
					<div class="before" style="">
						<a href="javaScript:fn_viewLoginPopup('default','pc')" title="로그인">로그인</a>
						<a href="/join" title="회원가입">회원가입</a>
					</div>

					<!-- 로그인후 -->
					<div class="after" style="display: none">
						<a href="/on/oh/ohg/MbLogin/mbLogout.do" class="" title="로그아웃">로그아웃</a>
						<a href="" class="notice" title="알림">알림</a>

						<!-- layer-header-notice -->
						<div class="layer-header-notice">
							<div class="notice-wrap">
								<p class="tit-notice">알림함</p>

								<div class="count">
									<p class="left">
										전체 <em class="totalCnt">0</em> 건
									</p>

									<p class="right">* 최근 30일 내역만 노출됩니다.</p>
								</div>

								<!-- scroll -->
								<div
									class="scroll m-scroll mCustomScrollbar _mCS_1 mCS_no_scrollbar">
									<div id="mCSB_1"
										class="mCustomScrollBox mCS-light mCSB_vertical mCSB_inside"
										style="max-height: none;" tabindex="0">
										<div id="mCSB_1_container"
											class="mCSB_container mCS_no_scrollbar_y"
											style="position: relative; top: 0; left: 0;" dir="ltr">
											<ul class="list">
												<li class="no-list">알림 내역이 없습니다.</li>
											</ul>
										</div>
										<div id="mCSB_1_scrollbar_vertical"
											class="mCSB_scrollTools mCSB_1_scrollbar mCS-light mCSB_scrollTools_vertical">
											<div class="mCSB_draggerContainer">
												<div id="mCSB_1_dragger_vertical" class="mCSB_dragger"
													style="position: absolute; min-height: 30px; display: none; top: 0px;">
													<div class="mCSB_dragger_bar" style="line-height: 30px;"></div>
												</div>
												<div class="mCSB_draggerRail"></div>
											</div>
										</div>
									</div>
								</div>
								<div class="notice-list-more">
									<button type="button" class="button btn-more-notice-list">
										더보기 <i class="iconset ico-btn-more-arr"></i>
									</button>
								</div>
								<!--// scroll -->
								<button type="button" class="btn-close-header-notice">알림
									닫기</button>
							</div>
							<!--// notice-wrap -->
							<!--// layer-header-notice -->
						</div>

					</div>

					<a href="/booking">빠른예매</a>
				</div>
			</div>
			<!--// 2019-04-15 마크업 수정 : 고객요청  -->

			<div class="link-area">
				<a href="#layer_sitemap" class="header-open-layer btn-layer-sitemap"
					title="사이트맵">사이트맵</a> <a href="#layer_header_search"
					class="header-open-layer btn-layer-search" title="검색">검색</a> <a
					href="/booking/timetable" class="link-ticket" title="상영시간표">상영시간표</a>
				<a href="#layer_mymega" class="header-open-layer btn-layer-mymega"
					title="나의 메가박스">나의 메가박스</a>
			</div>

			<!-- gnb -->
			<!--
        2019-04-15 마크업 수정 : 고객요청
        1뎁스 a 태그에 각각 다른 class 추가
    -->

			<nav id="gnb">
				<ul class="gnb-depth1">
					<li><a href="/movie" class="gnb-txt-movie" title="영화">영화</a>
						<div class="gnb-depth2">
							<ul>
								<li><a href="/movie" title="전체영화">전체영화</a></li>
								<li><a href="/curation/specialcontent" title="큐레이션">큐레이션</a></li>

								<li id="festivalArea" style="display: none;"><a
									href="/festival" title="영화제">영화제</a></li>
								<li><a href="/moviepost/all" title="무비포스트">무비포스트</a></li>
							</ul>
						</div></li>
					<li><a href="/booking" class="gnb-txt-reserve" title="예매">예매</a>
						<div class="gnb-depth2">
							<ul>
								<li><a href="/booking" title="빠른예매">빠른예매</a></li>
								<li><a href="/booking/timetable" title="상영시간표">상영시간표</a></li>
								<li><a href="/booking/privatebooking" title="더 부티크 프라이빗 예매">더
										부티크 프라이빗 예매</a></li>
							</ul>
						</div></li>
					<li><a href="/theater/list" class="gnb-txt-theater" title="극장">극장</a>
						<div class="gnb-depth2">
							<ul>
								<li><a href="/theater/list" title="전체극장">전체극장</a></li>
								<li><a href="/specialtheater/list" title="특별관">특별관</a></li>
							</ul>
						</div></li>
					<li><a href="javascript:void(0)"
						onclick="NetfunnelChk.aTag('EVENT_LIST','/event');return false;"
						class="gnb-txt-event" title="이벤트">이벤트</a>
						<div class="gnb-depth2">
							<ul>
								<li><a href="javascript:void(0)"
									onclick="NetfunnelChk.aTag('EVENT_LIST','/event');return false;"
									title="진행중 이벤트">진행중 이벤트</a></li>
								<li><a href="javascript:void(0)"
									onclick="NetfunnelChk.aTag('EVENT_LIST','/event/end');return false;"
									title="지난 이벤트">지난 이벤트</a></li>
								<li><a href="javascript:void(0)"
									onclick="NetfunnelChk.aTag('EVENT_LIST','/event/winner/list');return false;"
									title="당첨자발표">당첨자발표</a></li>
							</ul>
						</div></li>
					<li><a href="javascript:void(0)"
						onclick="NetfunnelChk.aTag('STORE_LIST','/store');return false;"
						class="gnb-txt-store" title="스토어">스토어</a></li>
					<li><a href="/benefit/membership" class="gnb-txt-benefit"
						title="혜택">혜택</a>
						<div class="gnb-depth2">
							<ul>
								<li><a href="/benefit/membership" title="메가박스 멤버십">메가박스
										멤버십</a></li>
								<li><a href="/benefit/discount/guide" title="제휴/할인">제휴/할인</a></li>
							</ul>
						</div></li>
				</ul>
			</nav>
			<!--// gnb -->
			<script type="text/javascript">
        $(document).ready(function() {
            var filmCheck = MegaboxUtil.Common.moveMovieFilmCheckGnb(); // 영화제 존재여부 체크
            if(filmCheck == true){
                $("#festivalArea").show();
            }else{
                $("#festivalArea").hide();
            }
        });
    </script>
			<!--// topGnb -->

			<!-- 레이어 : 사이트맵 -->




			<div id="layer_sitemap" class="header-layer layer-sitemap">
				<!-- wrap -->
				<div class="wrap">
					<a href="" class="link-acc" title="사이트맵 레이어 입니다.">사이트맵 레이어 입니다.</a>

					<p class="tit">SITEMAP</p>

					<div class="list position-1">
						<p class="tit-depth">영화</p>

						<ul class="list-depth">
							<li><a href="/movie" title="전체영화">전체영화</a></li>
							<li><a href="/curation/specialcontent" title="큐레이션">큐레이션</a></li>
							<li><a href="javascript:void(0)"
								onclick="javascript:MegaboxUtil.Common.moveMovieFilmCheck();"
								title="영화제">영화제</a></li>
							<li><a href="/moviepost/all" title="무비포스트">무비포스트</a></li>
						</ul>
					</div>

					<div class="list position-2">
						<p class="tit-depth">예매</p>

						<ul class="list-depth">
							<li><a href="/booking" title="빠른예매">빠른예매</a></li>
							<li><a href="/booking/timetable" title="상영시간표">상영시간표</a></li>
							<li><a href="/booking/privatebooking" title="더 부티크 프라빗 예매">더
									부티크 프라이빗 예매</a></li>
							<!-- <li><a href="/booking?megaboxLanguage=en" title="English Ticketing">English Ticketing</a></li> -->
						</ul>
					</div>

					<div class="list position-3">
						<p class="tit-depth">극장</p>

						<ul class="list-depth">
							<li><a href="/theater/list" title="전체극장">전체극장</a></li>
							<li><a href="/specialtheater/list" title="특별관">특별관</a></li>
						</ul>
					</div>

					<div class="list position-4">
						<p class="tit-depth">이벤트</p>

						<ul class="list-depth">
							<li><a href="javascript:void(0)"
								onclick="NetfunnelChk.aTag('EVENT_LIST','/event');return false;"
								title="진행중 이벤트">진행중 이벤트</a></li>
							<li><a href="javascript:void(0)"
								onclick="NetfunnelChk.aTag('EVENT_LIST','/event/end');return false;"
								title="지난 이벤트">지난 이벤트</a></li>
							<li><a href="javascript:void(0)"
								onclick="NetfunnelChk.aTag('EVENT_LIST','/event/winner/list');return false;"
								title="당첨자발표">당첨자발표</a></li>
						</ul>
					</div>

					<div class="list position-5">
						<p class="tit-depth">스토어</p>

						<ul class="list-depth">
							<li><a href="javascript:void(0)"
								onclick="NetfunnelChk.aTag('STORE_LIST','/store');return false;"
								title="새로운 상품">새로운 상품</a></li>
							<li><a href="javascript:void(0)"
								onclick="NetfunnelChk.aTag('STORE_LIST','/store/megaticket');return false;"
								title="메가티켓">메가티켓</a></li>
							<li><a href="javascript:void(0)"
								onclick="NetfunnelChk.aTag('STORE_LIST','/store/megachance');return false;"
								title="메가찬스">메가찬스</a></li>
							<li><a href="javascript:void(0)"
								onclick="NetfunnelChk.aTag('STORE_LIST','/store/popcorn');return false;"
								title="팝콘/음료/굿즈">팝콘/음료/굿즈</a></li>
							<!-- <li><a href="javascript:void(0)" onclick="NetfunnelChk.aTag('STORE_LIST','/store/e-giftcard');return false;" title="기프트카드">기프트카드</a></li> -->
						</ul>
					</div>
					<div class="list position-6">
						<p class="tit-depth">나의 메가박스</p>
						<ul class="list-depth mymage">


							<li><a
								href="javascript:movePage('/mypage',						'로그인이 필요한 서비스 입니다. \n로그인하시겠습니까?');"
								title="나의 메가박스 홈">나의 메가박스 홈</a></li>
							<li><a
								href="javascript:movePage('/mypage/bookinglist',			'로그인이 필요한 서비스 입니다. \n로그인하시겠습니까?');"
								title="예매/구매내역">예매/구매내역</a></li>
							<li><a
								href="javascript:movePage('/mypage/movie-coupon',		'로그인이 필요한 서비스 입니다. \n로그인하시겠습니까?');"
								title="영화관람권">영화관람권</a></li>
							<li><a
								href="javascript:movePage('/mypage/store-coupon',		'로그인이 필요한 서비스 입니다. \n로그인하시겠습니까?');"
								title="스토어교환권">스토어교환권</a></li>
							<li><a
								href="javascript:movePage('/mypage/discount-coupon',		'로그인이 필요한 서비스 입니다. \n로그인하시겠습니까?');"
								title="할인/제휴쿠폰">할인/제휴쿠폰</a></li>

							<li><a
								href="javascript:movePage('/mypage/point-list',			'로그인이 필요한 서비스 입니다. \n로그인하시겠습니까?');"
								title="멤버십포인트">멤버십포인트</a></li>
							<li><a
								href="javascript:movePage('/mypage/moviestory',			'로그인이 필요한 서비스 입니다. \n로그인하시겠습니까?');"
								title="나의 무비스토리">나의 무비스토리</a></li>
							<li><a
								href="javascript:movePage('/mypage/myevent',				'로그인이 필요한 서비스 입니다. \n로그인하시겠습니까?');"
								title="나의 이벤트 응모내역">나의 이벤트 응모내역</a></li>
							<li><a
								href="javascript:movePage('/mypage/myinquiry',			'로그인이 필요한 서비스 입니다. \n로그인하시겠습니까?');"
								title="나의 문의내역">나의 문의내역</a></li>
							<li><a href="#" title="자주쓰는 할인 카드">자주쓰는 할인 카드</a></li>
							<li><a
								href="javascript:movePage('/on/oh/ohh/Mypage/mainPage.do?returnURL=info','로그인이 필요한 서비스 입니다.');"
								title="회원정보">회원정보</a></li>



						</ul>
					</div>

					<div class="list position-7">
						<p class="tit-depth">혜택</p>

						<ul class="list-depth">
							<li><a href="/benefit/membership" title="멤버십 안내">멤버십 안내</a></li>
							<li><a href="/benefit/viplounge" title="VIP LOUNGE">VIP
									LOUNGE</a></li>
							<li><a href="/benefit/discount/guide" title="제휴/할인">제휴/할인</a></li>
						</ul>
					</div>

					<div class="list position-8">
						<p class="tit-depth">고객센터</p>

						<ul class="list-depth">
							<li><a href="/support" title="고객센터 홈">고객센터 홈</a></li>
							<li><a href="/support/faq" title="자주묻는질문">자주묻는질문</a></li>
							<li><a href="/support/notice" title="공지사항">공지사항</a></li>
							<li><a href="/support/inquiry" title="1:1문의">1:1문의</a></li>
							<li><a href="/support/rent" title="단체/대관문의">단체/대관문의</a></li>
							<li><a href="/support/lost" title="분실물문의">분실물문의</a></li>
						</ul>
					</div>

					<div class="list position-9">
						<p class="tit-depth">회사소개</p>

						<ul class="list-depth">
							<li><a href="/megaboxinfo" target="_blank" title="메가박스소개">메가박스소개</a></li>
							<li><a href="/socialcontribution" target="_blank"
								title="사회공헌">사회공헌</a></li>
							<li><a href="/advertize" target="_blank" title="홍보자료">홍보자료</a></li>
							<li><a href="/partner" target="_blank" title="제휴/부대사업문의">제휴/부대사업문의</a></li>
							<li><a href="/onlinereport" target="_blank" title="온라인제보센터">온라인제보센터</a></li>
							<li><a href="/ir" target="_blank" title="자료">IR자료</a></li>
							<li><a href="/recruit" target="_blank" title="인재채용림">인재채용</a></li>
							<li><a href="https://jebo.joonganggroup.com/main.do"
								target="_blank" title="윤리경영">윤리경영</a></li>
						</ul>
					</div>

					<div class="list position-10">
						<p class="tit-depth">이용정책</p>

						<ul class="list-depth">
							<li><a href="/support/terms" title="이용약관">이용약관</a></li>
							<li><a href="/support/privacy" title="개인정보처리방침">개인정보처리방침</a></li>
							<li><a href="/support/screenrule" title="스크린수배정에관한기준">스크린수배정에관한기준</a></li>
						</ul>
					</div>

					<div class="ir">
						<a href="" class="layer-close" title="레이어닫기">레이어닫기</a>
					</div>
				</div>
				<!--// wrap -->
			</div>
			<!--// 레이어 : 사이트맵 -->

			<!-- 레이어 : 검색 -->
			<div id="layer_header_search"
				class="header-layer layer-header-search"></div>
			<!--// 레이어 : 검색 -->

			<!-- 레이어 : 마이페이지 -->




			<div id="layer_mymega" class="header-layer layer-mymege">
				<a href="" class="ir" title="나의 메가박스 레이어 입니다.">나의 메가박스 레이어 입니다.</a>

				<!-- wrap -->
				<div class="wrap" style="display: none">

					<div class="login-after">
						<div class="user-info">
							<p class="txt">안녕하세요!</p>

							<p class="info">
								<!--
                            vip 일때만 출력
                            vip 아닐때는 태그 자체 삭제
                        -->
								<em class="vip">VIP PREMIUM</em> <em class="name"></em> <span>회원님</span>
							</p>

							<div class="last-date">
								마지막 접속일 : <em></em>
							</div>

							<!-- vip, 멤버십 없을때는 미 출력  -->
							<div class="membership">
								<!-- <i class="iconset ico-header-vip"></i>
                        <i class="iconset ico-header-film"></i>
                        <i class="iconset ico-header-classic"></i> -->
							</div>

							<div class="btn-fixed">
								<a href="/mypage" class="button" title="나의  메가박스">나의 메가박스</a>
							</div>
						</div>

						<div class="box">
							<div class="point">
								<p class="tit">Point</p>

								<p class="count">0</p>

								<div class="btn-fixed">
									<a href="/mypage/point-list" class="button" title="멤버십 포인트">멤버십
										포인트</a>
								</div>
							</div>
						</div>

						<div class="box">
							<div class="coupon">
								<p class="tit">
									쿠폰/관람권
									<!-- <i class="iconset ico-header-new"></i> -->
								</p>

								<p class="count">
									<em title="쿠폰 수" class="cpon">0</em> <span title="관람권 수"
										class="movie">0</span>
								</p>

								<div class="btn-fixed">
									<a href="/mypage/discount-coupon" class="button" title="쿠폰">쿠폰</a>
									<a href="/mypage/movie-coupon" class="button" title="관람권">관람권</a>
								</div>
							</div>
						</div>

						<div class="box">
							<div class="reserve">
								<p class="tit">
									예매
									<!-- <i class="iconset ico-header-new"></i> -->
								</p>

								<p class="txt"></p>

								<div class="btn-fixed">
									<a href="/mypage/bookinglist" class="button" title="예매내역">예매내역
									</a>
								</div>
							</div>
						</div>

						<div class="box">
							<div class="buy">
								<p class="tit">
									구매
									<!-- <i class="iconset ico-header-new"></i> -->
								</p>

								<p class="count">
									<em>0</em> <span>건</span>
								</p>
							</div>

							<div class="btn-fixed">
								<a href="/mypage/bookinglist?tab=02" class="button" title="구매내역">구매내역</a>
							</div>
						</div>
					</div>

					<!-- 로그인 전 -->
					<div class="login-before">
						<p class="txt">
							로그인 하시면 나의 메가박스를 만날 수 있어요.<br> 영화를 사랑하는 당신을 위한 꼭 맞는 혜택까지 확인해
							보세요!
						</p>

						<div class="mb50">
							<a href="#layer_login_common" id="moveLogin" title="로그인"
								class="button w120px btn-modal-open" w-data="850" h-data="484">로그인</a>
						</div>

						<a href="/join" class="link" title="혹시 아직 회원이 아니신가요?">혹시 아직
							회원이 아니신가요?</a>
					</div>
				</div>
				<!--// wrap -->

				<div class="ir">
					<a href="" class="layer-close" title="레이어닫기">레이어닫기</a>
				</div>
			</div>
			<!--// 레이어 : 마이페이지 -->

		</header>
		<!--// header -->

		<!-- 		<div id="bodyContent"> -->




		<script type="text/javascript">
var tabIdx = 1;

/* var tabTitle = [
	'박스오피스 < 영화 | 라이프씨어터,메가박스',
	'상영예정작 < 영화 | 라이프씨어터,메가박스',
	'필름소사이어티 < 영화 | 라이프씨어터,메가박스',
	'클래식소사이어티 < 영화 | 라이프씨어터,메가박스',
	'장르모아보기 < 영화 | 라이프씨어터,메가박스'
]; */

$(function() {
	// 검색 버튼
	$('#btnSearch').on('click', function() {
		/* if($('#ibxMovieNmSearch').val() == '')
			return gfn_alertMsgBox('영화명을 입력해주세요.');
		*/
		// 메타 테그 URL 설정
		$('#fbUrl').attr('content', fn_getMetaShareURL(tabIdx));
		$('#currentPage').val("1");
		fn_movieSerach();
	});

	// 검색 input enter key 이벤트
	$('#ibxMovieNmSearch').on('keydown', function(e) {
		if(e.keyCode == 13) {
			/* if($('#ibxMovieNmSearch').val() == '') gfn_alertMsgBox('영화명을 입력해주세요.');
			else fn_movieSerach(); */
			$('#currentPage').val("1");
			fn_movieSerach();
		}
	});

	// 더보기 버튼
	$('#btnAddMovie').on('click', function() {
		fn_movieSerach(true);
	});

	// 상단 탭 버튼
	/* $('#topMenu a').on('click', function(e) {

		/e.preventDefault();

		tabIdx = $(this).parent().index() + 1;

		// 메타 테그 URL 설정
		$('#fbUrl').attr('content', fn_getMetaShareURL(tabIdx));
		$('#ibxMovieNmSearch').val('');

		document.title = tabTitle[tabIdx - 1]; // 브라우저 타이틀 변경

		fn_init(); // 페이지 초기화
	}); */

	$('#ibxMovieNmSearch').val('');

	fn_init(); // 페이지 초기화
});

// 페이지 초기화
function fn_init() {
	$('.topSort').hide();

	/* if(tabIdx == 2) fn_playDueInit(); // 상영예정작
	else if(tabIdx == 3) fn_filmInit(); // 필름소사이어티
	else if(tabIdx == 4) fn_classicInit(); // 클래식소사이어티
	else if(tabIdx == 5) fn_myGenreInit(); // 장르모아보기
	else fn_boxOfficeInit(); // 박스오피스  */

	switch( tabIdx ){
	    case 2 : fn_playDueInit(); break;		// 상영예정작
	    case 3 : fn_filmInit(); break;			// 필름소사이어티
	    case 4 : fn_classicInit(); break;		// 클래식소사이어티
	    case 5 : fn_myGenreInit(); break; 		// 장르모아보기
	    default   : fn_boxOfficeInit();	break;	// 박스오피스
    }


	$('#topMenu li.on').removeClass('on');
	$('#topMenu li').eq(tabIdx - 1).addClass('on'); // 상단 탭 활성화
};

// 메타테그 공유 URL 생성
function fn_getMetaShareURL(tabIdx) {
	var metaMenuIDAr = ['ON00000006', 'ON00000013', 'ON00000014', 'ON00000015', 'ON00000016'];
	var url = location.href + '?metaMenuId=' + metaMenuIDAr[tabIdx - 1];
	var serachText = $('#ibxMovieNmSearch').val();

	// 초기화가 아니고 검색어 존재시 설정
	if(serachText) url += '&searchText=' + serachText;

	return url;
};

// 정렬 대상 태그 활성화 및 가져오기
function fn_getSortTargetByShow() {
	var sortTarget = $('.topSort').eq(tabIdx - 1);
	sortTarget.show();

	return sortTarget;
};

// 개봉작만보기 버튼 이벤트
function fn_bindOnAirEvent() {
	var sortTarget = fn_getSortTargetByShow();

	// 개봉작만보기
	sortTarget.find('.btnOnAir').off().on('click', function() {
		var onairYn = $(this).attr('class').indexOf(' on') == -1 ? 'Y' : 'N';
		$('#onairYn').val(onairYn);
		$('#currentPage').val("1");
		fn_movieSerach(); // 영화목록 조회
	});
};

// 정렬버튼 이벤트
function fn_bindSortTabEvent() {
	var sortTarget = fn_getSortTargetByShow();

	// 정렬 버튼
	sortTarget.find('.sortTab button').off().on('click', function() {
		sortTarget.find('.sortTab button.on').removeClass('on');
		$(this).addClass('on');
		$('#pageType').val($(this).attr('sort-type'));
		$('#currentPage').val("1");
		fn_movieSerach(); // 영화목록 조회
	});
};

// 박스오피스 초기화
function fn_boxOfficeInit() {
	$('#onairYn').val('N');
	$('#specialType').val('');
	$('#pageType').val('ticketing');

	fn_movieSerach(); // 영화목록 조회
	fn_bindOnAirEvent(); // 개봉작만보기 버튼 이벤트
	fn_bindSortTabEvent(); // 정렬버튼 이벤트
};

// 상영예정작 초기화
function fn_playDueInit() {
	$('#specialType').val('');
	$('#onairYn').val('MSC02');
	$('#pageType').val('rfilmDe');

	fn_movieSerach(); // 영화목록 조회
	fn_bindSortTabEvent(); // 정렬버튼 이벤트
};

// 필름소사이어티 초기화
function fn_filmInit() {
	$('#onairYn').val('N');
	$('#specialType').val('film');
	$('#pageType').val('ticketing');

	fn_movieSerach(); // 영화목록 조회
	fn_bindOnAirEvent(); // 개봉작만보기 버튼 이벤트
	fn_bindSortTabEvent(); // 정렬버튼 이벤트
};

// 클래식소사이어티 초기화
function fn_classicInit() {
	$('#onairYn').val('N');
	$('#specialType').val('classic');
	$('#pageType').val('ticketing');

	fn_movieSerach(); // 영화목록 조회
	fn_bindOnAirEvent(); // 개봉작만보기 버튼 이벤트
	fn_bindSortTabEvent(); // 정렬버튼 이벤트
};

// 장르모아보기 초기화
function fn_myGenreInit() {
	$('#onairYn').val('N');
	$('#pageType').val('ticketing');
	$('#specialType').val('myGenre');

	fn_movieSerach(); // 영화목록 조회
	fn_bindOnAirEvent(); // 개봉작만보기 버튼 이벤트
	fn_bindSortTabEvent(); // 정렬버튼 이벤트
};

// 영화목록 조회
function fn_movieSerach(paging) {
	var currentPage = paging ? parseInt($('#currentPage').val()) + 1 : $('#currentPage').val();

	gfn_logdingModal(); // 로딩바 호출

	$.ajaxMegaBox({
        url: '/on/oh/oha/Movie/selectMovieList.do',
		data: JSON.stringify({
			currentPage: currentPage + '',
			recordCountPerPage: $('#recordCountPerPage').val() + '',
			pageType: $('#pageType').val(),
			ibxMovieNmSearch: $('#ibxMovieNmSearch').val(),
			onairYn: $('#onairYn').val(),
			specialType: $('#specialType').val()
		}),
        success: function (d) {
        	MegaboxUtil.Movie.setImgSvrUrl(d.imgSvrUrl); // 이미지 서버 URL 설정
			MegaboxUtil.Movie.createHtml(d.movieList, $('#movieList'), paging); // 영화 목록 생성

        	if(d.movieList.length > 0) {
				var totalCnt = d.movieList[0].totCnt;
        		var currentPage = d.movieList[0].currentPage;
				var recordCountPerPage = d.movieList[0].recordCountPerPage;
        		var pageNo = Math.ceil(totalCnt / recordCountPerPage);

				$('#noDataDiv').hide();
        		$('#noMyGenre').hide();
				$('#movieList').show();

				//현재페이지 설정되도록 수정
				$('#currentPage').val(currentPage);

				if(currentPage < pageNo) $('#addMovieDiv').show();
				else $('#addMovieDiv').hide();
        	} else {
        		if (tabIdx == "5" && d.myGenreYn == "N") {
            		$('#noMyGenre').show();
        		} else {
            		$('#noDataDiv').show();
        		}

				$('#movieList').hide();
				$('#addMovieDiv').hide();
        	}

        	$('#totCnt').html(totalCnt || 0);

        	gfn_logdingModal(); // 로딩바 호출
        },
        error: function() {
        	gfn_logdingModal(); // 로딩바 호출
        }
    });
};
</script>

		<input type="hidden" id="currentPage" name="currentPage" value="1">
		<input type="hidden" id="recordCountPerPage" name="recordCountPerPage"
			value="20"> <input type="hidden" id="pageType"
			name="pageType" value="ticketing"> <input type="hidden"
			id="onairYn" name="onairYn" value="N"> <input type="hidden"
			id="specialType" name="specialType" value="">

		<!-- container -->
		<div class="container">
			<div class="page-util">
				<div class="inner-wrap">
					<div class="location">
						<span>Home</span> <a href="/movie" title="영화 페이지로 이동">영화</a> <a
							href="/movie" title="전체영화 페이지로 이동">전체영화</a>
					</div>


				</div>
			</div>

			<!-- contents -->
			<div id="contents" class="">
				<!-- inner-wrap -->
				<div class="inner-wrap">
					<h2 class="tit">전체영화</h2>

					<div class="tab-list fixed">
						<ul id="topMenu">
							<li class="on"><a href="/movie" title="박스오피스 탭으로 이동">박스오피스</a></li>
							<li><a href="/movie/comingsoon" title="상영예정작 탭으로 이동">상영예정작</a></li>
							<li><a href="/movie/film" title="필름소사이어티 탭으로 이동">필름소사이어티</a></li>
							<li><a href="/movie/classic" title="클래식소사이어티 탭으로 이동">클래식소사이어티</a></li>

						</ul>
					</div>

					<!-- movie-list-util -->
					<div class="movie-list-util mt40">
						<!-- 박스오피스 -->
						<div class="topSort" style="display: block;">
							<div class="movie-sorting sortTab">
								<!-- 						<span><button type="button" class="btn on" sort-type="ticketing">예매율순</button></span> -->
								<!-- 						<span><button type="button" class="btn" sort-type="accmAdnc">누적관객순</button></span> -->
								<!-- 						<span><button type="button" class="btn" sort-type="megaScore">메가스코어순</button></span> -->
							</div>

							<div class="onair-condition">
								<button type="button" title="개봉작만 보기" class="btn-onair btnOnAir">개봉작만</button>
							</div>
						</div>
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

							<div class="onair-condition">
								<button type="button" title="개봉작만 보기" class="btn-onair btnOnAir">개봉작만</button>
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

						<!-- 장르모아보기 -->
						<div class="topSort" style="display: none;">
							<div class="movie-sorting sortTab">
								<span><button type="button" class="btn on"
										sort-type="ticketing">예매율순</button></span> <span><button
										type="button" class="btn" sort-type="accmAdnc">누적관객순</button></span>
								<span><button type="button" class="btn"
										sort-type="megaScore">메가스코어순</button></span>
							</div>

							<div class="onair-condition">
								<button type="button" title="개봉작만 보기" class="btn-onair btnOnAir">개봉작만</button>
							</div>
						</div>
						<!--// 장르모아보기 -->

						<!-- 검색결과 없을 때 -->
						<p class="no-result-count">
							<strong id="totCnt">101</strong>개의 영화가 검색되었습니다.
						</p>
						<!--// 검색결과 없을 때 -->

						<div class="movie-search">
							<input type="text" title="영화명을 입력하세요" id="ibxMovieNmSearch"
								name="ibxMovieNmSearch" placeholder="영화명 검색" class="input-text">
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
							<li tabindex="0" class="no-img"><div class="movie-list-info">
									<p class="rank" style="">
										1<span class="ir">위</span>
									</p>
									<img
										src="https://img.megabox.co.kr/SharedImg/2020/03/11/Qgl73W9FxEMYJnnaOYPFtyqSrqB3vmJ2_420.jpg"
										alt="라라랜드" class="poster lozad" onerror="noImg(this)">
									<div class="curation">
										<p class="film" style="">필름 소사이어티</p>
										<p class="classic" style="display: none">클래식 소사이어티</p>
									</div>
									<div class="screen-type">
										<p class="boutqScreen" style="">부티크</p>
										<p class="mxScreen" style="">MX</p>
									</div>
									<div class="movie-score" style="opacity: 0;">
										<a href="#" class="wrap movieBtn" data-no="20007800"
											title="라라랜드 상세보기">
											<div class="summary">황홀한 사랑, 순수한 희망, 격렬한 열정… 이 곳에서 모든
												감정이 폭발한다! 꿈을 꾸는 사람들을 위한 별들의 도시 ‘라라랜드’. 재즈 피아니스트 ‘세바스찬’(라이언
												고슬링)과 배우 지망생 ‘미아’(엠마 스톤), 인생에서 가장 빛나는 순간 만난 두 사람은 미완성인 서로의
												무대를 만들어가기 시작한다.</div>
											<div class="my-score big">
												<div class="preview">
													<p class="tit">기대평</p>
													<p class="number">
														9.4<span class="ir">점</span>
													</p>
												</div>
												<span class="sign big">pointText</span>
												<div class="review">
													<p class="tit">관람평</p>
													<p class="number after">
														9.5<span class="ir">점</span>
													</p>
												</div>
											</div>
										</a>
									</div>
								</div>
								<div class="tit-area">
									<p class="movie-grade age-12">,</p>
									<p title="라라랜드" class="tit">라라랜드</p>
								</div>
								<div class="rate-date">
									<span class="rate">예매율 14.6%</span> <span class="date">개봉일
										2020.03.25</span>
								</div>
								<div class="btn-util">
									<button type="button" class="button btn-like"
										data-no="20007800">
										<i title="보고싶어 안함"
											class="iconset ico-heart-toggle-gray intrstType"></i> <span>1.1k</span>
									</button>
									<p class="txt movieStat1" style="display: none">상영예정</p>
									<p class="txt movieStat2" style="display: none">3월 개봉예정</p>
									<p class="txt movieStat5" style="display: none">개봉예정</p>
									<p class="txt movieStat6" style="display: none">상영종료</p>
									<div class="case col-2 movieStat3" style="">
										<a href="#" class="button purple bokdBtn" data-no="20007800"
											title="영화 예매하기">예매</a> <a href="#"
											class="button purple bokdMxBtn" data-no="20007800"
											title="MX관 예매하기">MX</a>
									</div>
									<div class="case movieStat4" style="display: none">
										<a href="#" class="button purple bokdBtn" data-no="20007800"
											title="영화 예매하기">예매</a>
									</div>
								</div></li>
							<li tabindex="0" class="no-img"><div class="movie-list-info">
									<p class="rank" style="">
										2<span class="ir">위</span>
									</p>
									<img
										src="https://img.megabox.co.kr/SharedImg/2020/02/21/IyeZJvAzV3QgEoW4F7HzdS97zfLYfcni_420.jpg"
										alt="1917" class="poster lozad" onerror="noImg(this)">
									<div class="curation">
										<p class="film" style="display: none">필름 소사이어티</p>
										<p class="classic" style="display: none">클래식 소사이어티</p>
									</div>
									<div class="screen-type">
										<p class="boutqScreen" style="">부티크</p>
										<p class="mxScreen" style="">MX</p>
									</div>
									<div class="movie-score" style="opacity: 0;">
										<a href="#" class="wrap movieBtn" data-no="01685000"
											title="1917 상세보기">
											<div class="summary">두 명의 병사, 하나의 미션! 그들이 싸워야 할 것은 적이
												아니라 시간이었다! 제1차 세계대전이 한창인 1917년. 독일군에 의해 모든 통신망이 파괴된 상황 속에서
												영국군 병사 '스코필드'(조지 맥케이)와 '블레이크'(딘-찰스 채프먼)에게 하나의 미션이 주어졌다. 함정에
												빠진 영국군 부대의 수장 '매켄지' 중령(베네딕트 컴버배치)에게 '에린무어' 장군(콜린 퍼스)의 공격 중지
												명령을 전하는 것! 둘은 1600명의 아군과 '블레이크'의 형(리차드 매든)을 구하기 위해 전쟁터 한복판을
												가로지르며 사투를 이어가는데...</div>
											<div class="my-score big">
												<div class="preview">
													<p class="tit">기대평</p>
													<p class="number">
														8.3<span class="ir">점</span>
													</p>
												</div>
												<span class="sign big">pointText</span>
												<div class="review">
													<p class="tit">관람평</p>
													<p class="number after">
														8.9<span class="ir">점</span>
													</p>
												</div>
											</div>
										</a>
									</div>
								</div>
								<div class="tit-area">
									<p class="movie-grade age-15">,</p>
									<p title="1917" class="tit">1917</p>
								</div>
								<div class="rate-date">
									<span class="rate">예매율 7.1%</span> <span class="date">개봉일
										2020.02.19</span>
								</div>
								<div class="btn-util">
									<button type="button" class="button btn-like"
										data-no="01685000">
										<i title="보고싶어 안함"
											class="iconset ico-heart-toggle-gray intrstType"></i> <span>1.2k</span>
									</button>
									<p class="txt movieStat1" style="display: none">상영예정</p>
									<p class="txt movieStat2" style="display: none">2월 개봉예정</p>
									<p class="txt movieStat5" style="display: none">개봉예정</p>
									<p class="txt movieStat6" style="display: none">상영종료</p>
									<div class="case col-2 movieStat3" style="">
										<a href="#" class="button purple bokdBtn" data-no="01685000"
											title="영화 예매하기">예매</a> <a href="#"
											class="button purple bokdMxBtn" data-no="01685000"
											title="MX관 예매하기">MX</a>
									</div>
									<div class="case movieStat4" style="display: none">
										<a href="#" class="button purple bokdBtn" data-no="01685000"
											title="영화 예매하기">예매</a>
									</div>
								</div></li>
							<li tabindex="0" class="no-img"><div class="movie-list-info">
									<p class="rank" style="">
										3<span class="ir">위</span>
									</p>
									<img
										src="https://img.megabox.co.kr/SharedImg/2020/03/20/DR3GwlMyGWDPNqoX0E5ywhdqxrYSMSXi_420.jpg"
										alt="주디" class="poster lozad" onerror="noImg(this)">
									<div class="curation">
										<p class="film" style="">필름 소사이어티</p>
										<p class="classic" style="display: none">클래식 소사이어티</p>
									</div>
									<div class="screen-type">
										<p class="boutqScreen" style="">부티크</p>
										<p class="mxScreen" style="display: none">MX</p>
									</div>
									<div class="movie-score">
										<a href="#" class="wrap movieBtn" data-no="01687700"
											title="주디 상세보기">
											<div class="summary">&lt;오즈의 마법사&gt;의 영원한 ‘도로시’ 시대를 초월한
												히트송 ‘오버 더 레인보우’의 주인공 20세기 최고의 여배우 주디 갈랜드! 그녀는 자신의 모든 것을 담은
												생애 마지막 무대를 런던에서 준비하는데… 모두가 숨죽인 가운데 막이 오르고 레전드 쇼가 시작된다.

												“Somewhere Over the Rainbow”</div>
											<div class="my-score big">
												<div class="preview">
													<p class="tit">기대평</p>
													<p class="number">
														8.6<span class="ir">점</span>
													</p>
												</div>
												<span class="sign big">pointText</span>
												<div class="review">
													<p class="tit">관람평</p>
													<p class="number after">
														8.7<span class="ir">점</span>
													</p>
												</div>
											</div>
										</a>
									</div>
								</div>
								<div class="tit-area">
									<p class="movie-grade age-12">,</p>
									<p title="주디" class="tit">주디</p>
								</div>
								<div class="rate-date">
									<span class="rate">예매율 6.6%</span> <span class="date">개봉일
										2020.03.25</span>
								</div>
								<div class="btn-util">
									<button type="button" class="button btn-like"
										data-no="01687700">
										<i title="보고싶어 안함"
											class="iconset ico-heart-toggle-gray intrstType"></i> <span>518</span>
									</button>
									<p class="txt movieStat1" style="display: none">상영예정</p>
									<p class="txt movieStat2" style="display: none">3월 개봉예정</p>
									<p class="txt movieStat5" style="display: none">개봉예정</p>
									<p class="txt movieStat6" style="display: none">상영종료</p>
									<div class="case col-2 movieStat3" style="display: none">
										<a href="#" class="button purple bokdBtn" data-no="01687700"
											title="영화 예매하기">예매</a> <a href="#"
											class="button purple bokdMxBtn" data-no="01687700"
											title="MX관 예매하기">MX</a>
									</div>
									<div class="case movieStat4" style="">
										<a href="#" class="button purple bokdBtn" data-no="01687700"
											title="영화 예매하기">예매</a>
									</div>
								</div></li>
							<li tabindex="0" class="no-img"><div class="movie-list-info">
									<p class="rank" style="">
										4<span class="ir">위</span>
									</p>
									<img
										src="https://img.megabox.co.kr/SharedImg/2020/02/12/uPvwgYBnTlO1fdZm8bzilwDoaQJ2F8uA_420.jpg"
										alt="킹 오브 프리즘 올 스타즈 -프리즘 쇼☆베스트10-" class="poster lozad"
										onerror="noImg(this)">
									<div class="curation">
										<p class="film" style="display: none">필름 소사이어티</p>
										<p class="classic" style="display: none">클래식 소사이어티</p>
									</div>
									<div class="screen-type">
										<p class="boutqScreen" style="display: none">부티크</p>
										<p class="mxScreen" style="display: none">MX</p>
									</div>
									<div class="movie-score">
										<a href="#" class="wrap movieBtn" data-no="20004100"
											title="킹 오브 프리즘 올 스타즈 -프리즘 쇼☆베스트10- 상세보기">
											<div class="summary">"마음속의 두근거림이 멈추지 않아!!" 모두를 마음을 사로잡은
												'킹 오브 프리즘' 시리즈가, 이번엔 킹프리 올스타즈로 다시 스크린에 돌아온다! 팬들이 직접 선정한 주옥같은
												프리즘 쇼 베스트 10을 한자리에! 상상 초월한 프리즘 쇼가 당신의 마음을 사로잡는다! 과연 당신의 가슴을
												설레게 할 '프리즘 쇼'의 주인공은 누가 될 것인가?! 60분의 신개념 엔터테인먼트 쇼의 세계로 여러분을
												초대합니다!</div>
											<div class="my-score big">
												<div class="preview">
													<p class="tit">기대평</p>
													<p class="number">
														9.5<span class="ir">점</span>
													</p>
												</div>
												<span class="sign big">pointText</span>
												<div class="review">
													<p class="tit">관람평</p>
													<p class="number after">
														9.7<span class="ir">점</span>
													</p>
												</div>
											</div>
										</a>
									</div>
								</div>
								<div class="tit-area">
									<p class="movie-grade age-12">,</p>
									<p title="킹 오브 프리즘 올 스타즈 -프리즘 쇼☆베스트10-" class="tit">킹 오브
										프리즘 올 스타즈 -프리즘 쇼☆베스트10-</p>
								</div>
								<div class="rate-date">
									<span class="rate">예매율 5.2%</span> <span class="date">개봉일
										2020.04.02</span>
								</div>
								<div class="btn-util">
									<button type="button" class="button btn-like"
										data-no="20004100">
										<i title="보고싶어 안함"
											class="iconset ico-heart-toggle-gray intrstType"></i> <span>266</span>
									</button>
									<p class="txt movieStat1" style="display: none">상영예정</p>
									<p class="txt movieStat2" style="display: none">4월 개봉예정</p>
									<p class="txt movieStat5" style="display: none">개봉예정</p>
									<p class="txt movieStat6" style="display: none">상영종료</p>
									<div class="case col-2 movieStat3" style="display: none">
										<a href="#" class="button purple bokdBtn" data-no="20004100"
											title="영화 예매하기">예매</a> <a href="#"
											class="button purple bokdMxBtn" data-no="20004100"
											title="MX관 예매하기">MX</a>
									</div>
									<div class="case movieStat4" style="">
										<a href="#" class="button purple bokdBtn" data-no="20004100"
											title="영화 예매하기">예매</a>
									</div>
								</div></li>
							<li tabindex="0" class="no-img"><div class="movie-list-info">
									<p class="rank" style="">
										5<span class="ir">위</span>
									</p>
									<img
										src="https://img.megabox.co.kr/SharedImg/2020/03/20/AywldWpz6n6kn8Q0wl9W1a9WTeSj0kpi_420.jpg"
										alt="더 터닝" class="poster lozad" onerror="noImg(this)">
									<div class="curation">
										<p class="film" style="display: none">필름 소사이어티</p>
										<p class="classic" style="display: none">클래식 소사이어티</p>
									</div>
									<div class="screen-type">
										<p class="boutqScreen" style="">부티크</p>
										<p class="mxScreen" style="">MX</p>
									</div>
									<div class="movie-score" style="opacity: 0;">
										<a href="#" class="wrap movieBtn" data-no="20007300"
											title="더 터닝 상세보기">
											<div class="summary">퇴학을 당해 집으로 돌아온 ‘마일스’ 대저택의 밖을 한번도
												나가본 적 없는 ‘플로라’ 대저택의 마지막 주인이 된 두 아이의 새로운 가정교사 ‘케이트’ 대대로 집안을
												보살핀 가정부 ‘그로스’ 부인은 ‘케이트’에게 알 수 없는 말로 아이들을 소개한다. “이 아이들은 특별해요”

												낯선 환경, 기묘한 분위기의 아이들 그리고 발견된 이전 가정교사 ‘제슬’의 일기까지 ‘케이트’는 아이들을
												만난 후부터 매일 밤 악몽에 시달리는데… “나쁜 꿈꿨어요?”</div>
											<div class="my-score smal">
												<div class="preview">
													<p class="tit">기대평</p>
													<p class="number">
														7.9<span class="ir">점</span>
													</p>
												</div>
												<span class="sign smal">pointText</span>
												<div class="review">
													<p class="tit">관람평</p>
													<p class="number after">
														6.3<span class="ir">점</span>
													</p>
												</div>
											</div>
										</a>
									</div>
								</div>
								<div class="tit-area">
									<p class="movie-grade age-15">,</p>
									<p title="더 터닝" class="tit">더 터닝</p>
								</div>
								<div class="rate-date">
									<span class="rate">예매율 5.1%</span> <span class="date">개봉일
										2020.04.02</span>
								</div>
								<div class="btn-util">
									<button type="button" class="button btn-like"
										data-no="20007300">
										<i title="보고싶어 안함"
											class="iconset ico-heart-toggle-gray intrstType"></i> <span>81</span>
									</button>
									<p class="txt movieStat1" style="display: none">상영예정</p>
									<p class="txt movieStat2" style="display: none">4월 개봉예정</p>
									<p class="txt movieStat5" style="display: none">개봉예정</p>
									<p class="txt movieStat6" style="display: none">상영종료</p>
									<div class="case col-2 movieStat3" style="">
										<a href="#" class="button purple bokdBtn" data-no="20007300"
											title="영화 예매하기">예매</a> <a href="#"
											class="button purple bokdMxBtn" data-no="20007300"
											title="MX관 예매하기">MX</a>
									</div>
									<div class="case movieStat4" style="display: none">
										<a href="#" class="button purple bokdBtn" data-no="20007300"
											title="영화 예매하기">예매</a>
									</div>
								</div></li>
							<li tabindex="0" class="no-img"><div class="movie-list-info">
									<p class="rank" style="">
										6<span class="ir">위</span>
									</p>
									<img
										src="https://img.megabox.co.kr/SharedImg/2020/02/18/JR4a3oWNNricpgDfDeGdrZP8bY2DZkLT_420.jpg"
										alt="[오페라] 리골레토" class="poster lozad" onerror="noImg(this)">
									<div class="curation">
										<p class="film" style="display: none">필름 소사이어티</p>
										<p class="classic" style="">클래식 소사이어티</p>
									</div>
									<div class="screen-type">
										<p class="boutqScreen" style="">부티크</p>
										<p class="mxScreen" style="display: none">MX</p>
									</div>
									<div class="movie-score" style="opacity: 0;">
										<a href="#" class="wrap movieBtn" data-no="20000100"
											title="[오페라] 리골레토 상세보기">
											<div class="summary">[상영 정보] - 상영 지점 : 코엑스, 센트럴, 목동,
												킨텍스, 분당, 성수, 남춘천 - 러닝 타임 : 130분 * 인터미션 없음 - 상영 일정 : 2020년 4월
												5일 ~ 5월 27일 / 수 14:00 (코엑스, 킨텍스, 분당, 성수 19:00), 일 14:00 상영 -
												배급사 사정에 따라 상영 일정 및 지점 등이 변경될 수 있습니다. [시놉시스] 궁중 광대 리골레토는 그의
												주인인 공작의 방탕한 생활을 웃음소재로 삼으면서 실제 음탕한 행실을 능동적으로 돕기도 한다. 리골레토는
												알아채지 못하는 사이에 집 안에 꽁꽁 숨겨두었던 자신의 딸 질다를 유괴해 공작에게 데려가는데 가담한다.
												충격을 받은 리골레토는 공작의 이기적인 바람기를 벌하기 위해 암살자를 고용하고 상황은 예상치 못한 방향으로
												전개된다. [작품 소개] 세계 최초의 호상 오페라 축제, 브레겐츠 페스티벌에서 처음 공연된 베르디의
												대표작이다. 환상적인 무대 장치와 아름다운 음악이 매일 다른 얼굴의 호수와 어우러져 독특한 분위기를
												자아낸다. 서커스를 컨셉으로 하는 이번 작품의 연출과 무대 디자인은 필립 슈톨츨이 맡았다. 세계적 팝스타
												‘마돈나’의 뮤직 비디오와 산악 영화 &lt;노스페이스&gt; 등에서 숨이 멎는 듯한 장면을 창조한 영화
												감독이자, 파격적인 연출로 유명한 오페라 감독이다. 호수 위에 얼굴과 손을 내밀고 있는 광대의 모습으로
												꾸며진 무대는 극의 진행에 따라 분위기를 바꾸며 역동적으로 살아 숨쉰다. 테너 코스텔로는 밝고도 명료한
												목소리로 바람둥이 공작의 유명한 칸초네를 불러 감동을 선사했다. 질다 역의 쁘띠는 까다로운 것으로 유명한
												아리아를 상공 45미터 열기구 위에서 완벽하게 소화하며 큰 찬사를 받았다. [작품 정보] 작곡 주세페 베르디
												Giuseppe Verdi 대본 프란체스코 마리아 피아베 Francesco Maria Piave 원작 빅토르
												위고의 희곡 “환락의 왕” Victor Hugo's Le Roi s’amuse (1832) 지휘 엔리케
												마졸라 Enrique Mazzola 무대 연출 및 디자인 필립 슈톨츨 Philipp Stölzl 오케스트라
												빈 교향악단 Vienna Symphony Orchestra 공연 장소 브레겐츠 호상 무대 Bregenz
												Seebühne [출연 정보] 만토바 공작 Duke of Mantua 스테판 코스텔로 Stephen
												Costello 리골레토 Rigoletto 블라드미르 스토야노프 Vladimir Stoyanov 질다
												Gilda 멜리사 쁘띠 Mélissa Petit 스파라푸칠레 Sparafucile 미클로스 세베슈첸
												Miklos Sebestyén 시종 Paggio 김현덕 Hyunduk Kim [주요곡] 질다와 공작의 2중창
												“사랑은 영혼의 태양” 질다의 아리아 “그리운 그 이름” 마달레나, 공작, 질다, 리골레토의 4중창
												“아름다운 아가씨여” 공작의 칸초네 “여자의 마음” 수입/배급 케빈앤컴퍼니</div>
											<div class="my-score smal">
												<div class="preview">
													<p class="tit">기대평</p>
													<p class="number">
														9.6<span class="ir">점</span>
													</p>
												</div>
												<span class="sign smal">pointText</span>
												<div class="review">
													<p class="tit">관람평</p>
													<p class="number after">
														0<span class="ir">점</span>
													</p>
												</div>
											</div>
										</a>
									</div>
								</div>
								<div class="tit-area">
									<p class="movie-grade age-12">,</p>
									<p title="[오페라] 리골레토" class="tit">[오페라] 리골레토</p>
								</div>
								<div class="rate-date">
									<span class="rate">예매율 4.9%</span> <span class="date">개봉일
										2020.04.05</span>
								</div>
								<div class="btn-util">
									<button type="button" class="button btn-like"
										data-no="20000100">
										<i title="보고싶어 안함"
											class="iconset ico-heart-toggle-gray intrstType"></i> <span>196</span>
									</button>
									<p class="txt movieStat1" style="display: none">상영예정</p>
									<p class="txt movieStat2" style="display: none">4월 개봉예정</p>
									<p class="txt movieStat5" style="display: none">개봉예정</p>
									<p class="txt movieStat6" style="display: none">상영종료</p>
									<div class="case col-2 movieStat3" style="display: none">
										<a href="#" class="button purple bokdBtn" data-no="20000100"
											title="영화 예매하기">예매</a> <a href="#"
											class="button purple bokdMxBtn" data-no="20000100"
											title="MX관 예매하기">MX</a>
									</div>
									<div class="case movieStat4" style="">
										<a href="#" class="button purple bokdBtn" data-no="20000100"
											title="영화 예매하기">예매</a>
									</div>
								</div></li>
							<li tabindex="0" class="no-img"><div class="movie-list-info">
									<p class="rank" style="">
										7<span class="ir">위</span>
									</p>
									<img
										src="https://img.megabox.co.kr/SharedImg/2020/03/05/vxKb6uRpY1ThTPxP8TW7jX86tPYdKeTN_420.jpg"
										alt="페임" class="poster lozad" onerror="noImg(this)">
									<div class="curation">
										<p class="film" style="display: none">필름 소사이어티</p>
										<p class="classic" style="display: none">클래식 소사이어티</p>
									</div>
									<div class="screen-type">
										<p class="boutqScreen" style="">부티크</p>
										<p class="mxScreen" style="display: none">MX</p>
									</div>
									<div class="movie-score" style="opacity: 0;">
										<a href="#" class="wrap movieBtn" data-no="20006000"
											title="페임 상세보기">
											<div class="summary">모두가 꿈꾸지만 누구나 가질 수 없는, FAME! 빛나는
												재능으로 찬란한 미래를 꿈꾸는 뉴욕 46번가, PA 예술고등학교 젊음의 열정이 폭발하는 그곳에서 우리의
												무대, 그리고 사랑이 시작된다!</div>
											<div class="my-score smal">
												<div class="preview">
													<p class="tit">기대평</p>
													<p class="number">
														9<span class="ir">점</span>
													</p>
												</div>
												<span class="sign smal">pointText</span>
												<div class="review">
													<p class="tit">관람평</p>
													<p class="number after">
														8.4<span class="ir">점</span>
													</p>
												</div>
											</div>
										</a>
									</div>
								</div>
								<div class="tit-area">
									<p class="movie-grade age-12">,</p>
									<p title="페임" class="tit">페임</p>
								</div>
								<div class="rate-date">
									<span class="rate">예매율 4.3%</span> <span class="date">개봉일
										2020.03.25</span>
								</div>
								<div class="btn-util">
									<button type="button" class="button btn-like"
										data-no="20006000">
										<i title="보고싶어 안함"
											class="iconset ico-heart-toggle-gray intrstType"></i> <span>138</span>
									</button>
									<p class="txt movieStat1" style="display: none">상영예정</p>
									<p class="txt movieStat2" style="display: none">3월 개봉예정</p>
									<p class="txt movieStat5" style="display: none">개봉예정</p>
									<p class="txt movieStat6" style="display: none">상영종료</p>
									<div class="case col-2 movieStat3" style="display: none">
										<a href="#" class="button purple bokdBtn" data-no="20006000"
											title="영화 예매하기">예매</a> <a href="#"
											class="button purple bokdMxBtn" data-no="20006000"
											title="MX관 예매하기">MX</a>
									</div>
									<div class="case movieStat4" style="">
										<a href="#" class="button purple bokdBtn" data-no="20006000"
											title="영화 예매하기">예매</a>
									</div>
								</div></li>
							<li tabindex="0" class="no-img"><div class="movie-list-info">
									<p class="rank" style="">
										8<span class="ir">위</span>
									</p>
									<img
										src="https://img.megabox.co.kr/SharedImg/2020/02/07/jO2LnVNFJxLzAL62WxHjDUBKbtPcV8ET_420.jpg"
										alt="시원찮은 그녀를 위한 육성방법 피날레" class="poster lozad"
										onerror="noImg(this)">
									<div class="curation">
										<p class="film" style="display: none">필름 소사이어티</p>
										<p class="classic" style="display: none">클래식 소사이어티</p>
									</div>
									<div class="screen-type">
										<p class="boutqScreen" style="display: none">부티크</p>
										<p class="mxScreen" style="display: none">MX</p>
									</div>
									<div class="movie-score">
										<a href="#" class="wrap movieBtn" data-no="20000400"
											title="시원찮은 그녀를 위한 육성방법 피날레 상세보기">
											<div class="summary">어느 봄날, 아키 토모야는 벚꽃이 흩날리는 언덕길에서
												운명적으로 만난 소녀 '카토 메구미'를 메인 히로인으로 삼아서 동인 게임을 제작하기로 마음을 먹는다. 미술부
												소속이지만 동인 일러스트레이터로도 활동 중인 ‘사와무라 스펜서 에리리’, 우등생이면서 라이트노벨 작가로도
												활약하고 있는 3학년 선배 ‘카스미가오카 우타하’를 영입한 그는, 게임 제작 동아리 ‘블레싱 소프트웨어’를
												결성해서 시행착오 끝에 첫 작품을 발표한다ㅡ. 에리리와 우타하는 인기 크리에이터 코사카 아카네가 기획을 맡은
												대작 게임 [필즈 크로니클]의 개발 멤버로 스카우트된다. 한편 블레싱 소프트웨어 대표인 토모야는 서클 활동을
												이어 나가면서 일러스트레이터인 하시마 이즈미, 프로듀서인 하시마 이오리, 음악 밴드 아이시 테일의 효도
												미치루, 그리고 부대표 메구미와 함께 신작 게임의 개발을 시작하는데…</div>
											<div class="my-score big">
												<div class="preview">
													<p class="tit">기대평</p>
													<p class="number">
														8.7<span class="ir">점</span>
													</p>
												</div>
												<span class="sign big">pointText</span>
												<div class="review">
													<p class="tit">관람평</p>
													<p class="number after">
														9.4<span class="ir">점</span>
													</p>
												</div>
											</div>
										</a>
									</div>
								</div>
								<div class="tit-area">
									<p class="movie-grade age-12">,</p>
									<p title="시원찮은 그녀를 위한 육성방법 피날레" class="tit">시원찮은 그녀를 위한
										육성방법 피날레</p>
								</div>
								<div class="rate-date">
									<span class="rate">예매율 4%</span> <span class="date">개봉일
										2020.02.27</span>
								</div>
								<div class="btn-util">
									<button type="button" class="button btn-like"
										data-no="20000400">
										<i title="보고싶어 안함"
											class="iconset ico-heart-toggle-gray intrstType"></i> <span>584</span>
									</button>
									<p class="txt movieStat1" style="display: none">상영예정</p>
									<p class="txt movieStat2" style="display: none">2월 개봉예정</p>
									<p class="txt movieStat5" style="display: none">개봉예정</p>
									<p class="txt movieStat6" style="display: none">상영종료</p>
									<div class="case col-2 movieStat3" style="display: none">
										<a href="#" class="button purple bokdBtn" data-no="20000400"
											title="영화 예매하기">예매</a> <a href="#"
											class="button purple bokdMxBtn" data-no="20000400"
											title="MX관 예매하기">MX</a>
									</div>
									<div class="case movieStat4" style="">
										<a href="#" class="button purple bokdBtn" data-no="20000400"
											title="영화 예매하기">예매</a>
									</div>
								</div></li>
							<li tabindex="0" class="no-img"><div class="movie-list-info">
									<p class="rank" style="">
										9<span class="ir">위</span>
									</p>
									<img
										src="https://img.megabox.co.kr/SharedImg/2020/03/03/75uijLWJo1DGxC7zFNo0rZix01dXa3Ea_420.jpg"
										alt="바이올렛 에버가든 - 영원과 자동 수기 인형 -" class="poster lozad"
										onerror="noImg(this)">
									<div class="curation">
										<p class="film" style="display: none">필름 소사이어티</p>
										<p class="classic" style="display: none">클래식 소사이어티</p>
									</div>
									<div class="screen-type">
										<p class="boutqScreen" style="display: none">부티크</p>
										<p class="mxScreen" style="display: none">MX</p>
									</div>
									<div class="movie-score">
										<a href="#" class="wrap movieBtn" data-no="20006800"
											title="바이올렛 에버가든 - 영원과 자동 수기 인형 - 상세보기">
											<div class="summary">“전하고 싶어, 나의 마음을” 소중한 동생을 지키는 대가로
												요크 가문에 입성한 ‘이자벨라’. 더 이상 꿈도 희망도 없는 그녀의 앞에 나타난 자동 수기 인형, ‘바이올렛
												에버가든’. “나도… 행복을 전하고 싶어” 언니의 편지를 받고 C.H 우편사를 찾아온 ‘테일러’는 사람들에게
												행복을 전하는 우편배달 일을 시작하고, ‘이자벨라’에게도 자신의 마음을 전하기 위해 ‘바이올렛’에게 대필을
												부탁하는데… 무수히 늘어놓은 아름다운 말보다, 단 한마디로도 소중한 마음을 전할 수 있다 - 바이올렛
												에버가든</div>
											<div class="my-score smal">
												<div class="preview">
													<p class="tit">기대평</p>
													<p class="number">
														9.7<span class="ir">점</span>
													</p>
												</div>
												<span class="sign smal">pointText</span>
												<div class="review">
													<p class="tit">관람평</p>
													<p class="number after">
														9.3<span class="ir">점</span>
													</p>
												</div>
											</div>
										</a>
									</div>
								</div>
								<div class="tit-area">
									<p class="movie-grade age-all">,</p>
									<p title="바이올렛 에버가든 - 영원과 자동 수기 인형 -" class="tit">바이올렛 에버가든
										- 영원과 자동 수기 인형 -</p>
								</div>
								<div class="rate-date">
									<span class="rate">예매율 3.6%</span> <span class="date">개봉일
										2020.03.26</span>
								</div>
								<div class="btn-util">
									<button type="button" class="button btn-like"
										data-no="20006800">
										<i title="보고싶어 안함"
											class="iconset ico-heart-toggle-gray intrstType"></i> <span>745</span>
									</button>
									<p class="txt movieStat1" style="display: none">상영예정</p>
									<p class="txt movieStat2" style="display: none">3월 개봉예정</p>
									<p class="txt movieStat5" style="display: none">개봉예정</p>
									<p class="txt movieStat6" style="display: none">상영종료</p>
									<div class="case col-2 movieStat3" style="display: none">
										<a href="#" class="button purple bokdBtn" data-no="20006800"
											title="영화 예매하기">예매</a> <a href="#"
											class="button purple bokdMxBtn" data-no="20006800"
											title="MX관 예매하기">MX</a>
									</div>
									<div class="case movieStat4" style="">
										<a href="#" class="button purple bokdBtn" data-no="20006800"
											title="영화 예매하기">예매</a>
									</div>
								</div></li>
							<li tabindex="0" class="no-img"><div class="movie-list-info">
									<p class="rank" style="">
										10<span class="ir">위</span>
									</p>
									<img
										src="https://img.megabox.co.kr/SharedImg/2020/03/23/c6SWPeJVvbYs0nFSYZlla2vyrrFDPaF0_420.jpg"
										alt="[다시봄] 극장판 쿠로코의 농구 라스트 게임" class="poster lozad"
										onerror="noImg(this)">
									<div class="curation">
										<p class="film" style="display: none">필름 소사이어티</p>
										<p class="classic" style="display: none">클래식 소사이어티</p>
									</div>
									<div class="screen-type">
										<p class="boutqScreen" style="display: none">부티크</p>
										<p class="mxScreen" style="display: none">MX</p>
									</div>
									<div class="movie-score">
										<a href="#" class="wrap movieBtn" data-no="20009600"
											title="[다시봄] 극장판 쿠로코의 농구 라스트 게임 상세보기">
											<div class="summary">기적의 드림팀! 가장 흉한한 미국팀! 지금 맞이하는 운명의
												LAST TIPOFF!! 윈터컵에서 세이린 고등학교가 전국을 제패하고 몇 개월 뒤. 2학년이 된 쿠로코의
												여름이 끝나갈 즈음, 미국에서 길거리 농구팀 ‘Jabberwock’가 방일한다. 그들은 친선 시합에서 차원이
												다른 실력을 보여줌과 동시에 일본 플레이어들을 무시하며 비웃는 모습으로 관객들의 공분을 산다. 이번 일본
												방문 이벤트 관계자였던 아이다 카케토라는 그 태도에 격노해 리벤지 매치를 선언하고, ‘Jabberwock’에
												대항할 수 있는 최강의 멤버로 쿠로코와 카가미, 그리고 ‘기적의 세대’를 모아 단 한경기만을 위한 드림팀
												‘VORPAL SWORDS’를 결성한다!</div>
											<div class="my-score equa">
												<div class="preview">
													<p class="tit">기대평</p>
													<p class="number">
														0<span class="ir">점</span>
													</p>
												</div>
												<span class="sign equa">pointText</span>
												<div class="review">
													<p class="tit">관람평</p>
													<p class="number after">
														0<span class="ir">점</span>
													</p>
												</div>
											</div>
										</a>
									</div>
								</div>
								<div class="tit-area">
									<p class="movie-grade age-12">,</p>
									<p title="[다시봄] 극장판 쿠로코의 농구 라스트 게임" class="tit">[다시봄] 극장판
										쿠로코의 농구 라스트 게임</p>
								</div>
								<div class="rate-date">
									<span class="rate">예매율 3.3%</span> <span class="date">개봉일
										2020.04.09</span>
								</div>
								<div class="btn-util">
									<button type="button" class="button btn-like"
										data-no="20009600">
										<i title="보고싶어 안함"
											class="iconset ico-heart-toggle-gray intrstType"></i> <span>17</span>
									</button>
									<p class="txt movieStat1" style="display: none">상영예정</p>
									<p class="txt movieStat2" style="display: none">4월 개봉예정</p>
									<p class="txt movieStat5" style="display: none">개봉예정</p>
									<p class="txt movieStat6" style="display: none">상영종료</p>
									<div class="case col-2 movieStat3" style="display: none">
										<a href="#" class="button purple bokdBtn" data-no="20009600"
											title="영화 예매하기">예매</a> <a href="#"
											class="button purple bokdMxBtn" data-no="20009600"
											title="MX관 예매하기">MX</a>
									</div>
									<div class="case movieStat4" style="">
										<a href="#" class="button purple bokdBtn" data-no="20009600"
											title="영화 예매하기">예매</a>
									</div>
								</div></li>
							<li tabindex="0" class="no-img"><div class="movie-list-info">
									<p class="rank" style="">
										11<span class="ir">위</span>
									</p>
									<img
										src="https://img.megabox.co.kr/SharedImg/asis/system/mop/poster/2020/73/C2E59B-7D34-4220-8D51-580299453B88.large.jpg"
										alt="작은 아씨들" class="poster lozad" onerror="noImg(this)">
									<div class="curation">
										<p class="film" style="display: none">필름 소사이어티</p>
										<p class="classic" style="display: none">클래식 소사이어티</p>
									</div>
									<div class="screen-type">
										<p class="boutqScreen" style="">부티크</p>
										<p class="mxScreen" style="display: none">MX</p>
									</div>
									<div class="movie-score">
										<a href="#" class="wrap movieBtn" data-no="01680400"
											title="작은 아씨들 상세보기">
											<div class="summary">Dear women 그해 겨울, 사랑스러운 자매들을 만났다

												배우가 되고 싶은 첫째 메그(엠마 왓슨) 작가가 되고 싶은 둘째 조(시얼샤 로넌) 음악가가 되고 싶은 셋째
												베스(엘리자 스켈런) 화가가 되고 싶은 막내 에이미(플로렌스 퓨) 이웃집 소년 로리(티모시 샬라메)는 네
												자매를 우연히 알게되고 각기 다른 개성의 네 자매들과 인연을 쌓아간다. 7년 후, 어른이 된 그들에겐 각기
												다른 숙제가 놓이게 되는데…</div>
											<div class="my-score big">
												<div class="preview">
													<p class="tit">기대평</p>
													<p class="number">
														8.7<span class="ir">점</span>
													</p>
												</div>
												<span class="sign big">pointText</span>
												<div class="review">
													<p class="tit">관람평</p>
													<p class="number after">
														9.1<span class="ir">점</span>
													</p>
												</div>
											</div>
										</a>
									</div>
								</div>
								<div class="tit-area">
									<p class="movie-grade age-all">,</p>
									<p title="작은 아씨들" class="tit">작은 아씨들</p>
								</div>
								<div class="rate-date">
									<span class="rate">예매율 3%</span> <span class="date">개봉일
										2020.02.12</span>
								</div>
								<div class="btn-util">
									<button type="button" class="button btn-like"
										data-no="01680400">
										<i title="보고싶어 안함"
											class="iconset ico-heart-toggle-gray intrstType"></i> <span>2.6k</span>
									</button>
									<p class="txt movieStat1" style="display: none">상영예정</p>
									<p class="txt movieStat2" style="display: none">2월 개봉예정</p>
									<p class="txt movieStat5" style="display: none">개봉예정</p>
									<p class="txt movieStat6" style="display: none">상영종료</p>
									<div class="case col-2 movieStat3" style="display: none">
										<a href="#" class="button purple bokdBtn" data-no="01680400"
											title="영화 예매하기">예매</a> <a href="#"
											class="button purple bokdMxBtn" data-no="01680400"
											title="MX관 예매하기">MX</a>
									</div>
									<div class="case movieStat4" style="">
										<a href="#" class="button purple bokdBtn" data-no="01680400"
											title="영화 예매하기">예매</a>
									</div>
								</div></li>
							<li tabindex="0" class="no-img"><div class="movie-list-info">
									<p class="rank" style="">
										12<span class="ir">위</span>
									</p>
									<img
										src="https://img.megabox.co.kr/SharedImg/2020/02/25/cH7qHYtiXhvrIwZVNraUkjfGPPUj4M5W_420.jpg"
										alt="인비저블맨" class="poster lozad" onerror="noImg(this)">
									<div class="curation">
										<p class="film" style="display: none">필름 소사이어티</p>
										<p class="classic" style="display: none">클래식 소사이어티</p>
									</div>
									<div class="screen-type">
										<p class="boutqScreen" style="">부티크</p>
										<p class="mxScreen" style="display: none">MX</p>
									</div>
									<div class="movie-score">
										<a href="#" class="wrap movieBtn" data-no="01694800"
											title="인비저블맨 상세보기">
											<div class="summary">모든 것을 통제하려는 소시오패스 남자에게서 도망친 세실리아
												그의 자살 소식과 함께 상속받게 된 거액의 유산 하지만 그날 이후, 누구에게도 보이지 않는 존재가 느껴지기
												시작했다!</div>
											<div class="my-score big">
												<div class="preview">
													<p class="tit">기대평</p>
													<p class="number">
														7.5<span class="ir">점</span>
													</p>
												</div>
												<span class="sign big">pointText</span>
												<div class="review">
													<p class="tit">관람평</p>
													<p class="number after">
														8.2<span class="ir">점</span>
													</p>
												</div>
											</div>
										</a>
									</div>
								</div>
								<div class="tit-area">
									<p class="movie-grade age-15">,</p>
									<p title="인비저블맨" class="tit">인비저블맨</p>
								</div>
								<div class="rate-date">
									<span class="rate">예매율 2.6%</span> <span class="date">개봉일
										2020.02.26</span>
								</div>
								<div class="btn-util">
									<button type="button" class="button btn-like"
										data-no="01694800">
										<i title="보고싶어 안함"
											class="iconset ico-heart-toggle-gray intrstType"></i> <span>413</span>
									</button>
									<p class="txt movieStat1" style="display: none">상영예정</p>
									<p class="txt movieStat2" style="display: none">2월 개봉예정</p>
									<p class="txt movieStat5" style="display: none">개봉예정</p>
									<p class="txt movieStat6" style="display: none">상영종료</p>
									<div class="case col-2 movieStat3" style="display: none">
										<a href="#" class="button purple bokdBtn" data-no="01694800"
											title="영화 예매하기">예매</a> <a href="#"
											class="button purple bokdMxBtn" data-no="01694800"
											title="MX관 예매하기">MX</a>
									</div>
									<div class="case movieStat4" style="">
										<a href="#" class="button purple bokdBtn" data-no="01694800"
											title="영화 예매하기">예매</a>
									</div>
								</div></li>
							<li tabindex="0" class="no-img"><div class="movie-list-info">
									<p class="rank" style="">
										13<span class="ir">위</span>
									</p>
									<img
										src="https://img.megabox.co.kr/SharedImg/2020/03/23/2iWTg4xekHPPcqcpNyD6EmhJia0TiCp5_420.jpg"
										alt="[다시봄] 뱅드림! 필름 라이브" class="poster lozad"
										onerror="noImg(this)">
									<div class="curation">
										<p class="film" style="display: none">필름 소사이어티</p>
										<p class="classic" style="display: none">클래식 소사이어티</p>
									</div>
									<div class="screen-type">
										<p class="boutqScreen" style="display: none">부티크</p>
										<p class="mxScreen" style="display: none">MX</p>
									</div>
									<div class="movie-score">
										<a href="#" class="wrap movieBtn" data-no="20010200"
											title="[다시봄] 뱅드림! 필름 라이브 상세보기">
											<div class="summary">하나사키가와 여자 고등학교에서 결성된 걸즈 밴드
												Poppin'Party 소꿉친구 다섯 명이 연주하는 전형적인 걸즈 록 밴드 Afterglow 연예 기획사의
												의향으로 탄생한 아이돌 밴드 Pastel*Palettes 중후한 세계관으로 매료시키는 본격파 밴드
												Roselia 온 세상을 웃게 하기 위해 행복 가득한 멜로디를 전하는 헬로, 해피 월드! 다섯 밴드가 꿈꾸는
												다음 무대는...</div>
											<div class="my-score smal">
												<div class="preview">
													<p class="tit">기대평</p>
													<p class="number">
														9.9<span class="ir">점</span>
													</p>
												</div>
												<span class="sign smal">pointText</span>
												<div class="review">
													<p class="tit">관람평</p>
													<p class="number after">
														0<span class="ir">점</span>
													</p>
												</div>
											</div>
										</a>
									</div>
								</div>
								<div class="tit-area">
									<p class="movie-grade age-all">,</p>
									<p title="[다시봄] 뱅드림! 필름 라이브" class="tit">[다시봄] 뱅드림! 필름 라이브</p>
								</div>
								<div class="rate-date">
									<span class="rate">예매율 2.4%</span> <span class="date">개봉일
										2020.04.09</span>
								</div>
								<div class="btn-util">
									<button type="button" class="button btn-like"
										data-no="20010200">
										<i title="보고싶어 안함"
											class="iconset ico-heart-toggle-gray intrstType"></i> <span>19</span>
									</button>
									<p class="txt movieStat1" style="display: none">상영예정</p>
									<p class="txt movieStat2" style="display: none">4월 개봉예정</p>
									<p class="txt movieStat5" style="display: none">개봉예정</p>
									<p class="txt movieStat6" style="display: none">상영종료</p>
									<div class="case col-2 movieStat3" style="display: none">
										<a href="#" class="button purple bokdBtn" data-no="20010200"
											title="영화 예매하기">예매</a> <a href="#"
											class="button purple bokdMxBtn" data-no="20010200"
											title="MX관 예매하기">MX</a>
									</div>
									<div class="case movieStat4" style="">
										<a href="#" class="button purple bokdBtn" data-no="20010200"
											title="영화 예매하기">예매</a>
									</div>
								</div></li>
							<li tabindex="0" class="no-img"><div class="movie-list-info">
									<p class="rank" style="">
										14<span class="ir">위</span>
									</p>
									<img
										src="https://img.megabox.co.kr/SharedImg/asis/system/mop/poster/2018/4B/CA991F-43A4-4DB7-BC16-AF9F17A072A1.large.jpg"
										alt="[다시봄] 러브 라이브! 더 스쿨 아이돌 무비" class="poster lozad"
										onerror="noImg(this)">
									<div class="curation">
										<p class="film" style="display: none">필름 소사이어티</p>
										<p class="classic" style="display: none">클래식 소사이어티</p>
									</div>
									<div class="screen-type">
										<p class="boutqScreen" style="display: none">부티크</p>
										<p class="mxScreen" style="display: none">MX</p>
									</div>
									<div class="movie-score">
										<a href="#" class="wrap movieBtn" data-no="01367700"
											title="[다시봄] 러브 라이브! 더 스쿨 아이돌 무비 상세보기">
											<div class="summary">[애니플러스 다시, 봄] 기획전 특별상영 학교에서 아이돌!!
												아홉 명의 소녀들이 만드는 청춘 학원 드라마 졸업식 직후, 뮤즈에게 어떤 소식이 날아들었다. 3학년의 졸업을
												계기로 활동을 끝내기로 결정한 뮤즈였지만, 그 소식을 듣고 새로운 라이브 공연을 준비한다. 처음 보는 세상을
												접하고 다시 조금씩 성장해 나가는 아홉 사람. 이들은 스쿨 아이돌로서 마지막으로 무엇을 할 수 있을까? 얼마
												남지 않은 시간 속에서 뮤즈가 발견한, 최고로 즐거운 라이브란 무엇일까?</div>
											<div class="my-score equa">
												<div class="preview">
													<p class="tit">기대평</p>
													<p class="number">
														0<span class="ir">점</span>
													</p>
												</div>
												<span class="sign equa">pointText</span>
												<div class="review">
													<p class="tit">관람평</p>
													<p class="number after">
														0<span class="ir">점</span>
													</p>
												</div>
											</div>
										</a>
									</div>
								</div>
								<div class="tit-area">
									<p class="movie-grade age-all">,</p>
									<p title="[다시봄] 러브 라이브! 더 스쿨 아이돌 무비" class="tit">[다시봄] 러브
										라이브! 더 스쿨 아이돌 무비</p>
								</div>
								<div class="rate-date">
									<span class="rate">예매율 2.4%</span> <span class="date">개봉일
										2020.04.09</span>
								</div>
								<div class="btn-util">
									<button type="button" class="button btn-like"
										data-no="01367700">
										<i title="보고싶어 안함"
											class="iconset ico-heart-toggle-gray intrstType"></i> <span>47</span>
									</button>
									<p class="txt movieStat1" style="display: none">상영예정</p>
									<p class="txt movieStat2" style="display: none">4월 개봉예정</p>
									<p class="txt movieStat5" style="display: none">개봉예정</p>
									<p class="txt movieStat6" style="display: none">상영종료</p>
									<div class="case col-2 movieStat3" style="display: none">
										<a href="#" class="button purple bokdBtn" data-no="01367700"
											title="영화 예매하기">예매</a> <a href="#"
											class="button purple bokdMxBtn" data-no="01367700"
											title="MX관 예매하기">MX</a>
									</div>
									<div class="case movieStat4" style="">
										<a href="#" class="button purple bokdBtn" data-no="01367700"
											title="영화 예매하기">예매</a>
									</div>
								</div></li>
							<li tabindex="0" class="no-img"><div class="movie-list-info">
									<p class="rank" style="">
										15<span class="ir">위</span>
									</p>
									<img
										src="https://img.megabox.co.kr/SharedImg/2020/02/21/lczdtI1vz3Dd1ShuXb0iXj8pTJGbh4wa_420.jpg"
										alt="다크 워터스" class="poster lozad" onerror="noImg(this)">
									<div class="curation">
										<p class="film" style="display: none">필름 소사이어티</p>
										<p class="classic" style="display: none">클래식 소사이어티</p>
									</div>
									<div class="screen-type">
										<p class="boutqScreen" style="">부티크</p>
										<p class="mxScreen" style="display: none">MX</p>
									</div>
									<div class="movie-score">
										<a href="#" class="wrap movieBtn" data-no="20003000"
											title="다크 워터스 상세보기">
											<div class="summary">인류의 99%는 이미 중독되었다 &lt;스포트라이트&gt;
												제작진의 충격 고발 실화 젖소 190마리의 떼죽음 메스꺼움과 고열에 시달리는 사람들 기형아들의 출생 그리고,
												한 마을에 퍼지기 시작한 중증 질병들... 대기업의 변호를 담당하는 대형 로펌의 변호사 ‘롭 빌럿’(마크
												러팔로)은 세계 최대의 화학기업 듀폰의 독성 폐기물질(PFOA) 유출 사실을 폭로한다. 그는 사건을
												파헤칠수록 독성 물질이 프라이팬부터 콘택트렌즈, 아기 매트까지 우리 일상 속에 침투해 있다는 끔찍한 사실을
												알게 되고 자신의 커리어는 물론 아내 ‘사라’(앤 해서웨이)와 가족들, 모든 것을 건 용기 있는 싸움을
												시작한다. 대한민국에서도 일어나고 있는 현재진행형 실화가 공개된다</div>
											<div class="my-score smal">
												<div class="preview">
													<p class="tit">기대평</p>
													<p class="number">
														9.3<span class="ir">점</span>
													</p>
												</div>
												<span class="sign smal">pointText</span>
												<div class="review">
													<p class="tit">관람평</p>
													<p class="number after">
														8.6<span class="ir">점</span>
													</p>
												</div>
											</div>
										</a>
									</div>
								</div>
								<div class="tit-area">
									<p class="movie-grade age-12">,</p>
									<p title="다크 워터스" class="tit">다크 워터스</p>
								</div>
								<div class="rate-date">
									<span class="rate">예매율 2%</span> <span class="date">개봉일
										2020.03.11</span>
								</div>
								<div class="btn-util">
									<button type="button" class="button btn-like"
										data-no="20003000">
										<i title="보고싶어 안함"
											class="iconset ico-heart-toggle-gray intrstType"></i> <span>380</span>
									</button>
									<p class="txt movieStat1" style="display: none">상영예정</p>
									<p class="txt movieStat2" style="display: none">3월 개봉예정</p>
									<p class="txt movieStat5" style="display: none">개봉예정</p>
									<p class="txt movieStat6" style="display: none">상영종료</p>
									<div class="case col-2 movieStat3" style="display: none">
										<a href="#" class="button purple bokdBtn" data-no="20003000"
											title="영화 예매하기">예매</a> <a href="#"
											class="button purple bokdMxBtn" data-no="20003000"
											title="MX관 예매하기">MX</a>
									</div>
									<div class="case movieStat4" style="">
										<a href="#" class="button purple bokdBtn" data-no="20003000"
											title="영화 예매하기">예매</a>
									</div>
								</div></li>
							<li tabindex="0" class="no-img"><div class="movie-list-info">
									<p class="rank" style="">
										16<span class="ir">위</span>
									</p>
									<img
										src="https://img.megabox.co.kr/SharedImg/2020/03/23/5s8XhAk9MeYMgTjP03e0tk0dv97rDRKD_420.jpg"
										alt="[다시봄] 러브라이브! 선샤인!! 더 스쿨 아이돌 무비 오버 더 레인보우"
										class="poster lozad" onerror="noImg(this)">
									<div class="curation">
										<p class="film" style="display: none">필름 소사이어티</p>
										<p class="classic" style="display: none">클래식 소사이어티</p>
									</div>
									<div class="screen-type">
										<p class="boutqScreen" style="display: none">부티크</p>
										<p class="mxScreen" style="display: none">MX</p>
									</div>
									<div class="movie-score">
										<a href="#" class="wrap movieBtn" data-no="20010100"
											title="[다시봄] 러브라이브! 선샤인!! 더 스쿨 아이돌 무비 오버 더 레인보우 상세보기">
											<div class="summary">우라노호시 여고의 스쿨 아이돌로서 참가하는 마지막
												'러브라이브!'에서 멋지게 우승을 따낸 Aqours. 새로운 학교로 편입할 준비를 하던 1, 2학년들에게
												예상 밖의 트러블이 연발한다? 게다가 졸업여행을 떠난 3학년들이 행방불명?! 멀리 떨어진 후에야 처음으로
												깨달은 서로의 빈 자리. 새로운 한 걸음을 내딛기 위해, Aqours가 도달한 결론은 무엇일까? 함께 달려온
												빛나는 오늘을 넘어서 미래로 날아가려는 모든 사람들에게 바치는, 최고의 라이브 엔터테인먼트 무비!</div>
											<div class="my-score equa">
												<div class="preview">
													<p class="tit">기대평</p>
													<p class="number">
														0<span class="ir">점</span>
													</p>
												</div>
												<span class="sign equa">pointText</span>
												<div class="review">
													<p class="tit">관람평</p>
													<p class="number after">
														0<span class="ir">점</span>
													</p>
												</div>
											</div>
										</a>
									</div>
								</div>
								<div class="tit-area">
									<p class="movie-grade age-all">,</p>
									<p title="[다시봄] 러브라이브! 선샤인!! 더 스쿨 아이돌 무비 오버 더 레인보우" class="tit">[다시봄]
										러브라이브! 선샤인!! 더 스쿨 아이돌 무비 오버 더 레인보우</p>
								</div>
								<div class="rate-date">
									<span class="rate">예매율 1.9%</span> <span class="date">개봉일
										2020.04.09</span>
								</div>
								<div class="btn-util">
									<button type="button" class="button btn-like"
										data-no="20010100">
										<i title="보고싶어 안함"
											class="iconset ico-heart-toggle-gray intrstType"></i> <span>11</span>
									</button>
									<p class="txt movieStat1" style="display: none">상영예정</p>
									<p class="txt movieStat2" style="display: none">4월 개봉예정</p>
									<p class="txt movieStat5" style="display: none">개봉예정</p>
									<p class="txt movieStat6" style="display: none">상영종료</p>
									<div class="case col-2 movieStat3" style="display: none">
										<a href="#" class="button purple bokdBtn" data-no="20010100"
											title="영화 예매하기">예매</a> <a href="#"
											class="button purple bokdMxBtn" data-no="20010100"
											title="MX관 예매하기">MX</a>
									</div>
									<div class="case movieStat4" style="">
										<a href="#" class="button purple bokdBtn" data-no="20010100"
											title="영화 예매하기">예매</a>
									</div>
								</div></li>
							<li tabindex="0" class="no-img"><div class="movie-list-info">
									<p class="rank" style="">
										17<span class="ir">위</span>
									</p>
									<img
										src="https://img.megabox.co.kr/SharedImg/2020/03/12/yZRChDE2ZGDqoLxVrhPf9J21CgwUAGhr_420.jpg"
										alt="[오페라] 마농 @ The Met" class="poster lozad"
										onerror="noImg(this)">
									<div class="curation">
										<p class="film" style="display: none">필름 소사이어티</p>
										<p class="classic" style="">클래식 소사이어티</p>
									</div>
									<div class="screen-type">
										<p class="boutqScreen" style="">부티크</p>
										<p class="mxScreen" style="display: none">MX</p>
									</div>
									<div class="movie-score">
										<a href="#" class="wrap movieBtn" data-no="20007900"
											title="[오페라] 마농 @ The Met 상세보기">
											<div class="summary">[시놉시스] 순진한 시골 처녀에서 화려한 코티잔 (상류사회
												남성 들에게 향락을 제공하는 여성)으로, 그리고 추방당하는 죄수로 삶이 급변하는 마농의 스토리는 문학과
												오페라 분야에서 가장 인상적인 비극의 하나다. [작품소개] 소프라노 리제트 오로페사가 거부할 수 없는 매력을
												지닌 마농 역을 노래한다. 삶에서 섬세하고 아름다운 것들을 추구하다 파멸하는 비극적인 미인의 초상을 로렝
												펠리는 대담한 연출로 그려냈다. 테너 마이클 파비아노는 열정에서 벗어나지 못하는 백작의 아들 데 그리외역을
												맡았다. 마농을 향한 그의 절절한 사랑은 결국 그들 두 사람을 파멸로 이끈다. 마우리치오 베니니가 마스네의
												이 관능적인 음악을 지휘했다. [상영 정보] - 상영 일정 : 2020년 3월 31일 ~ 4월 25일 / 화
												14:00 (코엑스, 분당, 킨텍스, 성수 19:00), 토 14:00 상영 - 상영 지점 : 코엑스,
												센트럴, 목동, 분당, 킨텍스, 성수 - 러닝 타임 : 220분 *인터미션 있음 - 배급사 사정에 따라 상영
												일정 및 지점 등이 변경될 수 있습니다.</div>
											<div class="my-score equa">
												<div class="preview">
													<p class="tit">기대평</p>
													<p class="number">
														0<span class="ir">점</span>
													</p>
												</div>
												<span class="sign equa">pointText</span>
												<div class="review">
													<p class="tit">관람평</p>
													<p class="number after">
														0<span class="ir">점</span>
													</p>
												</div>
											</div>
										</a>
									</div>
								</div>
								<div class="tit-area">
									<p class="movie-grade age-12">,</p>
									<p title="[오페라] 마농 @ The Met" class="tit">[오페라] 마농 @ The
										Met</p>
								</div>
								<div class="rate-date">
									<span class="rate">예매율 1.5%</span> <span class="date">개봉일
										2020.03.31</span>
								</div>
								<div class="btn-util">
									<button type="button" class="button btn-like"
										data-no="20007900">
										<i title="보고싶어 안함"
											class="iconset ico-heart-toggle-gray intrstType"></i> <span>30</span>
									</button>
									<p class="txt movieStat1" style="display: none">상영예정</p>
									<p class="txt movieStat2" style="display: none">3월 개봉예정</p>
									<p class="txt movieStat5" style="display: none">개봉예정</p>
									<p class="txt movieStat6" style="display: none">상영종료</p>
									<div class="case col-2 movieStat3" style="display: none">
										<a href="#" class="button purple bokdBtn" data-no="20007900"
											title="영화 예매하기">예매</a> <a href="#"
											class="button purple bokdMxBtn" data-no="20007900"
											title="MX관 예매하기">MX</a>
									</div>
									<div class="case movieStat4" style="">
										<a href="#" class="button purple bokdBtn" data-no="20007900"
											title="영화 예매하기">예매</a>
									</div>
								</div></li>
							<li tabindex="0" class="no-img"><div class="movie-list-info">
									<p class="rank" style="">
										18<span class="ir">위</span>
									</p>
									<img
										src="https://img.megabox.co.kr/SharedImg/2020/03/31/qCTcZaYSLaZMOwN0W7QjVwEQRBBnA90y_420.jpg"
										alt="패왕별희 디 오리지널" class="poster lozad" onerror="noImg(this)">
									<div class="curation">
										<p class="film" style="">필름 소사이어티</p>
										<p class="classic" style="display: none">클래식 소사이어티</p>
									</div>
									<div class="screen-type">
										<p class="boutqScreen" style="display: none">부티크</p>
										<p class="mxScreen" style="display: none">MX</p>
									</div>
									<div class="movie-score">
										<a href="#" class="wrap movieBtn" data-no="20004800"
											title="패왕별희 디 오리지널 상세보기">
											<div class="summary">어렸을 때부터 함께 경극을 해온 ‘두지’(장국영)와
												‘시투’(장풍의). 세상에 둘도 없는 절친한 아우와 형이지만, ‘두지’는 남몰래 ‘시투’에 대한 마음을 품고
												있다. 하지만 ‘시투’는 여인 ‘주샨’(공리)에 마음을 빼앗기고, 그로 인해 ‘두지’는 감정의 소용돌이에
												빠지게 되는데… 사랑과 운명, 아름다움을 뒤바꾼 화려한 막이 열린다!</div>
											<div class="my-score smal">
												<div class="preview">
													<p class="tit">기대평</p>
													<p class="number">
														9.6<span class="ir">점</span>
													</p>
												</div>
												<span class="sign smal">pointText</span>
												<div class="review">
													<p class="tit">관람평</p>
													<p class="number after">
														0<span class="ir">점</span>
													</p>
												</div>
											</div>
										</a>
									</div>
								</div>
								<div class="tit-area">
									<p class="movie-grade age-15">,</p>
									<p title="패왕별희 디 오리지널" class="tit">패왕별희 디 오리지널</p>
								</div>
								<div class="rate-date">
									<span class="rate">예매율 1.5%</span> <span class="date">개봉일
										2020.05</span>
								</div>
								<div class="btn-util">
									<button type="button" class="button btn-like"
										data-no="20004800">
										<i title="보고싶어 안함"
											class="iconset ico-heart-toggle-gray intrstType"></i> <span>494</span>
									</button>
									<p class="txt movieStat1" style="">상영예정</p>
									<p class="txt movieStat2" style="display: none">5월 개봉예정</p>
									<p class="txt movieStat5" style="display: none">개봉예정</p>
									<p class="txt movieStat6" style="display: none">상영종료</p>
									<div class="case col-2 movieStat3" style="display: none">
										<a href="#" class="button purple bokdBtn" data-no="20004800"
											title="영화 예매하기">예매</a> <a href="#"
											class="button purple bokdMxBtn" data-no="20004800"
											title="MX관 예매하기">MX</a>
									</div>
									<div class="case movieStat4" style="display: none">
										<a href="#" class="button purple bokdBtn" data-no="20004800"
											title="영화 예매하기">예매</a>
									</div>
								</div></li>
							<li tabindex="0" class="no-img"><div class="movie-list-info">
									<p class="rank" style="">
										19<span class="ir">위</span>
									</p>
									<img
										src="https://img.megabox.co.kr/SharedImg/2020/03/18/KXUsaJc8U56TwsVpqc7dPbsnsBzjJop5_420.jpg"
										alt="모리의 정원" class="poster lozad" onerror="noImg(this)">
									<div class="curation">
										<p class="film" style="">필름 소사이어티</p>
										<p class="classic" style="display: none">클래식 소사이어티</p>
									</div>
									<div class="screen-type">
										<p class="boutqScreen" style="">부티크</p>
										<p class="mxScreen" style="display: none">MX</p>
									</div>
									<div class="movie-score">
										<a href="#" class="wrap movieBtn" data-no="20002200"
											title="모리의 정원 상세보기">
											<div class="summary">30년 동안 정원을 벗어난 적 없는, 작은 것들의 화가
												모리카즈 아내 히데코와 조용하게 소소한 일상을 누리며 아름다운 것들만 보고 싶지만 그의 정원에 자꾸만 예기치
												못한 손님들이 찾아오기 시작하는데… 햇살, 바람, 새소리.. 자연의 아름다움이 담긴 모리의 정원으로
												초대합니다</div>
											<div class="my-score smal">
												<div class="preview">
													<p class="tit">기대평</p>
													<p class="number">
														9.1<span class="ir">점</span>
													</p>
												</div>
												<span class="sign smal">pointText</span>
												<div class="review">
													<p class="tit">관람평</p>
													<p class="number after">
														8.3<span class="ir">점</span>
													</p>
												</div>
											</div>
										</a>
									</div>
								</div>
								<div class="tit-area">
									<p class="movie-grade age-all">,</p>
									<p title="모리의 정원" class="tit">모리의 정원</p>
								</div>
								<div class="rate-date">
									<span class="rate">예매율 1.3%</span> <span class="date">개봉일
										2020.03.26</span>
								</div>
								<div class="btn-util">
									<button type="button" class="button btn-like"
										data-no="20002200">
										<i title="보고싶어 안함"
											class="iconset ico-heart-toggle-gray intrstType"></i> <span>55</span>
									</button>
									<p class="txt movieStat1" style="display: none">상영예정</p>
									<p class="txt movieStat2" style="display: none">3월 개봉예정</p>
									<p class="txt movieStat5" style="display: none">개봉예정</p>
									<p class="txt movieStat6" style="display: none">상영종료</p>
									<div class="case col-2 movieStat3" style="display: none">
										<a href="#" class="button purple bokdBtn" data-no="20002200"
											title="영화 예매하기">예매</a> <a href="#"
											class="button purple bokdMxBtn" data-no="20002200"
											title="MX관 예매하기">MX</a>
									</div>
									<div class="case movieStat4" style="">
										<a href="#" class="button purple bokdBtn" data-no="20002200"
											title="영화 예매하기">예매</a>
									</div>
								</div></li>
							<li tabindex="0" class="no-img"><div class="movie-list-info">
									<p class="rank" style="">
										20<span class="ir">위</span>
									</p>
									<img
										src="https://img.megabox.co.kr/SharedImg/asis/system/mop/poster/2017/17/046A82-5648-40F9-B2A2-4365366CA020.large.jpg"
										alt="[GET9] 언노운 걸" class="poster lozad" onerror="noImg(this)">
									<div class="curation">
										<p class="film" style="display: none">필름 소사이어티</p>
										<p class="classic" style="display: none">클래식 소사이어티</p>
									</div>
									<div class="screen-type">
										<p class="boutqScreen" style="display: none">부티크</p>
										<p class="mxScreen" style="display: none">MX</p>
									</div>
									<div class="movie-score">
										<a href="#" class="wrap movieBtn" data-no="01185300"
											title="[GET9] 언노운 걸 상세보기">
											<div class="summary">의사 '제니'는 한밤 중 누군가 병원 문을 두드리지만 진료가
												끝나 문을 열어주지 않는다. 다음 날 병원 문을 두드렸던 신원미상의 소녀가 변사체로 발견되었다는 소식을 듣게
												되고 죄책감에 사로잡힌 '제니'는 소녀의 행적을 직접 찾아 나서는데...</div>
											<div class="my-score equa">
												<div class="preview">
													<p class="tit">기대평</p>
													<p class="number">
														0<span class="ir">점</span>
													</p>
												</div>
												<span class="sign equa">pointText</span>
												<div class="review">
													<p class="tit">관람평</p>
													<p class="number after">
														0<span class="ir">점</span>
													</p>
												</div>
											</div>
										</a>
									</div>
								</div>
								<div class="tit-area">
									<p class="movie-grade age-12">,</p>
									<p title="[GET9] 언노운 걸" class="tit">[GET9] 언노운 걸</p>
								</div>
								<div class="rate-date">
									<span class="rate">예매율 1.3%</span> <span class="date">개봉일
										2020.04.07</span>
								</div>
								<div class="btn-util">
									<button type="button" class="button btn-like"
										data-no="01185300">
										<i title="보고싶어 안함"
											class="iconset ico-heart-toggle-gray intrstType"></i> <span>24</span>
									</button>
									<p class="txt movieStat1" style="display: none">상영예정</p>
									<p class="txt movieStat2" style="display: none">4월 개봉예정</p>
									<p class="txt movieStat5" style="display: none">개봉예정</p>
									<p class="txt movieStat6" style="display: none">상영종료</p>
									<div class="case col-2 movieStat3" style="display: none">
										<a href="#" class="button purple bokdBtn" data-no="01185300"
											title="영화 예매하기">예매</a> <a href="#"
											class="button purple bokdMxBtn" data-no="01185300"
											title="MX관 예매하기">MX</a>
									</div>
									<div class="case movieStat4" style="">
										<a href="#" class="button purple bokdBtn" data-no="01185300"
											title="영화 예매하기">예매</a>
									</div>
								</div></li>
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
			</div>
		</div>
		<!--// container -->
		<!-- 		</div> -->




		<section id="saw_movie_regi" class="modal-layer">
			<a href="" class="focus">레이어로 포커스 이동 됨</a> <input type="hidden"
				id="isLogin">
			<div class="wrap">
				<header class="layer-header">
					<h3 class="tit">본 영화 등록</h3>
				</header>

				<div class="layer-con">
					<p class="reset">발권하신 티켓 하단의 거래번호 또는 예매번호를 입력해주세요.</p>

					<div class="pop-gray mt10 mb30">
						<label for="movie_regi" class="mr10">거래번호 또는 예매번호</label> <input
							type="text" id="movie_regi" class="input-text w280px numType"
							maxlength="20" placeholder="숫자만 입력해 주세요" title="티켓 거래번호 입력">
						<button class="button gray ml05" id="regBtn">등록</button>
					</div>

					<div class="box-border v1 mt30">
						<p class="tit-box">이용안내</p>

						<ul class="dot-list">
							<li>극장에서 예매하신 내역을 본 영화(관람이력)로 등록하실 수 있습니다.</li>
							<li>예매처를 통해 예매하신 고객님은 극장에서 발권하신 티켓 하단의 온라인 예매번호 <br>12자리를
								입력해주세요.(Yes24, 네이버, 맥스무비, 인터파크, SKT, KT, 다음)
							</li>
							<li>본 영화 등록은 관람인원수 만큼 등록가능하며, 동일 계정에 중복등록은 불가합니다.</li>
							<li>상영시간 종료 이후 등록 가능합니다.</li>
							<li>본 영화로 수동 등록한 내역은 이벤트 참여 및 포인트 추후 적립이 불가합니다.</li>
						</ul>
					</div>
				</div>

				<div class="btn-group-fixed">
					<button type="button" class="button purple close-layer">닫기</button>
				</div>

				<button type="button" class="btn-modal-close">레이어 닫기</button>
			</div>
		</section>

		<div class="quick-area" style="display: none;">
			<a href="" class="btn-go-top" title="top" style="position: fixed;">top</a>
		</div>

		<!-- footer -->
		<footer id="footer">
			<!-- footer-top -->
			<div class="footer-top">
				<div class="inner-wrap">
					<ul class="fnb">
						<li><a href="/megaboxinfo" title="회사소개 페이지로 이동">회사소개</a></li>
						<li><a href="/recruit" title="인재채용 페이지로 이동">인재채용</a></li>
						<li><a href="/socialcontribution" title="사회공헌 페이지로 이동">사회공헌</a></li>
						<li><a href="/partner" title="제휴/광고/부대사업문의 페이지로 이동">제휴/광고/부대사업문의</a></li>
						<li><a href="/support/terms" title="이용약관 페이지로 이동">이용약관</a></li>
						<li class="privacy"><a href="/support/privacy"
							title="개인정보처리방침 페이지로 이동">개인정보처리방침</a></li>
						<li><a href="https://jebo.joonganggroup.com/main.do"
							target="_blank" title="윤리경영 페이지로 이동">윤리경영</a></li>
					</ul>

					<a href="#layer_looking_theater" class="btn-looking-theater"
						title="극장찾기"><i class="iconset ico-footer-search"></i> 극장찾기</a>
				</div>
			</div>
			<!--// footer-top -->

			<!-- footer-bottom -->
			<div class="footer-bottom">
				<div class="inner-wrap">
					<div class="ci">MEGABOX : Life Theater</div>

					<div class="footer-info">
						<div>
							<address>서울특별시 성동구 왕십리로 50, 6층(성수동 1가, 메가박스스퀘어)</address>
							<p>ARS 1544-0070</p>
						</div>
						<p>대표자명 김진선</p>
						<p>· 개인정보보호책임자 조상연</p>
						<p>· 사업자등록번호 211-86-59478</p>
						<p>· 통신판매업신고번호 제 833호</p>
						<p class="copy">COPYRIGHT © MegaboxJoongAng, Inc. All rights
							reserved</p>
					</div>

					<div class="footer-sns">
						<a href="https://twitter.com/megaboxon" target="_blank"
							title="MEGABOX 트위터 페이지로 이동"><i class="iconset ico-twitter">트위터</i></a>
						<a href="https://www.facebook.com/megaboxon" target="_blank"
							title="MEGABOX 페이스북 페이지로 이동"><i class="iconset ico-facebook">페이스북</i></a>
						<a href="http://instagram.com/megaboxon" target="_blank"
							title="MEGABOX 인스타그램 페이지로 이동"><i
							class="iconset ico-instagram">인스타그램</i></a> <a
							href="https://play.google.com/store/apps/details?id=com.megabox.mop"
							target="_blank" title="MEGABOX 구글플레이 페이지로 이동"><i
							class="iconset ico-googleplay">구글플레이</i></a> <a
							href="https://itunes.apple.com/kr/app/megabox/id894443858?l=ko&amp;ls=1&amp;mt=8"
							target="_blank" title="MEGABOX 앱스토어 페이지로 이동"><i
							class="iconset ico-appstore">앱스토어</i></a>
					</div>
				</div>
			</div>
			<!--// footer-bottom -->
			<div id="layer_looking_theater" class="layer-looking-theater"></div>
		</footer>
		<!--// footer -->

		<!-- 모바일 때만 출력 -->
		<div class="go-mobile" style="display: none;">
			<a href="#" data-url="https://m.megabox.co.kr">모바일웹으로 보기 <i
				class="iconset ico-go-mobile"></i></a>
		</div>
	</div>
	<form id="mainForm"></form>

	<div class="normalStyle"
		style="display: none; position: fixed; top: 0; left: 0; background: #000; opacity: 0.7; text-indent: -9999px; width: 100%; height: 100%; z-index: 100;">닫기</div>
	<div class="alertStyle"
		style="display: none; position: fixed; top: 0px; left: 0px; background: #000; opacity: 0.7; width: 100%; height: 100%; z-index: 5005;"></div>
</body>
</body>
</html>