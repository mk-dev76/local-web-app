#!/usr/bin/perl

$ENV{'TZ'} = "JST-9";
$times = time();
($sec,$min,$hour,$mday,$month,$year,$wday,$stime) = localtime($times);

if($hour>=0 && $hour<6){
  $c=`/bin/find /mnt -type f -cmin -120 | wc -l`;
  $a=`/bin/find /mnt -type f -amin -60 | wc -l`;
}
else{
  $c=`/bin/find /mnt -type f -cmin -240 | wc -l`;
  $a=`/bin/find /mnt -type f -amin -120 | wc -l`;
}
chomp($c);
chomp($a);

#print "$a $c\n";
if($c<1){
  if($a<1){
    if(-f "/var/www/dat/stop_shutdown"){
      $s=`/bin/find /var/www/dat/stop_shutdown -type f -cmin -1440 | wc -l`;
      chomp($s);
      if($s<0){
        unlink "/var/www/dat/stop_shutdown";
      }
    }
    unless(-f "/var/www/dat/stop_shutdown"){
      sleep 10;
      $f = '/var/www/dat/shutdown';
      open my $fh, ">", $f;
      close $fh;
    }
  }
}
