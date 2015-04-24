<?php

function counties($config) {
   require_once('db/connect.php');
   require_once('db/execute.php');
   require_once('obj/CountyList.php');
   
   $conn = connect($config);
   
   $sql = 'sp_counties';
   
   return json_encode(new CountyList( execute($conn, $sql)));
}

?>


