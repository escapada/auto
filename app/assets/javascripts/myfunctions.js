$('.prw_photo').click(function() {
	var src = $(this).prop("src");
	$(big_image).prop("src", src);
	$('.mating').removeClass("mating");
	$(this).addClass("mating");
});

// var car_ids = Array.new;
// var model_ids