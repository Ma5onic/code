$(document).ready(function(){
	$('#courseDescription').each(function(){
		var length = $(this).val().length;
		$('.letter-counter').html(250 - length);
		
		$(this).keyup(function(){
			var new_length = $(this).val().length;
			$('.letter-counter').html(250 - new_length);
		});
	});
});