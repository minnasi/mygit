$(function() {
	clickTheater();
	clickLocation();
	getMovieName();
	requestKakaoPay();
	clickMovie();
	movieNotRegis();
	getMovieForDate();
})

function getMovieForDate(){
	$('.date-area button').on('click',function(event){
		$(this).closest('div').find('button').removeClass('on');
		var target = $(event.target);
		target.addClass('on');
		$.ajax({
			url:"/getMovieForDate",
			data:{
				movieDate:target.val()
			}
		}).done(function(result){
			$('.movie-choice .list #mCSB_1_container > ul').empty();
			$.each(result.movieList,function(index,value){
				$('#mCSB_21_container').attr('style','display:none');
				$('#playScheduleNonList').attr('style','display:block');
				$('.theater-choice .list .on').removeClass('on');
				$('.theater-choice .depth li').empty();
				var span ;
				if( index %4 == 0 ){
					span = '<span class="movie-grade small age-12">12세이상관람가</span>'
				}else if( index %4 == 2){
					span = '<span class="movie-grade small age-15">15세이상관람가</span>'
				}else if( index %8 == 5){
					span = '<span class="movie-grade small age-19">19세이상관람가</span>'
				}else{
					span = '<span class="movie-grade small age-all">전체관람가</span>'
				}
				
				
				$('#mCSB_1_container > ul').append(
				'<li>'
					+'<button type="button" class="btn" value="'+value.movieName+'" disabled>'
					+'<i class="iconset ico-heart-small">보고싶어 설정안함</i>'
					+ span
					+'<span class="txt">'+value.movieName+'</span>'
					+'</button>'
				+'</li>'
				);
			})
			$.each(result.movie,function(index,value){
				$('#mCSB_1_container > ul').append(
				'<input type="hidden" value="'+value.movieName+'" class="regisMovie" name="regisMovie">'
				);
			})
			movieNotRegis();
		})
	})
}
function movieNotRegis(){
	var regisMovie = $('input[name="regisMovie"');
	$.each(regisMovie,function(index,value){
		$('#mCSB_1_container > ul li').find('span:contains('+value.value+')').closest('button').attr('disabled',false);
	})
}

function requestKakaoPay() {
	$('.button').on('click', function(event) {
		var countPeople = $("#selectBox option:selected").val();
		if(countPeople == 'select'){
    		alert("인원수와 좌석을 선택해주세요");
    		return;
    	}
		$('#kakaoPay').submit();
	})

}

function changeChoiseMovie(){
	$('#mCSB_1_container ul').on('click','li',function(event){
		console.log($(event.target));
		$('.theater-choice .on').removeClass('on has-issue');
		$('.theater-choice').find('.all-list > button').addClass('on');
		$('.result').find('ul').empty();
		$('#movie-schedule-area').attr('style', 'display:none');
		$('#playScheduleNonList').attr('style', 'display:block');

	})
}

function getMovieName() {
	var movieName = $('#ticketMovieName').val();
	if ($('#ticketMovieName').val() != "") {
		$('#mCSB_1_container').find("span:contains('" + movieName + "')")
				.parent().addClass('on');
	}
}

function clickMovie() {
	$('#mCSB_1_container ul').on('click','button',function(event){
		addOnClass(event);
		changeChoiseMovie();
		$('.theater-choice .depth').attr('style','display:none');
	})
}

function clickTheater() {
	$('.theater-choice .mCSB_container').bind('click', function(event) {
		getMovieInfoAndTime(event);
	})
}

function clickLocation() {
	$('.theater-choice .list-area .btn').on('click', function(event) {
		getTheater(event);
	})
}

		function addOnClass(event) {
			//타겟의 버튼
			const targetButton = $(event.target).closest('button');
			//타겟 버튼의 클래스
			const buttonClassName = targetButton.attr('class');
			if (targetButton.hasClass("on") == false) {
				//기존 버튼의 하이라이트 없애기
				$(event.target).closest('ul').find("button")
						.removeClass('on has-issue');
				//클릭한 버튼 하이라이트
				targetButton.addClass('on has-issue');
			} else {
				//하이라이트 된 것 눌렀을때 하이라이트 삭제
				targetButton.removeClass('on has-issue');
			}
		}


