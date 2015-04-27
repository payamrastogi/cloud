// JavaScript Document


$(document).ready(function() {
    $('.box').css({
        "position": "fixed", "bottom": "0"  
        })
});
$(window).load(function() {
			$('.box').css({
         "position": "relative", "transition": "0.5s ease"
        })
});