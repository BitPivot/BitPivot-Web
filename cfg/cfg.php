<?php

	// Disable all errors
	//error_reporting(0);



	// Smarty
	require_once( 'lib/smarty/Smarty.class.php' );
	$smarty = new Smarty();

	$smarty->setTemplateDir( 'tpl' );
	$smarty->setCompileDir( 'lib/smarty/templates_c' );
	$smarty->setConfigDir( 'lib/smarty/configs' );
	$smarty->setCacheDir( 'lib/smarty/cache' );



	// Class Autoloading
		function classLoader( $className ) {
		require_once 'lib/classes/' . $className . '.class.php';
	}

	spl_autoload_register( 'classLoader' );

?>