<?php

function states ($config) {
   require_once('db/connect.php');
   require_once('db/execute.php');
   require_once('obj/StateList.php');
   
   $conn = connect($config);
   
   $sql = 'sp_states';
   
   return json_encode(new StateList( execute($conn, $sql)));
}

?>

