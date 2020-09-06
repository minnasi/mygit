$(function() {
	imageUploadAjax();
	// checkThumbNailAndBG();
	selectWhereRegiste();
	selectMovie();
	selectLocation();
	selectBranch();
	selectTheater();
	selectBranchInTheater();
	getTimeTable();
	selectTheaterInTimeTable();
	clickTimeInTimeTable();
	addMovieInfo();
	changeDateInTimeTable();
	// test();

})

$(function() {
	// 첫 입장 시 첫번째 영화 클릭되있는 상태와 이미지 셋팅
	// 영화선택
	$('#mCSB_2_container').find('li:first-child button').addClass('on');
	// 극장등록
	$('#masterBrch').find('li:first-child > a').addClass("on");
	// 브랜치 등록
	$('#tab10').addClass("on");
})

// 타임테이블 시간대 클릭 시
function clickTimeInTimeTable() {
	$('.theater-list-box').bind('click', 'table tr > td', function(event) {
		var target = $(event.target);
		var tdTag = target.closest('td');
		tdTag.find('a').addClass('on');
		tdTag.find('.time').addClass('on');
		tdTag.find('.movieTime').addClass('on');
		console.log(tdTag);

	})
}

// movieInfo 등록
function addMovieInfo() {

	$('.inner-wrap').on('click', '.top-100 > #addMovieInfo', function(event) {

		var movieName = $('#masterMovie').find('.list .on').val();
		var branch = $('#masterBrch').find('.list-section ul').find('.on');
		var branchName = new Array();
		$.each(branch, function(index, value) {
			branchName.push($(this).text());
		})

		var theater = $('#masterTheater').find('.list-section ul').find('.on');
		var theaterName = new Array();
		$.each(theater, function(index, value) {
			theaterName.push($(this).text());
		})

		var movieStartTime = new Array();
		var movieEndTime = new Array();
		var time = $('.inner-wrap .time-list-table td .play-time').find('.on');
		console.log(time);

		time.each(function(index, value) {
			var time = $(this).text();
			console.log(time);
			movieStartTime.push(time.split('~')[0]);
			movieEndTime.push(time.split('~')[1]);
		})
		
		console.log("날짜 :  " +$('.date-area .on').attr('date-data'));
		console.log("영화이름 :  " + movieName);
		console.log("브랜치 이름  : " + branchName);
		console.log("상영관 이름  : " + theaterName);
		console.log("영화시작시간  : " + movieStartTime);
		console.log("영화 끝시간  : " + movieEndTime);

		$.ajax({
			url : "/movieAddBranchAndTheater",
			type : "POST",
			traditional : true,
			data : {
				movieDate : $('.date-area .on').attr('date-data'),
				movieName : movieName,
				branchName : branchName,
				theaterName : theaterName,
				movieStartTime : movieStartTime,
				movieEndTime : movieEndTime
			}
		}).done(function(result) {
			console.log("ajax 성공 !");
			
		})

		// var data = {};
		// data["movieName"] = movieName;
		// data["branchName"] =branchName;
		// data["theaterName"] = theaterName;
		// data["movieStartTime"] = movieStartTime;

		// $.ajaxSettings.traditional = true;
		$(location).attr('href','/addMovieInfo');

	})
}

function selectTheaterInTimeTable() {
	$('.timeTable .tit').on(
			'click',
			'a , a > span',
			function(event) {
				var target = $(event.target);
				$('.timeTable .tit *').removeClass('font-green');
				target.addClass('font-green');
				target.find('span').addClass('font-green');
				var timeTableTheaterName = $('.timeTable').find(
						'div[data-theater-no="'
								+ target.closest('a').attr('data-theater-no')
								+ '"]');

				timeTableTheaterName.find('.theater-tit p:first-child').text(
						target.closest('a').find('span').text());
				var theaterNo = target.closest('a').attr("data-theater-no");
				$('.theater-list-box > div').removeClass('on');
				// console.log($('.theater-list-box
				// div[data-theater-no="'+theaterNo+'"]'));
				$('.theater-list-box div[data-theater-no="' + theaterNo + '"]')
						.addClass('on');

			})
}

function selectTheater() {
	$("#masterTheater .tab-list-choice ul").bind("click", "a", function(event) {
		var target = $(event.target);
		target.closest('.tab-list-choice').find('a').removeClass('on');
		targetAddClassOn(target);

		var targetArea = target.attr('data-area-cd');
		$('.list-section > div').removeClass('on');
		$('#masterTheater #tab' + targetArea).addClass('on');

	})
}

