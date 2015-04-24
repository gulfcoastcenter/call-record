<?php

class County {
   public function __construct($data) {
      $this->code = $data[0];
      $this->name = $data[1];
   }
   public static function newCounty($data) { 
      return new County($data);
   }
}

?>
