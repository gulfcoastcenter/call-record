<?php

function calls($config, $program) {
   require_once('db/connect.php');
   require_once('db/execute.php');
   require_once('obj/CallList.php');
   
   $conn = connect($config);
   
   $sql = 'sp_calls';
   
   $args->program = $program ? $program : null;
   
   return json_encode(new CallList( execute($conn, $sql, $args)));
}

?>