function selectBranchInTheater() {
	$("#masterTheater .list-section").bind(
			"click",
			"ul > li",
			function(event) {
				var target = $(event.target);
				targetAddClassOn(target);
				$('.timeTable > h3').append(
						'<a href="" style="padding: 10px;" class="theaterTimeTable" '
								+ 'onclick="return false" data-theater-no="'
								+ target.attr("data-theater-no") + '">'
								+ '<span class="">' + target.text() + '</span>'
								+ '</a>')
			})
}

function changeDateInTimeTable() {
	$('.time-schedule .date-area').on('click', 'button', function(event) {
		console.log($(this));
		var button = $(this);
		button.closest('div').find('button').removeClass('on');
		button.addClass('on');

	})
}

// 타임테이블 가져오기 ( 등록된 영화 시간대, 등록할수 있는 시간대 둘다 나오게)
function getTimeTable() {
	$('.managerButton')
			.on(
					'click',
					function(event) {

						// 상영관 한개도 클릭 안되있을 시 Alert창
						if ($('#masterTheater .list-section ul').find('.on').length == 0) {
							alert('상영관을 선택해주세요');
							return;
						}
						$('.timeTable').addClass('on');

						// 상영관Code번호 구하는 부분
						var theaterNo = new Array();
						var theaters = $('.timeTable > h3 > a');
						$.each(theaters, function(index, value) {
							theaterNo.push($(this).attr('data-theater-no'));
						})

						// 상영시간표 날짜 구하는 부분
						var timeSchedule = $(
								'.timeTable .time-schedule .date-area').find(
								' div > .on').attr('date-data');

						var colGroup = '<colgroup>'
								+ '<col style="width: 99px;">'
								+ '<col style="width: 99px;">'
								+ '<col style="width: 99px;">'
								+ '<col style="width: 99px;">'
								+ '<col style="width: 99px;">'
								+ '<col style="width: 99px;">'
								+ '<col style="width: 99px;">'
								+ '<col style="width: 99px;">' + '</colgroup>';
						var movieName = $('#masterMovie').find('.list .on')
								.val();

						$('.inner-wrap')
								.append(
										'<div class="box-alert top-100">'
												+ '<button type="button" class="managerButton" id="addMovieInfo" value="null">등록하기</button>'
												+ '</div>');

						// 해당 상영관 시간표 구해오는 Ajax (return value : movieStartTime )
						$
								.ajax(
										{
											url : "/getTheatersTimeTable",
											type : "POST",
											traditional : true,
											data : {
												theaterNo : theaterNo,
												timeSchedule : $(
														'.date-area .on').attr(
														'date-data'),
												movieName : $('#masterMovie #mCSB_2 ul .on').val()
											// timeSchedule : timeSchedule
											}
										})
								.done(
										function(result) {
											for (var i = 0; i < result.resigMovieTime.length; i++) {
												$('.theater-list-box')
														.append(
																'<div class="theater-list" data-theater-no="'
																		+ result.resigMovieTime[i][0].theater.theaterCode
																		+ '">'
																		+ '<div class="theater-tit">'
																		+ '<p>'
																		+ $(
																				'.timeTable > .mt100 .font-green')
																				.text()
																		+ '</p>'
																		+ '<p class="infomation">'
																		+ '<span>등록하려는 영화 : '
																		+ movieName
																		+ '</span>/상영시간 '
																		+ $(
																				'#'
																						+ movieName)
																				.val()
																		+ '분'
																		+ '</p>'
																		+ '</div>'
																		+ '<div class="theater-type-box">'
																		+ '<div class="theater-time">'
																		+ '<div class="theater-time-box">'
																		+ '<table class="time-list-table">'
																		+ '<caption>상영시간을 보여주는 표 입니다.</caption>'
																		+ colGroup
																		+ '<tbody>'
																		+ '<tr>'

																		+ '</tr>'
																		+ '</tbody>'
																		+ '</table>'
																		+ '</div>'
																		+ '</div>'
																		+ '</div>'
																		+ '</div>')
												// 기존 영화
												if (result.resigMovieTime[i].length > 1) {
													$
															.each(
																	result.resigMovieTime[i],
																	function(
																			index,
																			item) {
																		var test = $('.theater-list[data-theater-no="'
																				+ result.resigMovieTime[i][0].theater.theaterCode
																				+ '"');
																		test
																				.find(
																						'table tr')
																				.append(
																						'<td class="" brch-no="1372" play-schdl-no="2003291372004" rpst-movie-no="20007800" theab-no="01" play-de="20200329" play-seq="4">'
																								+ '<div class="td-ab">'
																								+ '<div class="txt-center">'
																								+ '<a href="" title="영화예매하기" style="color:red;" onclick="return false">'
																								+ '<div class="ico-box">'
																								+ '<i class="iconset ico-off"></i>'
																								+ '</div>'
																								+ '<p class="time" style="color:red;">'
																								+ item.movieStartTime
																								+ '</p>'
																								+ '<p class="movieName">'
																								+ item.movie.movieName
																								+ '</p>'
																								+ '<div class="play-time">'
																								+ '<p>'
																								+ item.movieStartTime
																								+ '~'
																								+ item.movieEndTime
																								+ '</p>'
																								+ '<p>'
																								+ index
																								+ '회차</p>'
																								+ '</div>'
																								+ '</a>'
																								+ '</div>'
																								+ '</div>'
																								+ '</td>')

																	})
												}
												// 등록할 수 있는 시간대
												$
														.each(
																result.canAddMovieTime[i],
																function(index,
																		item) {
																	var test = $('.theater-list[data-theater-no="'
																			+ result.resigMovieTime[i][0].theater.theaterCode
																			+ '"');
																	test
																			.find(
																					'table tr')
																			.append(
																					'<td class="canAddMovieTime" brch-no="1372" play-schdl-no="2003291372004" rpst-movie-no="20007800" theab-no="01" play-de="20200329" play-seq="4">'
																							+ '<div class="td-ab">'
																							+ '<div class="txt-center">'
																							+ '<a href="" title="영화예매하기" onclick="return false">'
																							+ '<div class="ico-box">'
																							+ '<i class="iconset ico-off"></i>'
																							+ '</div>'
																							+ '<p class="time">'
																							+ item.movieStartTime
																							+ '</p>'
																							+ '<p class="movieName"> 등록가능 </p>'
																							+ '<div class="play-time">'
																							+ '<p class="movieTime">'
																							+ item.movieStartTime
																							+ '~'
																							+ item.movieEndTime
																							+ '</p>'
																							+ '<p>'
																							+ index
																							+ '회차</p>'
																							+ '</div>'
																							+ '</a>'
																							+ '</div>'
																							+ '</div>'
																							+ '</td>')
																})

												// 정렬은 했는데 적용 어케하는지 모름 ㅜㅜ
												var time = $('.timeTable .time-list-table tr > td .time');
												var timeArray = new Array();
												time
														.each(function(index,
																value) {
															timeArray.push($(
																	this)
																	.text())
														})
												timeArray.sort();

												// tablesorter안먹힘 ㅠㅠ
												$('.time-list-table table')
														.tablesorter();

												// 인터넷보고했는데 안됨 ㅜㅜ
												$.each(timeArray, function(
														index, value) {
													var find = time.find(
															'p:contains('
																	+ value
																	+ ')')
															.closest('tr');
													find.prev().before(find);
												})

												// console.log(timeArray);

											}
											// console.log(item.movieDate);
											// var date = new Date
											// (item.movieDate,
											// item.movieStartTime);
											// canAddTime.push( parseFloat(
											// item.movieStartTime ) );

											// 기존 영화
											// $.each(data,function(index,
											// value){
											// console.log(value);
											// console.log(value);
											/*
											 * $('.theater-list-box').append( '<div
											 * class="theater-list"
											 * data-theater-no="'+value.resigMovieTime[index].theater.theaterCode+'">' +'<div
											 * class="theater-tit">' +'<p>'+value.resigMovieTime[index].theater.theaterName+'</p>' +'<p class="infomation">' +'<span>등록하려는
											 * 영화 : '+movieName+'</span>/상영시간
											 * '+$('#'+movieName).val()+'분' +'</p>' +'</div>' +'<div
											 * class="theater-type-box">' +'<div
											 * class="theater-time">' +'<div
											 * class="theater-time-box">' +'<table
											 * class="time-list-table">' +'<caption>상영시간을
											 * 보여주는 표 입니다.</caption>' +colGroup +'<tbody>' +'<tr>' +'</tr>' +'</tbody>' +'</table>' +'</div>' +'</div>' +'</div>' +'</div>'
											 * //append끝 );
											 * 
											 * //var canAddTime = new Array();
											 * $.each(value.resigMovieTime,
											 * function(index, item){
											 * //console.log(item.movieDate);
											 * //var date = new Date
											 * (item.movieDate,
											 * item.movieStartTime);
											 * //canAddTime.push( parseFloat(
											 * item.movieStartTime ) );
											 * console.log(item); var test =
											 * $('.theater-list[data-theater-no="'+value.resigMovieTime[index].theater.theaterCode+'"');
											 * test.find('table tr').append( '<td class="" brch-no="1372" play-schdl-no="2003291372004" rpst-movie-no="20007800" theab-no="01" play-de="20200329" play-seq="4">' +'<div
											 * class="td-ab">' +'<div
											 * class="txt-center">' +'<a
											 * href="" title="영화예매하기">' +'<div
											 * class="ico-box">' +'<i
											 * class="iconset ico-off"></i>' +'</div>' +'<p class="time">'+item.movieStartTime+'</p>' +'<p class="movieName">'+item.movie.movieName+'</p>' +'<div
											 * class="play-time">' +'<p>'+item.movieStartTime+'~'+item.movieEndTime+'</p>' +'<p>'+index+'회차</p>' +'</div>' +'</a>' +'</div>' +'</div>' +'</td>' ) })
											 */

											// each끝
											// });
											// ajax끝
										})

					})
}
/*
 * $(document).on("click","#masterTheater .list-section #tab10
 * button",function(event){ var target = $(event.target); console.log(target);
 * targetAddClassOn(target); })
 */
