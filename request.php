<?php

	require_once('cfg/cfg.php');



	// Sanitize input
	$form = new requestForm();
	$form->name = isset($_POST['name']) ? htmlspecialchars(trim($_POST['name'])) : '';
	$form->email = isset($_POST['email']) ? htmlspecialchars(trim($_POST['email'])) : '';
	$form->emailConfirm = isset($_POST['emailConfirm']) ? htmlspecialchars(trim($_POST['emailConfirm'])) : '';
	$form->number = isset($_POST['number']) ? htmlspecialchars(trim($_POST['number'])) : '';
	$form->company = isset($_POST['company']) ? htmlspecialchars(trim($_POST['company'])) : '';
	$form->industry = isset($_POST['industry']) ? htmlspecialchars(trim($_POST['industry'])) : '';
	$form->timeframe = isset($_POST['timeframe']) ? htmlspecialchars(trim($_POST['timeframe'])) : '';
	$form->budget = isset($_POST['budget']) ? htmlspecialchars(trim($_POST['budget'])) : '';
	$form->companyInfo = isset($_POST['companyInfo']) ? htmlspecialchars(trim($_POST['companyInfo'])) : '';
	$form->projectInfo = isset($_POST['projectInfo']) ? htmlspecialchars(trim($_POST['projectInfo'])) : '';
	$form->found = isset($_POST['found']) ? htmlspecialchars(trim($_POST['found'])) : '';



	// Check request type
	if (isset($_GET['type'])) {
		// Validate form
		$form->validate();
		if (!$form->isValid) {
			render($smarty, $form);
		}
		else {
			switch ($_GET['type']) {
				case 'sync':
					if (sendRequest($form)) {
						sendResponse($form);
						$smarty->display('requestSuccess.tpl');
					}
					else $smarty->display('requestFailed.tpl');
					break;

				case 'async':
					if (sendRequest($form)) {
						sendResponse($form);
						echo 'OK';
					}
					else echo 'ERROR';
					break;
			}
		}
	}
	else {
		render($smarty, $form);
	}



	// Display empty request form
	function render(&$smarty, &$form) {
		// Form fields
		$smarty->assign('name', $form->name);
		$smarty->assign('email', $form->email);
		$smarty->assign('emailConfirm', $form->emailConfirm);
		$smarty->assign('number', $form->number);
		$smarty->assign('company', $form->company);
		$smarty->assign('industrySelected', $form->industry);
		$smarty->assign('timeframe', $form->timeframe);
		$smarty->assign('budgetSelected', $form->budget);
		$smarty->assign('companyInfo', $form->companyInfo);
		$smarty->assign('projectInfo', $form->projectInfo);
		$smarty->assign('foundSelected', $form->found);

		// Errors
		$smarty->assign('errorName', $form->errorName);
		$smarty->assign('className', $form->className);

		$smarty->assign('errorEmail', $form->errorEmail);
		$smarty->assign('classEmail', $form->classEmail);

		$smarty->assign('errorEmailConfirm', $form->errorEmailConfirm);
		$smarty->assign('classEmailConfirm', $form->classEmailConfirm);

		$smarty->assign('errorCompany', $form->errorCompany);
		$smarty->assign('classCompany', $form->classCompany);

		// Dropdowns
		$smarty->assign('industryOptions', array(
			'Other' => 'Other',
		));

		$smarty->assign('budgetOptions', array(
			'Undecided' => 'Undecided',
		));

		$smarty->assign('foundOptions', array(
			'Other' => 'Other',
		));

		// Render
		$smarty->display('request.tpl');
	}



	// Sends the proposal request
	function sendRequest(&$form) {
		$date = date('m/d/Y');
		$subject = "New Proposal Request ({$date})";

		$message  = "New Proposal Request ({$date}):\r\n";
		$message .= "\r\n";
		$message .= "From: {$form->name} ({$form->email}) at {$form->company}\r\n";
		$message .= "\r\n";
		if ($form->number) $message .= "Contact Number: {$form->number}\r\n";
		if ($form->industry) $message .= "Company Industry: {$form->industry}\r\n";
		if ($form->timeframe) $message .= "Project Timeframe: {$form->timeframe}\r\n";
		if ($form->budget) $message .= "Project Budget: {$form->budget}\r\n";
		$message .= "\r\n";
		if ($form->companyInfo) $message .= "Company Info: {$form->companyInfo}\r\n";
		if ($form->projectInfo) $message .= "Project Info: {$form->projectInfo}\r\n";
		$message .= "\r\n";
		if ($form->found) $message .= "How they Found BitPivot: {$form->found}\r\n";

		return sendMail('request@bitpivot.com', $subject, $message);
	}

	// Sends a response to the user
	function sendResponse(&$form) {
		$subject = 'Thank you for you inquiry into BitPivot!';
		$message  = "Dear {$form->name},\r\n";
		$message .= "\r\n";
		$message .= "Thank you for showing your interest in BitPivot.  This message is to confirm that we've received your bid request.  You can expect a member of our team to contact you shortly.\r\n";
		$message .= "\r\n";
		$message .= "It is our primary focus to aid your company's web and software needs as best we can.  If you have any further questions, please contact info@bitpivot.com.\r\n";
		$message .= "\r\n";
		$message .= "Sincerely,\r\n";
		$message .= "The BitPivot Team\r\n";

		return sendMail($form->email, $subject, $message);
	}

	// Sends a single email
	function sendMail($to, $subject, $message) {
		$headers = '';
		if ($to == 'request@bitpivot.com') $headers .= 'To: BitPivot Request <request@bitpivot.com>' . "\r\n";
		else $headers .= "To: {$to}\r\n";

		$headers .= 'From: BitPivot Mailer <mailer@bitpivot.com>' ."\r\n";
		$headers .= 'Reply-To: mailer@bitpivot.com' . "\r\n";
		$headers .= 'X-Mailer: BitPivot Mailer';

		if (mail($to, $subject, $message, $headers)) return true;
		else return false;
	}

?>