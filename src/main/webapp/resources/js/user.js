$(function( ){
	 cancellation();
 })
 function cancellation(){
	 $('.btn-group button').on('click',function (event) { 
		 var target = $(event.target);
		 var bookingNumber = target.closest('.round').find('table tr:first-child em').text();
		 console.log(bookingNumber);
		 $.ajax({ 
             url : '/cancellation',
             data : {
            	 bookingCode : bookingNumber
                }
// ,
// success : function(result) { // 이 자리에 remove 넣어주자
// $(event.target).closest('li').remove();
// /* $(location).attr('href','/myPage');*/
// }
          }).done(function(result){
        	  $(location).attr('href','/myPage');
        	   //$(event.target).closest('li').remove();
        	  
          })
	 }) 
 }


