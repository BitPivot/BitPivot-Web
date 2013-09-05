//= require jquery
//= require jquery-placeholder
//= require maskedinput

jQuery(function($){
   $("#inquiry_phone").mask("(999) 999-9999");
});

$(function(){
	$('input, textarea').placeholder();
	$('.contact-button').on('click', function(e) {
		$("html, body").animate(
			{ scrollTop: $('.contact-us').offset().top },
			1000
		);
	});
});