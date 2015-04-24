<?php

function programs($config) {
   require_once('db/connect.php');
   require_once('db/execute.php');
   require_once('obj/ProgramList.php');
   
   $conn = connect($config);
   
   $sql = 'sp_programs';
   
   return json_encode(new ProgramList( execute($conn, $sql)));
}

?>


