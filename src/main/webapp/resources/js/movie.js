
$(function(){
	getMovieDetail();
	getTickettingThisMovie();
	infoMore();
	tabListStilCut();
	tabListSynopsis();
	preview();
	search();
	$('#ibxMovieNmSearch').on('change', search);
	 $('#btnSearch').on('click',search);
})
function totalWon(){
	//var o = document.querySelectorAll('li');
}
function infoMore(){
$('.btn').on('click',function(event){
	if($('.btn-more').hasClass("on") == true){
		$('.movie-summary .txt').attr('style', "height:140px");
		$('.btn-more').find('span').text('더보기');
		$('.btn-more').removeClass('on');
	}else{
		$('.movie-summary .txt').attr('style', 'hegith:auto');
		$('.btn-more').find('span').text('닫기');
		$('.btn-more').addClass('on');
	}
})
}

function search(){
		    var key =	 $('#ibxMovieNmSearch').val();
		    var movieList = $('#movieList > li');
		 //   var movies = $('li.no-img');
		    $.each(movieList, function(index, item){
		        var title = $(this).find(".tit-area .tit").text();
		        if( title.includes(key) ){
		            $(this).show();
		        }else{
		            $(this).hide();
		        }
		    });
}

function tabListStilCut(){
	$('.tab-list li:nth-child(2)').on('click',function(event){
		$('.tab-list li').removeClass('on');
		$(event.target).closest('li').addClass('on');
		
		$('.inner-wrap div').removeClass('on');
		$('.pb100').addClass('on');
		
		$.each($('.thumb'),function(index,item){
			var xPosition =  ( index % 4 ) * 280;
			var yPosition = 0;
			var div = $('.thumb').eq(index);
			div.attr('style','transform: translate('+xPosition+'px, 0px)');
			if(index > 3 ){
				for(var i = index-4 ; i >= 0 ; i-=4){
					var imageHeight =  $('.stair-slide-list .thumb').eq(i).find('img').height();
					yPosition += ( imageHeight + 20 );
					div.attr('style','transform: translate('+xPosition+'px, '+yPosition+'px)');
				}
			}
		});
		
	})
}

function tabListSynopsis(){
	$('.tab-list li:nth-child(1)').on('click',function(event){
		$('.tab-list li').closest('li').removeClass('on');
		$(event.target).closest('li').addClass('on');
		
		$('.inner-wrap div').addClass('on');
		$('.tab-list').removeClass('on');
		$('.btn-more').removeClass('on');
		$('.pb100').removeClass('on');
	})
}


/*
 * 시놉시스 슬라이드 FUNCTION 제작 했지만 
function slidSynopsis(){
	$('.btn-more').on('click',function(event){
		if($('.btn-more').hasClass("on") == true){
			console.log('on 있음');
			$('.synopsis').slideUp();
			$('.btn-more').removeClass('on');
		}else{
			console.log('on 없음');
			$('.synopsis').slideDown();
			$('.btn-more').addClass('on');
		}
	
		
	})
}*/

function preview(){
	 $('li[name="li_boxoRankList"] a').on('mouseover', function(event){
     	console.log($(event.target));
 		$(event.target).closest('a').find('.wrap').attr("style","display:block");
 	});
      
      $('li[name="li_boxoRankList"] a').on('mouseout', function(event){
      	console.log($(event.target));
  		$(event.target).closest('a').find('.wrap').attr("style","display:none");
  	}); 
}


function getMovieDetail(){
	$('.movie-list-info').on('click',function(event){
		const movieName = $(event.target).closest('li').find('input[type="hidden"]').val();
		$(location).attr('href', '/movieDetail?movieName='+movieName);
	})
}


function getTickettingThisMovie(){
	$('.btn-util .button').on('click',function(event){
		const movieName = $(event.target).parent().find('button').val();
		$(location).attr('href', '/ticketing?movieName='+movieName);
	})
}

function tabList(){
	$('.inner-wrap').append(
			'<div class="tab-list fixed">'
			+'<ul>'
			+'<li><a href="/getMovieSynopsis?movieName='+$('.movie-detail-cont .title').text()+'"'
			+'  title="시놉시스 탭으로 이동" >시놉시스</a></li>'
			+'<li><a href="/getMovieImages?movieName='+$('.movie-detail-cont .title').text()+'"'
			+'  title="예고편/스틸컷 탭으로 이동" >이미지/스틸컷</a></li>'
			+'</ul>'
			+'</div>'
	);
}


function getSysnopsis(){
	$('.tab-list li:nth-child(1) a').on('click',function(event){
		// event.preventDefault();
		$('.inner-wrap').empty();
		$.ajax({
			url: $(event.target).attr('href')
		}).done(function (result){
			var length = result.length;
			tabList();
			//$('.inner-wrap ul li:nth-child(1)').addClass('on');
			$('.inner-wrap').append(
					'<div class="movie-summary infoContent" id="info">'
					+'<div class="txt">'+result+'</div>'
					+'<div class="btn-more toggle">'
						+'<button type="button" class="btn">'
							+'<span>닫기</span> <i class="iconset ico-btn-more-arr"></i>'
						+'</button>'
					+'</div>'
				+'</div>'
			)
		})
		// event.stopPropagation();
		 return false;
	})
}

function getStilCutList(){
	$('.tab-list li:nth-child(2) a').on('click',function(event){
		$(event.target).closest('li').addClass('on');
		$('.inner-wrap').empty();
		$.ajax({
			url : $(event.target).attr('href')
		}).done(function (result){
				tabList();
				$('.inner-wrap ul li:nth-child(2)').addClass('on');
				$('.inner-wrap').append(
						'<div class="stair-slide" id="tab2">'
						+'<h2 class="tit small">'+$('.title').text()
						+'에 대한 <span class="font-gblue" id="stilCnt">'+length+'</span>개의 스틸컷이 있어요!</h2>'
						+'<div style="height: 1200px;" class="stair-slide-list"></div>'
						+'</div>'
				);
				
				
				$.each(result,function(index,item){
					var xPosition =  ( index % 4 ) * 280;
					
					$('.stair-slide-list').append(
						'<div class="thumb" row="0" col="0" style="display: block; opacity: 1;' 
						+'transform: translate('+xPosition+'px, 0px); transition: transform 0s ease 0s, opacity 0.2s ease-out 0.2s;">'
						+'<a href="#" title="스틸컷 보기">'
						+'<img id="stilCut" src="/img/'+item+'" alt="이미지오류에옹">'
						+'</a></div>'
					);
					
					//console.log("index :  "+index);
					var yPosition = 0;
					if(index > 3 ){
						for(var i = index-4 ; i >= 0 ; i-=4){
							var imageHeight =  $('.stair-slide-list .thumb').eq(i).find('#stilCut').height();
							yPosition += ( imageHeight + 20 );
							var div = $('.thumb').eq(index);
							div.attr('style','transform: translate('+xPosition+'px, '+yPosition+'px)');
						}
					}
				});
		})
		// event.stopPropagation();
		 return false;		
	})
}


