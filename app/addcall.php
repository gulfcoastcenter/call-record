<?php

function addcall($config, $program, $postdata) {
   require_once('db/connect.php');
   require_once('db/execute.php');
   require_once('obj/Call.php');
   require_once('obj/CallList.php');

   $conn = connect($config);

   $sql = 'sp_addcall';
   
   //$args->status = 0;
   $args->historypreviousid = null;
   $args->historyNextId = null;
   $args->programid = $program ? $program : null;
   $args->calldate = $postdata['date'];
   $args->callername = $postdata['caller'];
   $args->patientname = $postdata['patient'];
   $args->cmhcid = $postdata['cmhcid'];
   $args->phonenumber = $postdata['phone'];
   $args->County = $postdata['county'];
   $args->City = $postdata['city'];
   $args->street = $postdata['street'];
   $args->state = $postdata['state'];
   $args->zip = $postdata['zip'];
   $args->referredto = $postdata['referredto'];
   $args->referredfrom = $postdata['referredfrom'];
   $args->request = $postdata['request'];
   $args->userid = $postdata['userid'];
   
   return json_encode(Call::newCall(execute($conn, $sql, $args)[0]));
}

?>



