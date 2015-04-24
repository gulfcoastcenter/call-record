<?php

class State {
   public function __construct($data) {
      $this->code = $data[0];
      $this->name = $data[1];
   }
   public static function newState($data) { 
      return new State($data);
   }
}

?>