// 69-106 theater
function getTheater(event) {
	event.preventDefault();
	addOnClass(event);
	var movieName = $('.movie-choice #mCSB_1_container li').find('.on').val();
	var movieDate =  $('.date-list .date-area .on').val();
	var locationName = $(event.target).closest('button').find('span').text();
	
	console.log("movieName  "+  movieName);
	console.log("movieDate  "+movieDate);
	console.log("locationName  "+locationName);
	$.ajax({
				url : "/getBranch",
				type : 'GET',
				contentType : "application/x-www-form-urlencoded; charset=UTF-8",
				dataType : 'JSON',
				data : {
					movieDate : movieDate,
					movieName : movieName,
					locationName : locationName
				/*
				 * movieLocation : $(this).children().text()
				 */
				},
				success : function(result) {
					const targetLi = $(event.target).closest('li');
					$('#brchList').find('.depth').attr('style', 'display:none');
					targetLi.find('.depth').attr('style', 'display:flex');
					$('#mCSB_21_container').attr('style', 'display:none');
					$('#playScheduleNonList').attr('style', 'display:block');
					// console.log($(event.target).closest('li').find('.depth'));
					// 
					const theater = targetLi.find('.mCSB_container ul');
					theater.empty();

					$
							.each(
									result,
									function(index, item) {
										theater
												.append('<li><button class="locationForTheater" id="btn" type="button" value="'
														+ item.branchName
														+ '">'
														+ '<span>'
														+ item.branchName
														+ '</span>'
														+ '<span>('
														+ item.movieCount
														+ ')</span>'
														+ '</button></li>');
									})
				}

			});
}

	function getMovieInfoAndTime(event) {
	
		var dataArray = new Array();
		$.each($(".on"), function(key, value) {
			if ($(this).val() != "") {
				// Array에 List형태로 들어감 - 0 : movieDate, 1 : movieName, 2: locationName, 3: branchName
				dataArray.push($(this).val());
			}
		})
		if (dataArray.length < 3) {
			alert('영화, 극장을 모두 선택해주세요');
			return;
		}
	
		
		addOnClass(event);
	
		//branchName 중복될 경우 지우고 한개만 다시 넣음
		if (dataArray.length > 3) {
			dataArray.pop();
		}
		dataArray.push($(event.target).closest('button').val());

				$.ajax({
				url : "/getMovieInfoAndTime",
				type : 'GET',
				contentType : "application/x-www-form-urlencoded; charset=UTF-8",
				dataType : 'JSON',
				data : {
					'movieDate' : $('#formDeList > div .on').val(),
					'movie.movieName' : dataArray[1],
					'branch.location.locationName' : dataArray[2],
					'branch.branchName' : dataArray[3]
				},
				success : function(result) {
					//영화 골라주세요 랑 영화없어요를 none시키고  결과값을 보여줌
					$('.result0').attr('style','display:none');
					$('#playScheduleNonList').attr('style', 'display:none');
					$('#mCSB_21_container').attr('style', 'display:block');
					if(result.length < 1 ){
						$('.result0').attr('style','display:block');
					}
					
					$('.result').find('ul').empty();
					$
							.each(
									result,
									function(index, item) {
										$('.result')
												.find('ul')
												.append(
														'<li>'
																+ '<form action="/getSelectScreen" method="post">'
																+ '<button type="submit" class="btn" >'
																+ '<div class="legend"></div>'
																+ '<span class="time"><strong title="상영 시작">'
																+ item.movieStartTime
																+ '</strong>'
																+ '<em title="상영 종료">~'
																+ item.movieEndTime
																+ '</em>'
																+ '</span><span class="title"><strong title="'
																+ item.movie.movieName
																+ '">'
																+ item.movie.movieName
																+ '</strong><em>2D(자막)</em></span>'
																+ '<div class="info">'
																+ '<span class="theater" title="'
																+ item.branch.branchName
																+ '">'
																+ item.branch.branchName
																+ '<br>'
																+ item.theater.theaterName
																+ '</span><span class="seat"><strong class="now" title="잔여 좌석">'
																+ item.theater.theaterLeftSeat
																+ '</strong>'
																+ '<span>/</span><em class="all" title="전체 좌석">'
																+ item.theater.theaterAllSeat
																+ '</em></span>'
																+ '</div></button>'
																+ '<input type="hidden" name="moiveInfoCode" value="'
																+ item.moiveInfoCode
																+ '" >'
																+ '<input type="hidden" name="movie.movieName" value="'
																+ item.movie.movieName
																+ '" >'
																+ '<input type="hidden" name="movie.moviePoster" value="'
																+ item.movie.moviePoster
																+ '" >'
																+ '<input type="hidden" name="movieStartTime" value="'
																+ item.movieStartTime
																+ '" >'
																+ '<input type="hidden" name="movieEndTime" value="'
																+ item.movieEndTime
																+ '" >'
																+ '<input type="hidden" name="branch.branchName" value="'
																+ item.branch.branchName
																+ '" >'
																+ '<input type="hidden" name="theater.theaterCode" value="'
																+ item.theater.theaterCode
																+ '" >'
																+ '<input type="hidden" name="theater.theaterName" value="'
																+ item.theater.theaterName
																+ '" ></form>'
																+ '</li>');
									})
				}
			})
}