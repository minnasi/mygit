/**
 * 
 */



$(function(){
	checkUserId();
	checkPassword();
	checkSamePassword();
	signUpButtonChange();
	
	
})

function signUpButtonChange(){
	$('.board-form tr td').on('keyup','input',function(event){
		var inputTag = $('table tr td input');
		var data = new Array();
		inputTag.each(function(event){
			console.log("value : "+ $(this).val() );
			if( $(this).val() != ""){
				data.push($(this).val());
			}
		})
		console.log(data);
		if(data.length == 6){
		$('#btnJoinInfoRegButton').removeClass('disabled');
		}
	})
}

function checkUserId(){
	$('#ibxJoinInfoRegLoginId').on('keypress',function(event){
		check(event,'아이디');
	})
}

function checkPassword(){
	$('#ibxJoinInfoRegLoginPwd').on('keypress',function(event){
		check(event,'비밀번호');
	})
}


function checkSamePassword(){
	$('#ibxJoinInfoRegLoginPwdConfirm').on('keyup',function(event){
		var password = $('#ibxJoinInfoRegLoginPwd').val();
		var confirm = $('#ibxJoinInfoRegLoginPwdConfirm').val();
		var errorMsg = $(event.target).closest('tr').find('div');
		if(password != confirm){
			errorMsg.empty();
			errorMsg.append(
				'패스워드가 일치하지 않습니다'	
			);
			return;
		}
		errorMsg.empty();
	})
}

function check(event, msg){
	var password = $(event.target).val();
	var errorMessage = $(event.target).closest('tr').find('div');
	if(  8 > ( password.length+1 ) ){
		errorMessage.empty();
		errorMessage.append(
				msg+'는 영문,숫자 조합 8자리 이상이여야 합니다.'
				)
				return;
	}
	errorMessage.empty();
}

