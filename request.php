<?php

	require_once('cfg/all.php');



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
		switch ($_GET['type']) {
			case 'sync':
				$form->validate();
				if ($form->isValid) {
					sendRequest($form);
				}
				else {
					render($smarty, $form); // Render with errors
				}
				break;

			case 'async':
				echo "async";
				break;
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



	function sendRequest($form) {
		var_dump($form);
	}

?>