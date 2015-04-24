<?php

class Program {
   public function __construct($data) {
      $this->code = $data[0];
      $this->ru = $data[1];
      $this->name = $data[2];
   }
   public static function newProgram($data) { 
      return new Program($data);
   }
}

?>


