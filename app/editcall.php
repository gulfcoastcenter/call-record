<?php

function editcall($config, $callid, $postdata) {
   require_once('db/connect.php');
   require_once('db/execute.php');
   require_once('obj/Call.php');
   require_once('obj/CallList.php');

   $conn = connect($config);

   $sql = 'sp_updatecall';
   
   //$args->status = 0;
   $args->callid = $postdata['id'];
   $args->programid = $postdata['program'];
   //$args->historyid = $callid ? $callid : null;
   $args->calldate = $postdata['date'];
   $args->callername = $postdata['caller'];
   $args->patientname = $postdata['patient'];
   $args->cmhcid = $postdata['CmhcId'];
   $args->phonenumber = $postdata['phone'];
   $args->County = $postdata['county'];
   $args->street = $postdata['street'];
   $args->state = $postdata['state'];
   $args->zip = $postdata['zip'];
   $args->referredto = $postdata['referredto'];
   $args->referredfrom = $postdata['referredfrom'];
   $args->request = $postdata['request'];
   
   return json_encode(Call::newCall(execute($conn, $sql, $args)[0]));
}

?>



