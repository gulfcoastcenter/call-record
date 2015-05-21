<?php

function possiblematches($config, $program, $data) {
   require_once('db/connect.php');
   require_once('db/execute.php');
   require_once('obj/CallList.php');

   $conn = connect($config);

   $sql = 'sp_matchcall';

   $args->caller = $data['caller'];
   $args->patient = $data['patient'];
   $args->phone = $data['phone'];
   $args->excludeid = $data['excludeid'];
   $args->crossprogram = $data['crossprogram'];

   return json_encode(new CallList(execute($conn, $sql, $args)));
}
?>
