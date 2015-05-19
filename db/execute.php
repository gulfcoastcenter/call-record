<?php 

function execute ($connection, $proc, $args) {

   $sp = mssql_init($proc);

   if (is_object($args)) { 
      foreach ($args as $key=>$val) {
         $o = mssql_bind($sp, '@'.$key, $args->$key, SQLVARCHAR);
      }
   }
   $out = [];
   $res = mssql_execute($sp);
   $row = mssql_fetch_row($res);
   while($row) {
      array_push($out, $row);
      $row = mssql_fetch_row($res);
   }
   return $out;
}

?>
