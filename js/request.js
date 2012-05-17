function getError(control) {
	try {
		var value = $.trim($(control).val().toLowerCase());
		switch (control) {
			case '#name':
				if (value == '') return 'Please enter your name.';
				else return null;

			case '#email':
				if (value == '') return 'Please enter your email address.';
				else return null;

			case '#emailConfirm':
				var email = $.trim($('#email').val().toLowerCase());
				if (value == '') return 'Please confirm your email address.';
				else if ((value != email)) return 'Email addresses do not match.';
				else return null;

			case '#company':
				if (value == '') return 'Please enter your company name.';
				else return null;
		}
	}
	catch (ex) {
		return null;
	}
}

function validate(control) {
	var error = getError(control);
	if (error) {
		$(control).parent().parent().removeClass('success').addClass('error');
		$(control).siblings('.help-inline').html(error);
	}
	else {
		$(control).parent().parent().removeClass('error').addClass('success');
		$(control).siblings('.help-inline').html('');
	}
}

// Name
$('#name').change(function() { validate('#name'); });
$('#email').change(function() { validate('#email'); $('#emailConfirm').change() });
$('#emailConfirm').change(function() { validate('#emailConfirm'); });
$('#company').change(function() { validate('#company'); });

// Form handler
$('#request').submit(function() {
	// Validate fields
	var isValid = true;
	var firstError = null
	$(this).find('input[type=text], select, textarea').each(function() {
		$(this).change();
		var error = getError('#' + $(this).attr('id'));
		if (error) {
			isValid = false;
			if (!firstError) firstError = $(this).attr('id');
		}
	})

	// Do post
	if (isValid) {
		$('#wait').fadeIn(500, function() {
			$.ajax({
				url: 'request?type=async',
				async: false,
				type: 'POST',
				data: {
					name: $('#name').val(),
					email: $('#email').val(),
					emailConfirm: $('#emailConfirm').val(),
					number: $('#number').val(),
					company: $('#company').val(),
					industry: $('#industry').val(),
					timeframe: $('#timeframe').val(),
					budget: $('#budget').val(),
					companyInfo: $('#companyInfo').val(),
					projectInfo: $('#projectInfo').val(),
					found: $('#found').val(),
				},
				error: function() {
					$('#modalFailed').modal();
				},
				success: function(data) {
					console.log(data);
					if (data == 'OK') $('#modalSuccess').modal();
					else $('#modalFailed').modal();
				}
			});
		});
	}
	else {
		$.scrollTo('#' + firstError);
	}

	// Cancel postback request
	return false;
});