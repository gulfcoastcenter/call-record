<?php

function getuser($results) {
   $xml = new SimpleXMLElement($results);
   //return $user;
   //var_dump($user);
   if ((string)$xml->result == '0') {
      return null;
   }
   $user->name = (string)$xml->user->fullname;
   $user->id = (string)$xml->user->designation;
   $user->email = (string)$xml->user->email;
   return $user;
}

?>
