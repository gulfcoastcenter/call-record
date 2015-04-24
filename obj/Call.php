<?php

class Call {
   public function __construct($data) {
      $this->id = $data[0];
      $this->date = $data[1];
      $this->caller = $data[2];
      $this->program = $data[3];
      $this->patient = $data[4];
      $this->cmhcid = $data[5];
      $this->phone = $data[6];
      $this->county = $data[7];
      $this->street = $data[8];
      $this->state = $data[9];
      $this->zip = $data[10];
      $this->referredto = $data[11];
      $this->referredfrom = $data[12];
      $this->request = $data[13];
   }
   public static function newCall($data) { 
      return new Call($data);
   }
}

?>


