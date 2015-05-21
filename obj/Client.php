<?php

class Client implements JsonSerializable {
   public function __construct($data) {
      $this->id = $data[0];
      $this->name = $data[1];
   }

   public static function newClient($data) { 
      return new Client($data);
   }

   public function jsonSerialize() {
      return $this;
   }
}

?>
