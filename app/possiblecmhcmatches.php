<?php 

function possiblecmhcmatches($config, $program, $data) {
   require_once('db/connect.php');
   require_once('db/execute.php');
   require_once('obj/ClientList.php');

   $conn = connect($config);

   $sql = 'sp_matchcmhc';

   $args->patient = $data['patient'];

   return json_encode(new ClientList(execute($conn, $sql, $args)));
}

?>
