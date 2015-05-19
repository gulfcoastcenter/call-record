<?php

function call($config, $id) {
   require_once('db/connect.php');
   require_once('db/execute.php');
   require_once('obj/Call.php');

   $conn = connect($config);
   
   $sql = 'sp_getcall';
   
   $args->call = $id;
   
   return json_encode(Call::newCall( execute($conn, $sql, $args)[0]));
}

?>




