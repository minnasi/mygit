$(function() {
	readySeatStatus();
	selectSeat();


})

function readySeatStatus(){
	var seat = $('.row__seat');
	$.each(seat, function(index, value) {
		if ($(this).attr('data-area') == 1) {
			$(this).addClass('row__seat--reserved');

		}
	})
}

function selectSeat(){
	$('.rows--mini .row').on("click",".row__seat",function(event){
		var seatName = $(event.target).text();
		var countPeople = $("#selectBox option:selected").val();
		var countSelectSeat = $('#test p').length;
		//if(count)
		console.log(countPeople);
		console.log(countSelectSeat);
		
		console.log()
		var target = $(event.target);
		
		    if( target.hasClass('row__seat--selected')){
		    	target.removeClass('row__seat--selected');
		    	
		    	$('#test > p:contains('+seatName+') ').remove();
		    	console.log($('input[value="'+seatName+'"]'));
		    	$('input[value="'+seatName+'"]').remove();
		    }else{
		    	if(countPeople == 'select'){
		    		alert("인원수를 선택해주세요");
		    		return;
		    	}
		    	if(countPeople == countSelectSeat ){
		    		alert("최대 "+countPeople+"개의 좌석만 선택할 수 있습니다.")
		    		return;
		    	}
		    			$(this).addClass('row__seat--selected');
		    			$("#test").append(
		    					'<p>'+seatName+'</p>'
		    					+'<input type="hidden" name="seatName" value="'+seatName+'">'
		    			);
		    	}
	})
}


	
	

function OnChange() {
	//셀렉트박스에서 선택한 값
	var selected = $("#selectBox option:selected").val();
	console.log(selected);
	//input hidden totalPeople값 변경
	$('#totalPeople').val(selected);
	
	var fixedNum = 10000;
	var sum = 0;
	//최종 결제금액
	sum = selected * fixedNum;
	$('#totalPrice').val(sum);
	if (!isNaN(sum)) {
		$('.seat-result .pay-area .total').find('em').text(sum);
	} else {
		$('.seat-result .pay-area .total').find('em').text('0');
	}
}












