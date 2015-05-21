<?php

class Client implements JsonSerializable {
   public function __construct($data) {
      $this->id = $data[0];
      $this->name = $data[1];
      $this->dob = $data[2];
      $this->street = $data[3];
      $this->county = substr($data[4], 0, 4);
      if ($this->county == 'OTHE') { 
         $this->county = 'OTHER';
      }
      $this->city = $data[5];
      $this->state = $data[6];
      $this->zip = $data[7];
      $this->phone = preg_replace("/[^0-9]/", "", $data[8]);
   }

   public static function newClient($data) { 
      return new Client($data);
   }

   public function jsonSerialize() {
      return $this;
   }
}

?>
