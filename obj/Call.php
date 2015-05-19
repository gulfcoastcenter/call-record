<?php

class Call implements JsonSerializable {
   public function __construct($data) {
      $this->id = $data[0];
      $this->date = $data[1];
      $this->caller = $data[2];
      $this->status = $data[3];
      $this->historyid = $data[4];
      $this->program = $data[5];
      $this->patient = $data[6];
      $this->cmhcid = $data[7];
      $this->phone = $data[8];
      $this->county = $data[9];
      $this->street = $data[10];
      $this->state = $data[11];
      $this->zip = $data[12];
      $this->referredto = $data[13];
      $this->referredfrom = $data[14];
      $this->request = $data[15];
   }

   public static function newCall($data) { 
      return new Call($data);
   }

   public function jsonSerialize() { 
      return $this;
   }
}

?>


