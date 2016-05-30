<?php
  if(isset($_GET['shutdown'])){
     $fp = fopen("/var/www/dat/shutdown","w");
     fwrite($fp, "done");
     fclose($fp);
  }
  else if(isset($_GET['noshutdown'])){
     $fp = fopen("/var/www/dat/stop_shutdown","w");
     $s=time();
     fwrite($fp, $s);
     fclose($fp);
     header( "Location: ./index.php" ) ;
  }

?>
<!-- http://www.css-designsample.com/csstemplate/base/column-one/index.html -->
<html>
<head>
  <title>nas status</title>
  <meta charset="UTF-8">
  <link rel="stylesheet" href="./css/index.css" type="text/css">
  <meta http-equiv="Refresh" content="<?php $_tmp=300-time()%300; echo "$_tmp"; ?>">
  <script type="text/javascript">
  <!-- 
  function disp(){
   if(window.confirm('本当にいいんですね？')){
      location.href = "index.php?shutdown=done";
   }
   else{ window.alert('キャンセルされました');}
  }
  function dispno(){
   if(window.confirm('本当にいいんですね？')){
      location.href = "index.php?noshutdown=done";
   }
   else{ window.alert('キャンセルされました');}
  }
  // -->
  </script>
</head>
<body>
 <div id=wrapper>
  <div id=header class=top>
   <div class=hedleft>
    <h1 class=logo>NAS status</h1>
   </div>
   <div class=hedright>
<?php 
  if(file_exists('/var/www/dat/shutdown') ){echo "shutdown is doing";}     
  else{
    if(file_exists('/var/www/dat/stop_shutdown')){
?>
      <input type=button value="自動shutdown停止延長" onClick="dispno()">
<?php }else{ ?>
    <input type=button value="自動shutdown停止" onClick="dispno()">
<?php } ?>
    <input type=button value="shutdown実行" onClick="disp()">
<?php }?>
   </div>
  </div>
  <div id=contents>
<!-- process -->
   <h2>Process</h2>
    <?php $f=file_get_contents('/var/www/html/disk/ps.dat');echo $f; ?>
<!-- resource -->
<!-- capacity -->
   <h3>Disk status</h3>
    <?php $f=file_get_contents('/var/www/html/disk/df.dat');echo $f; ?>
<!-- performance -->
  </div>
 </div>

  <div id=footer>
  </div>
</body>
</html>