function targetAddClassOn(target) {
	if (target.hasClass('on') == false) {
		// 브랜치 클릭 시 on Class 추가
		target.addClass('on');
	} else {
		target.removeClass('on');
	}
}

function selectMovie() {
	$('#masterMovie .list-section button').on('click', function(event) {
		var target = $(event.target);
		target.closest('ul').find('button').removeClass('on');
		target.addClass('on');

		var imagePoster = target.attr('data-img-path');
		$('.poster').attr('src', "/img/" + imagePoster);

	})
}

function selectBranch() {
	$('#masterBrch .list-section button')
			.on(
					'click',
					function(event) {
						var target = $(event.target);
						if (target.hasClass('on') == false) {
							// 브랜치 클릭 시 on Class 추가
							target.addClass('on');

							// 상영관 선택탭에 브랜치명 추가
							var branchName = target.text();
							/*
							 * $('#masterTheater .tab-list-choice ul').append( '<li><a
							 * href="" ' +'title=" 강북구지점 선택"
							 * data-area-cd="'+data[0].branch.branchCode+'0"
							 * onclick = "return false"' +'>'+branchName+'</a></li>' );
							 */

							// 상영관 선택탭 안에 브랜치 추가되면 해당 브랜치의 상영관 추가
							$
									.ajax({
										url : "/getTheaterInAddMovie",
										method : "GET",
										data : {
											branchName : branchName
										}
									})
									.done(
											function(data) {
												var theaterList = function() {
													$
															.each(
																	data,
																	function(
																			index,
																			value) {
																		'<li><button type="button" class="btn"'
																				+ 'data-area-cd="'
																				+ index
																				+ '0" data-theater-no="'
																				+ value.theaterCode
																				+ '">'
																				+ value.theaterName
																				+ '</button></li>'
																	})
												}

												$(
														'#masterTheater .tab-list-choice ul')
														.append(
																'<li><a href="" '
																		+ 'title=" 강북구지점 선택" data-area-cd="'
																		+ data[0].branch.branchCode
																		+ '0" onclick = "return false"'
																		+ '>'
																		+ branchName
																		+ '</a></li>');

												// 상영관 탭에서 브랜치마다 상영관 영역 append.
												// 사실 여기서 ul 밑에 $.each로 해주고 싶었음
												// ㅠㅠ
												$(
														'#masterTheater .list-section')
														.append(
																'<div id="tab'
																		+ data[0].branch.branchCode
																		+ '0" class="tab-layer-cont">'
																		+ '<div class="scroll m-scroll">'
																		+ '<ul class="list">'
																		+ '</ul>'
																		+ '<div>'
																		+ '</div>')

												// 각 브랜치 영역마다 데이터 append (li를
												// 넣어줌)
												$
														.each(
																data,
																function(index,
																		value) {
																	$(
																			'#masterTheater .list-section #tab'
																					+ value.branch.branchCode
																					+ '0 ul')
																			.append(
																					'<li><button type="button" class="btn" '
																							+ 'data-area-cd="'
																							+ index
																							+ '0" data-theater-no="'
																							+ value.theaterCode
																							+ '">'
																							+ value.theaterName
																							+ '</button></li>')
																})
											});
						} else {
							target.removeClass('on');
							var targetTag = $('#masterTheater .tab-list-choice')
									.find("a:contains('" + target.text() + "')");
							var dataArea = targetTag.attr('data-area-cd');
							targetTag.closest('li').remove();
							$('#masterTheater .list-section #tab' + dataArea)
									.remove();

						}

					})
}

