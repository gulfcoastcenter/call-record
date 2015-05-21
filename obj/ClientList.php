<?php

require_once('Client.php');

class ClientList implements JsonSerializable {
   public function __construct($data) { 
      if (empty($data)) {
         $this->clients = [];
         return;
      }
      $this->clients = array_map(array('Client', 'newClient'), $data);
   }

   public function jsonSerialize() {
      return $this->clients;
   }
}

?>
