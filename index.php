<?php

session_start();

require_once('app/login.php');
require_once('app/getuser.php');

$root = array_pop(explode('/', getcwd()));
$url = $_SERVER['REQUEST_URI'];
$method = $_SERVER['REQUEST_METHOD'];
$pattern = '/^.*'.$root.'\//';
$path = explode('/', preg_replace($pattern, '', $url));

set_include_path( dirname(__FILE__) );

if (!isset($_SESSION['user'])) {
   $_SESSION['redirect'] = $path;
   $path[0] = 'login';
}
if (!isset($path[0])) {
   echo "index";
   return;
}
if ($path[0] == 'logout') {
   session_unset();
   $path[0] == 'login';
}
if ($path[0] == 'login') { 
   if ($method == 'GET') { 
      header('Content-Type: text/html');
      readfile('pages/login.html');
      return;
   } else {
      //try to login
      $user = getuser(login($_POST['username'], $_POST['password']));
      $_SESSION['user'] = $user;
      if (!isset($_SESSION['user'])) {
         echo 'login error';
         return;
      }
      $path = $_SESSION['redirect'];
   }
   return;
}
if ($path[0] == 'js') {
   header('Content-Type: text/javascript');
   readfile('js/' + $path[1]);
   return;
}
if (is_file('pages/'.$path[0].'.html')) {
   header('Content-Type: text/html');
   readfile('pages/'.$path[0].'.html');
   return;
}
if ($path[0] == 'api') {
   $_POST['userid'] = $_SESSION['user']->id;
   if ($method == 'POST') {
      $path[3] = $_POST;
   }
   $file = 'app/'.$path[1].'.php';
   if (is_file($file)) {
      require_once($file);
      if (function_exists($path[1])) {
         echo $path[1]('./config.ignore', $path[2], $path[3]);
         return;
      }
   }
}

echo 'file not found';


?>
