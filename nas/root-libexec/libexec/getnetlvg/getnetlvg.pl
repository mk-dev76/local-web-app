#!/usr/bin/perl

$t=time();
@day=localtime($t);

$logdir="/var/log/nstat";
$logfile="nstat.log";
$cmd = '/usr/bin/sar -n DEV |grep enp3s0|tr -s " " ","';
@_tmp_ = `$cmd`;

#Average:IFACE rxpck/s txpck/s rxkB/s txkB/s rxcmp/s txcmp/s rxmcst/s
@load = split /,/, $_tmp_[$#_tmp_];

#print @load;

if($day[2]+$day[1]<1){
  if(-f $logdir."/".$logfile){
    $date = sprintf("%04d%02d%02d", $day[5]+1900,$day[4]+1,$day[3]);
  }
}

unless(-f $logdir."/".$logfile){
  open FH, ">".$logdir."/".$logfile;
  print FH "time rxpck/s txpck/s rxkB/s txkB/s\n";  
}
else {
  open FH, ">>".$logdir."/".$logfile;
}
print FH "$t $load[2] $load[3] $load[4] $load[5]\n";
close (FH);
