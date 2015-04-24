<?php

require_once('State.php');

class StateList implements JsonSerializable {
   public function __construct($data) {
      $this->states = array_map(array('State', 'newState'), $data);
   }

   public function jsonSerialize() { 
      return $this->states;
   }
}

?>

