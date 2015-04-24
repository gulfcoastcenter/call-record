<?php

$root = array_pop(explode('/', getcwd()));
$url = $_SERVER['REQUEST_URI'];
$pattern = '/^.*'.$root.'\//';
$path = explode('/', preg_replace($pattern, '', $url));

set_include_path( dirname(__FILE__) );

if (!$path[0]) {
   echo 'index';
   return;
}
if ($path[0] == 'api') {
   $file = 'app/'.$path[1].'.php';
   if (is_file($file)) {
      require_once($file);
      if (function_exists($path[1])) {
         echo $path[1]('./config.ignore', $path[2]);
         return;
      }
   }
}

echo 'file not found';


?>
