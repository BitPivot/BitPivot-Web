<?php

	class requestForm {
		public $name = '';
		public $email = '';
		public $emailConfirm = '';
		public $number = '';
		public $company = '';
		public $industry = '';
		public $timeframe = '';
		public $budget = '';
		public $companyInfo = '';
		public $projectInfo = '';
		public $found = '';

		public $className = 'required';
		public $classEmail = 'required';
		public $classEmailConfirm = 'required';
		public $classNumber = '';
		public $classCompany = 'required';
		public $classIndustry = '';
		public $classTimeframe = '';
		public $classBudget = '';
		public $classCompanyInfo = '';
		public $classProjectInfo = '';
		public $classFound = '';

		public $errorName = 'Required';
		public $errorEmail = 'Required';
		public $errorEmailConfirm = 'Required';
		public $errorCompany = 'Required';

		public $isValid = false;



		// Validates input
		public function validate() {
			$this->isValid = true;

			// Name
			if ($this->name == '') {
				$this->isValid = false;
				$this->errorName = 'Please enter a name.';
				$this->className = 'error';
			}
			else {
				$this->className = 'success';
			}

			// Email
			if ($this->email == '') {
				$this->isValid = false;
				$this->errorEmail = 'Please enter an email address.';
				$this->classEmail = 'error';
			}
			else {
				$this->classEmail = 'success';
			}

			// Email confirmation
			if ($this->emailConfirm == '') {
				$this->isValid = false;
				$this->errorEmailConfirm = 'Please confirm your email address.';
				$this->classEmailConfirm = 'error';
			}
			else if ($this->emailConfirm != $this->email) {
				$this->isValid = false;
				$this->errorEmailConfirm = 'Please double-check your email address.';
				$this->classEmailConfirm = 'error';
			}
			else {
				$this->classEmailConfirm = 'success';
			}

			// Company name
			if ($this->company == '') {
				$this->isValid = false;
				$this->errorCompany = 'Please enter a company name.';
				$this->classCompany = 'error';
			}
			else {
				$this->classCompany = 'success';
			}
		}
	}

?>