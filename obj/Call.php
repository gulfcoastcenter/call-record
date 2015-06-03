<?php

class Call implements JsonSerializable {
   public function __construct($data) {
      $this->id = $data[0];
      $this->date = $data[1];
      $this->caller = $data[2];
      $this->status = $data[3];
      $this->historypreviousid = $data[4];
      $this->historynextid = $data[5];
      $this->program = $data[6];
      $this->patient = $data[7];
      $this->cmhcid = $data[8];
      $this->phone = $data[9];
      $this->county = $data[10];
      $this->city = $data[11];
      $this->street = $data[12];
      $this->state = $data[13];
      $this->zip = $data[14];
      $this->referredto = $data[15];
      $this->referredfrom = $data[16];
      $this->request = $data[17];
      $this->createdate = $data[18];
   }

   public static function newCall($data) { 
      return new Call($data);
   }

   public function jsonSerialize() { 
      return $this;
   }
}

?>