function selectLocation() {
	$('.tab-list-choice a').on('click', function(event) {
		var target = $(event.target);
		var tabId = target.attr('data-area-cd');
		$('#masterBrch .tab-list-choice li a').removeClass('on');
		$('.list-section > div').removeClass('on');
		target.addClass('on');
		$('#masterBrch #tab' + tabId).addClass('on');

	})
}

/*
 * function selectLocation(){ $('.tab-list-choice
 * a').on('click',function(event){ $.ajax({ url : $(this).attr('href'), success :
 * function(result) { $('#masterBrch').find('.on').removeClass('on'); var target =
 * $(event.target); target.closest('ul').find('a').removeClass('on');
 * target.addClass('on');
 * 
 * $('#masterBrch .list-section').find('.on').removeClass('on');
 * 
 * var tabId = $('#tab'+target.attr('data-area-cd')); tabId.addClass('on');
 * tabId.find('div').addClass('on'); tabId.find('div li').addClass('on');
 * tabId.find('ul').empty(); $.each(result,function(index,value){
 * tabId.find('ul').append( '<li>' +'<button type="button" class="btn"
 * data-brch-no="'+value.branchCode+'">'+value.branchName+'</button>' +'</li>' ) }) } }) }) }
 */

/*
 * var countChecked = function() { var n = $( "input:checked" ).length; };
 * countChecked(); $( "input[type=checkbox]" ).on( "click", countChecked );
 */

