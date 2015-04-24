<?php

function connect($configpath) {
   $config = json_decode(implode('', file($configpath)));

   $conn = mssql_connect(
      $config->host, 
      $config->user, 
      $config->password
   );


   if (!$conn) { 
      return false;
   }

   if ( !mssql_select_db($config->db, $conn) ) {
      return false;
   }

   return $conn;
}

?>
