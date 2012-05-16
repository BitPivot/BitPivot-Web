<?php /* Smarty version Smarty-3.1.7, created on 2012-05-16 23:51:57
         compiled from "tpl\request.tpl" */ ?>
<?php /*%%SmartyHeaderCode:119524fb2d9c57a6080-10683754%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    'f5ab49058e85613e8155c47b17ea93a8e9a24144' => 
    array (
      0 => 'tpl\\request.tpl',
      1 => 1337205113,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '119524fb2d9c57a6080-10683754',
  'function' => 
  array (
  ),
  'version' => 'Smarty-3.1.7',
  'unifunc' => 'content_4fb2d9c57a6b5',
  'variables' => 
  array (
    'className' => 0,
    'name' => 0,
    'errorName' => 0,
    'classEmail' => 0,
    'email' => 0,
    'errorEmail' => 0,
    'classEmailConfirm' => 0,
    'emailConfirm' => 0,
    'errorEmailConfirm' => 0,
    'number' => 0,
    'classCompany' => 0,
    'company' => 0,
    'errorCompany' => 0,
    'industryOptions' => 0,
    'industrySelected' => 0,
    'timeframe' => 0,
    'budgetOptions' => 0,
    'budgetSelected' => 0,
    'companyInfo' => 0,
    'projectInfo' => 0,
    'foundOptions' => 0,
    'foundSelected' => 0,
  ),
  'has_nocache_code' => false,
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_4fb2d9c57a6b5')) {function content_4fb2d9c57a6b5($_smarty_tpl) {?><?php if (!is_callable('smarty_function_html_options')) include 'C:\\Development\\BitPivot\\BitPivot-Web\\lib\\smarty\\plugins\\function.html_options.php';
?><!DOCTYPE html>
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
					<div class="control-group <?php echo $_smarty_tpl->tpl_vars['className']->value;?>
">
						<label class="control-label" for="name">Name</label>
						<div class="controls">
							<input type="text" id="name" name="name" value="<?php echo $_smarty_tpl->tpl_vars['name']->value;?>
"/>
							<span id="errorName" class="help-inline"><?php echo $_smarty_tpl->tpl_vars['errorName']->value;?>
</span>
						</div>
					</div>

					<!-- Email -->
					<div class="control-group <?php echo $_smarty_tpl->tpl_vars['classEmail']->value;?>
">
						<label class="control-label" for="email">Email</label>
						<div class="controls">
							<input type="text" id="email" name="email" value="<?php echo $_smarty_tpl->tpl_vars['email']->value;?>
"/>
							<span id="errorEmail" class="help-inline"><?php echo $_smarty_tpl->tpl_vars['errorEmail']->value;?>
</span>
						</div>
					</div>

					<!-- Email Confirm -->
					<div class="control-group <?php echo $_smarty_tpl->tpl_vars['classEmailConfirm']->value;?>
">
						<label class="control-label" for="emailConfirm">Confirm Email</label>
						<div class="controls">
							<input type="text" id="emailConfirm" name="emailConfirm" value="<?php echo $_smarty_tpl->tpl_vars['emailConfirm']->value;?>
"/>
							<span id="errorEmailConfirm" class="help-inline"><?php echo $_smarty_tpl->tpl_vars['errorEmailConfirm']->value;?>
</span>
						</div>
					</div>

					<!-- Contact Number -->
					<div class="control-group">
						<label class="control-label" for="number">Contact Number</label>
						<div class="controls">
							<input type="text" id="number" name="number" value="<?php echo $_smarty_tpl->tpl_vars['number']->value;?>
"/>
							<p class="help-block">If you would prefer to be contacted via email, leave this field blank.</p>
						</div>
					</div>

					<!-- Company Name -->
					<div class="control-group <?php echo $_smarty_tpl->tpl_vars['classCompany']->value;?>
">
						<label class="control-label" for="company">Company Name</label>
						<div class="controls">
							<input type="text" id="company" name="company" value="<?php echo $_smarty_tpl->tpl_vars['company']->value;?>
"/>
							<span id="errorCompanyName" class="help-inline"><?php echo $_smarty_tpl->tpl_vars['errorCompany']->value;?>
</span>
						</div>
					</div>

					<!-- Company Industry -->
					<div class="control-group">
						<label class="control-label" for="industry">Industry</label>
						<div class="controls">
							<?php echo smarty_function_html_options(array('name'=>'industry','options'=>$_smarty_tpl->tpl_vars['industryOptions']->value,'selected'=>$_smarty_tpl->tpl_vars['industrySelected']->value),$_smarty_tpl);?>

						</div>
					</div>

					<!-- Project Timeframe -->
					<div class="control-group">
						<label class="control-label" for="timeframe">Project Timeframe</label>
						<div class="controls">
							<input type="text" id="timeframe" name="timeframe" value="<?php echo $_smarty_tpl->tpl_vars['timeframe']->value;?>
"/>
						</div>
					</div>

					<!-- Project Budget -->
					<div class="control-group">
						<label class="control-label" for="budget">Project Budget</label>
						<div class="controls">
							<?php echo smarty_function_html_options(array('name'=>'budget','options'=>$_smarty_tpl->tpl_vars['budgetOptions']->value,'selected'=>$_smarty_tpl->tpl_vars['budgetSelected']->value),$_smarty_tpl);?>

						</div>
					</div>

					<!-- Company Info -->
					<label>Tell us about your company</label>
					<textarea id="companyInfo" name="companyInfo" class="span4" rows="4"><?php echo $_smarty_tpl->tpl_vars['companyInfo']->value;?>
</textarea>
					<br/>
					<br/>

					<!-- Project Info -->
					<label>Tell us about your project</label>
					<textarea id="projectInfo" name="projectInfo" class="span4" rows="4"><?php echo $_smarty_tpl->tpl_vars['projectInfo']->value;?>
</textarea>
					<br/>
					<br/>

					<!-- How Found -->
					<div class="control-group">
						<label class="control-label" for="found">How did you find us?</label>
						<div class="controls">
							<?php echo smarty_function_html_options(array('name'=>'found','options'=>$_smarty_tpl->tpl_vars['foundOptions']->value,'selected'=>$_smarty_tpl->tpl_vars['foundSelected']->value),$_smarty_tpl);?>

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

</html><?php }} ?>