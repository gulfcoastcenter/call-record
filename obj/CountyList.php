<?php

require_once('County.php');

class CountyList implements JsonSerializable {
   public function __construct($data) {
      $this->counties = array_map(array('County', 'newCounty'), $data);
   }

   public function jsonSerialize() { 
      return $this->counties;
   }
}

?>
