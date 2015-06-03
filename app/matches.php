<?php

function matches($config, $program) {
   require_once('db/connect.php');
   require_once('db/execute.php');
   require_once('obj/MatchList.php');

   $conn = connect($config);

   $sql = 'sp_getmatches';

   return json_encode(new MatchList(execute($conn, $sql, $args)));
}

?>
