<?php

require_once('Call.php');

class CallList implements JsonSerializable {
   public function __construct($data) {
      if (empty($data)) { 
         $this->calls = [];
         return;
      }
      $this->calls = array_map(array('Call', 'newCall'), $data);
   }

   public function jsonSerialize() { 
      return $this->calls;
   }
}

?>