function selectWhereRegiste() {
	$('.tab-left-area').find('.btn')
			.bind(
					'click',
					function(event) {
						// 좌측 ~~등록의 on 제거 , 클릭한거 on 등록
						$(event.target).closest('ul').find('li').removeClass(
								'on');
						$(this).closest('li').addClass('on');
						$('.ltab-layer-wrap').find('div').removeClass('on');

						// #masterMovie , #masterBranch
						var hrefTarget = $(event.target).closest('a').attr(
								'href');
						var sectionTarget = $('.ltab-layer-wrap').find(
								hrefTarget);
						sectionTarget.addClass('on');
						var contentsTarget = sectionTarget
								.find('.list-section');
						contentsTarget.addClass('on');
						var dataArea = $('.ltab-layer-wrap > .on').find(
								'.tab-list-choice li').find('.on').attr(
								'data-area-cd');
						$('.ltab-layer-wrap > .on').find(
								'.list-section > #tab' + dataArea).addClass(
								'on');
						// $(event.target).closest('.tab-layer-cont').addClass('on');
						// var dataArea = $(event.target).attr('data-area-cd');
						// contentsTarget.find($('#tab'+dataArea) ).addClass('on');
					})

}

function checkThumbNailAndBG() {
	$("input[type=checkbox]").on('click', function(event) {
		var check = $('.CheckThumbNailAndBG').is(":checked");
		var checkLength = $("input:checked").legnth;
		if (checkLength > 3) {
			alert("2개만 선택해주세요. 첫번째 : 대표이미지,  두번째 : 배경이미지 ")
		}
	})
}

function imageUploadAjax() {
	$('.form-control')
			.on(
					'change',
					function(event) {
						event.preventDefault();
						$('.form-group .selectThumbnail').empty();
						$('.form-group .selectThumbnail').append(
								'첫번째 이미지가 대표이미지, 두번째 이미지가 배경이미지입니다.');
						var form = document.forms[0];
						var formData = new FormData(form);
						// Ajax call for file uploaling
						$
								.ajax({
									enctype : 'multipart/form-data',
									url : '/fileUpload',
									type : 'POST',
									cache : false,
									contentType : false,
									processData : false,
									data : formData,
									success : function(result) {
										$
												.each(
														result,
														function(index, value) {
															$('.form-group')
																	.append(
																			'<div class="thumbNailImages widthImage">'
																					+ '<input type="hidden" name="movieImages" value="'
																					+ result[index]
																					+ '">'
																					+ '<img src = "/img/'
																					+ result[index]
																					+ '" alt="Oops..!o!" class="widthImage"></img>'
																					+ '</div>')
														})
									}
								})
					})
}