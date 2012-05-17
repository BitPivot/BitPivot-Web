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

		<link rel="icon" type="image/x-icon" href="favicon.ico"/>
		<link rel="stylesheet" href="css/page.css"/>
		<noscript><link rel="stylesheet" href="css/noscript.css"/></noscript>

		<script src="js/analytics.js"></script>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
		<script src="js/jquery.scrollTo-1.4.2-min.js"></script>
		<script src="js/bootstrap-modal.min.js"></script>
		<script>
			window.onload = function() {
				$('#wait').hide();
				$('#overlay').fadeOut(500);
			};
		</script>
	</head>

	<body>

		<div id="overlay" class="hidden-phone"></div>
		<div id="wait"></div>



		<div class="container">

			<!-- Header Bar -->
			<div class="row"><div class="span12">
				<header>
					<a class="brand" href="/"><img src="img/headerLogo.png" alt="BitPivot"/></a>
					<span class="hidden-phone"><a href="http://twitter.com/BitPivot">Follow us on Twitter! <img src="img/iconTwitter.png" alt=""/></a></span>
					<span class="visible-phone"><a href="http://twitter.com/BitPivot"><img src="img/iconTwitter.png" alt="Follow us on Twitter"/></a></span>
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
							{html_options name=industry id=industry options=$industryOptions selected=$industrySelected}
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
							{html_options name=budget id=budget options=$budgetOptions selected=$budgetSelected}
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
							{html_options name=found id=found options=$foundOptions selected=$foundSelected}
						</div>
					</div>

					<!-- Form Actions -->
					<div class="form-actions">
						<input type="submit" class="btn btn-primary" value="Submit Request"/>
					</div>

					<script src="js/request.js"></script>
				</form>

			</div></div>



			<!-- Success Modal -->
			<div class="modal fade" id="modalSuccess">
				<div class="modal-header">
					<h1>Success!</h1>
				</div>
				<div class="modal-body content">
					<p>Thank you for your interest in BitPivot.</p>
					<p>We've received your proposal request, and someone will be in touch with you shortly.</p>
				</div>
				<div class="modal-footer">
					<input type="button" class="btn btn-primary" data-dismiss="modal" value="Close"/>
					<script>
						$('#modalSuccess').on('hidden', function() {
							window.location.href = '/';
						});
					</script>
				</div>
			</div>

			<!-- Failed Modal -->
			<div class="modal fade" id="modalFailed">
				<div class="modal-header">
					<h1>Oops!</h1>
				</div>
				<div class="modal-body content">
					<p>Something went wrong.  We're terribly sorry about that.</p>
					<p>If you'd like, you can email us directly at <a href="mailto:request@bitpivot.com">request@bitpivot.com</a>.
				</div>
				<div class="modal-footer">
					<input type="button" class="btn btn-primary" data-dismiss="modal" value="Close"/>
					<script>
						$('#modalFailed').on('hidden', function() {
							window.location.href = '/';
						});
					</script>
				</div>
			</div>

		</div>

	</body>

</html>