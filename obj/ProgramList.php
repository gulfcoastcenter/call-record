<?php

require_once('Program.php');

class ProgramList implements JsonSerializable {
   public function __construct($data) {
      $this->programs = array_map(array('Program', 'newProgram'), $data);
   }

   public function jsonSerialize() { 
      return $this->programs;
   }
}

?>


