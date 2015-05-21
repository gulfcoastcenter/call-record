<?php

function addmatch($config, $program, $postdata) {
   require_once('db/connect.php');
   require_once('db/execute.php');
   require_once('obj/Match.php');

   $conn = connect($config);

   $sql = 'sp_makematch';

   $args->call1 = $postdata['callid'];
   $args->call2 = $postdata['matchid'];

   return json_encode(Match::newMatch(execute($conn, $sql, $args)[0]));
}

?>
