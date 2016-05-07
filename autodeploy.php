<?php

// Copyright (c) Pablo Varela 2016
//
// This file allows automatic deploy
// of a git repo in your server.
// Place the script in your server
// so the webhook can access it

$secret = 'puthereyourverysecretstring'; // CHANGE THIS
$deploy_dir = '/var/www/'; // Root directory
$branch = 'master'; // Branch to deploy
$output = ''; // Buffer to save exec output
$ret = 0; // Exec return value 

// print new msg to log file
function logs($msg) {
    $log_file = 'autodeploy.log';
    $msg = date('Y-m-d H:i:s -> ').$msg."\n";
    file_put_contents ( $log_file , $msg, FILE_APPEND | LOCK_EX );
}

// get parameters
if(! isset($_GET["sat"])) {
    logs('Request with no parameter');
    exit(1);
} else if ( trim($_GET["sat"]) != $secret ) {
    logs('Request with wrong parameter: '.trim($_GET["sat"]));
    exit(1);
}

// all fine
logs('Attempting autodeploy...');

chdir($deploy_dir); // cd dir
exec('git checkout origin/'.$branch.' -- . && git pull origin '.$branch, $output, $ret); // pull

if ($ret != 0) {
	logs('Error:\n'.$output.'\n');
	exit(1);
}

