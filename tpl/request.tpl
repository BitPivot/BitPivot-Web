<!DOCTYPE html>
<html lang="en">

	<head>
		<title>BitPivot - Proposal Request</title>
		<meta charset="utf-8"/>
		<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
		<meta name="description" content="BitPivot"/>
		<meta name="keywords" content="Software Developer, Software Consultant, Database Integration, Web Development, Application Development"/>
		<meta name="author" content="Matthew McMillion"/>

		<!--[if lt IE 9]>
			<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
			<link rel="stylesheet" href="css/noscript.css"/>
		<![endif]-->
		<!--[if IE]><link rel="stylesheet" href="css/ie.css"/><![endif]-->

		<script>localStorage.clear()</script>
		<link rel="icon" type="image/x-icon" href="favicon.ico"/>
		<link rel="stylesheet/less" href="css/page.less"/>
		<script src="js/less-1.3.0.min.js"></script>
		<noscript>
			<link rel="stylesheet" href="css/page.css"/>
			<link rel="stylesheet" href="css/noscript.css"/>
		</noscript>

		<script src="js/analytics.js"></script>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
	</head>

	<body>

		<div class="container">

			<!-- Header Bar -->
			<div class="row"><div class="span12">
				<header>
					<a class="brand" href="/"><img src="img/headerLogo.png" alt="BitPivot"/></a>
					<span class="hidden-phone"><a href="http://twitter.com/BitPivot">Follow us on Twitter! <img src="img/iconTwitter.png"/></a></span>
					<span class="visible-phone"><a href="http://twitter.com/BitPivot"><img src="img/iconTwitter.png"/></a></span>
				</header>
			</div></div>

			<!-- Propsal Request Form -->
			<div class="row"><div class="span12">

				<h2>Request for Proposal</h2>

				<form id="request" class="form-horizontal" method="post" action="request?type=sync">

					<!-- Name -->
					<div class="control-group {$className}">
						<label class="control-label" for="name">Name</label>
						<div class="controls">
							<input type="text" id="name" name="name" value="{$name}"/>
							<span id="errorName" class="help-inline">{$errorName}</span>
						</div>
					</div>

					<!-- Email -->
					<div class="control-group {$classEmail}">
						<label class="control-label" for="email">Email</label>
						<div class="controls">
							<input type="text" id="email" name="email" value="{$email}"/>
							<span id="errorEmail" class="help-inline">{$errorEmail}</span>
						</div>
					</div>

					<!-- Email Confirm -->
					<div class="control-group {$classEmailConfirm}">
						<label class="control-label" for="emailConfirm">Confirm Email</label>
						<div class="controls">
							<input type="text" id="emailConfirm" name="emailConfirm" value="{$emailConfirm}"/>
							<span id="errorEmailConfirm" class="help-inline">{$errorEmailConfirm}</span>
						</div>
					</div>

					<!-- Contact Number -->
					<div class="control-group">
						<label class="control-label" for="number">Contact Number</label>
						<div class="controls">
							<input type="text" id="number" name="number" value="{$number}"/>
							<p class="help-block">If you would prefer to be contacted via email, leave this field blank.</p>
						</div>
					</div>

					<!-- Company Name -->
					<div class="control-group {$classCompany}">
						<label class="control-label" for="company">Company Name</label>
						<div class="controls">
							<input type="text" id="company" name="company" value="{$company}"/>
							<span id="errorCompanyName" class="help-inline">{$errorCompany}</span>
						</div>
					</div>

					<!-- Company Industry -->
					<div class="control-group">
						<label class="control-label" for="industry">Industry</label>
						<div class="controls">
							{html_options name=industry options=$industryOptions selected=$industrySelected}
						</div>
					</div>

					<!-- Project Timeframe -->
					<div class="control-group">
						<label class="control-label" for="timeframe">Project Timeframe</label>
						<div class="controls">
							<input type="text" id="timeframe" name="timeframe" value="{$timeframe}"/>
						</div>
					</div>

					<!-- Project Budget -->
					<div class="control-group">
						<label class="control-label" for="budget">Project Budget</label>
						<div class="controls">
							{html_options name=budget options=$budgetOptions selected=$budgetSelected}
						</div>
					</div>

					<!-- Company Info -->
					<label>Tell us about your company</label>
					<textarea id="companyInfo" name="companyInfo" class="span4" rows="4">{$companyInfo}</textarea>
					<br/>
					<br/>

					<!-- Project Info -->
					<label>Tell us about your project</label>
					<textarea id="projectInfo" name="projectInfo" class="span4" rows="4">{$projectInfo}</textarea>
					<br/>
					<br/>

					<!-- How Found -->
					<div class="control-group">
						<label class="control-label" for="found">How did you find us?</label>
						<div class="controls">
							{html_options name=found options=$foundOptions selected=$foundSelected}
						</div>
					</div>

					<!-- Form Actions -->
					<div class="form-actions">
						<input type="submit" class="btn btn-primary" value="Submit Request"/>
					</div>

					<script>
						// Name
						$('#name').change(function() {
							if ($.trim($(this).val()) == '') {
								$(this).parent().parent().removeClass('warning').removeClass('success').addClass('error');
								$(this).siblings('.help-inline').html('Please enter an email address.');
							}
							else {
								$(this).parent().parent().removeClass('warning').removeClass('error').addClass('success');
								$(this).siblings('.help-inline').html('');
							}
						});

						// Email
						$('#email').change(function() {
							if ($.trim($(this).val()) == '') {

							}
						});
					</script>
				</form>

		</div>

	</body>

</html>