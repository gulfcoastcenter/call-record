<?php

function login($user, $pass) { 
   $url = "http://helpdesk.gcmhmr.com/loginShare/ldap.php";
   $data = array('username' => $user, 'password' => $pass);

   $options = array(
      'http' => array(
         'header' => "Content-Type: application/x-www-form-urlencoded\r\n",
         'method' => 'POST',
         'content' => http_build_query($data)
      )
   );
   $context = stream_context_create($options);
   return file_get_contents($url, false, $context);
}

?>
