<?php

class Match implements JsonSerializable {
   public function __construct($data) {
      $this->call1 = $data[0];
      $this->call2 = $data[1];
   }

   public static function newMatch($data) { 
      return new Match($data);
   }

   public function jsonSerialize() {
      return $this;
   }
}

?>
