/*
	Hey there!

	This is the client file for your theme. If you need to do any client-side work in javascript,
	this is where it needs to go.

	You can listen for page changes by writing something like this:

	  $(window).on('action:ajaxify.end', function(data) {
		var	url = data.url;
		console.log('I am now at: ' + url);
	  });
*/

$(document).ready(function () {
  // $(".back-to-top").click(function(){ 
  //   //当点击标签的时候,使用animate在200毫秒的时间内,滚到顶部
  //   $("html,body").animate({scrollTop:"0px"},200);
  // });

  $('body').on('click', '.back-to-top', function() {
    $("html,body").animate({scrollTop:"0px"},200);
  });

  $('body').on('click', "[component='post/change-owner']", function() {
    $('.back-to-top').animate({bottom: '352px'})
  })
})
