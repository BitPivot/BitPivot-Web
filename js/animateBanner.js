function animateBanner() {
	if ($(window).width() > 767) { // Check for phone / tablet
		$('#logo .hi').css('opacity', 0);
		$('#logo .hi').show();
		$('#logo .hi').animate({
			top: '-=50',
			opacity: 1,
		}, 1500, 'easeInOutQuad', function() {
			$('#overlay').fadeOut(1500);

			$('#logo .dark').show();
			$('#logo .dark').rotate({
				angle: 0,
				animateTo: -11.5,
			});

			$('#logo .light').show();
			$('#logo .light').rotate({
				angle: 0,
				animateTo: -22,
			});

			var nextIndex = 0;
			var words = ['faster.', 'smarter.', 'more agile.', 'stronger.', 'better.', 'more powerful.'];
			setInterval(function() {
				$('#rotator').fadeOut(function() {
					$('#rotator').html(words[++nextIndex % words.length]);
					$('#rotator').fadeIn();
				});

			}, 2000);
		});

		$('#logo .shadow').fadeIn(1500);
	}
}



window.onload = function() {
	if (window.location.hash == "#noload") $('#overlay').hide(); // DEVELOPMENT
	animateBanner();
};