<?php

require_once('Match.php');

class MatchList implements JsonSerializable {
   public function __construct($data) {
      if (empty($data)) {
         $this->matches = [];
         return;
      }
      $this->calls = array_map(array('Match', 'newMatch'), $data);
   }

   public function jsonSerialize() {
      return $this->calls;
   }
}

?>
