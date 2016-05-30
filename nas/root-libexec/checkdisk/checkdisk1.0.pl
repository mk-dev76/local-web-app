#!/usr/bin/perl

use GD;

#process
$_pdat_='/var/www/html/disk/ps.dat';
@_nd_=`/bin/ps -eo "comm,pid"|/bin/grep nmbd | /bin/grep -v grep`;
@_sd_=`/bin/ps -eo "comm,pid"|/bin/grep smbd | /bin/grep -v grep`;
$_lvg_=`/bin/uptime`;
chomp ($_lvg_); $_lvg_="<p>".$_lvg_."</p>";
if($#_nd_>-1){
  $st_of_n='<p class=normal><span style="font-weight: bold;">nmbd</span> is running ( ';
  foreach $_ (@_nd_){
    $_ =~ tr/ //s;
    chomp $_;
    @t=split(/ /, $_);
    $st_of_n=$st_of_n."$t[1] ";
  }
  $st_of_n=$st_of_n.')</p>';
}
else{$st_of_n='<p class=alert><span style="font-weight: bold;">nmbd</span> is not running</p>'}

if($#_sd_>-1){
  $st_of_s='<p class=normal><span style="font-weight: bold;">smbd</span> is running ( ';
  foreach $_ (@_sd_){
    $_ =~ tr/ //s;
    chomp $_;
    @t=split(/ /, $_);
    $st_of_s=$st_of_s."$t[1] ";
  }
  $st_of_s=$st_of_s.')</p>';
}
else{$st_of_s='<p class=alert><span style="font-weight: bold;">smbd</span> is not running</p>'}
open PS, ">".$_pdat_ || die;
print PS "$_lvg_\n";
print PS "$st_of_n\n";
print PS "$st_of_s\n";
close PS;
#resource

$_dat_='/var/www/html/disk/df.dat';
$_dop_="/var/www/html/disk/";

@list=`/bin/df -m|/bin/grep /mnt/nas`;
%nas=();

foreach $_ (@list){
  chomp $_;
  $_ =~ tr/ //s;
  @disk=split(/ /, $_);
#@n=($disk[2],$disk[1],sprintf("%.2f", $disk[2]*100/$disk[1]));
  @{$nas{$disk[5]}}=(sprintf("%.1f",$disk[2]/1024),
                     sprintf("%.1f",$disk[1]/1024),
                     sprintf("%.2f", $disk[2]*100/$disk[1])
                    );
}

$i=1;
open DAT, ">".$_dat_;
print DAT "<p><table><tr><th>name</th><th>Used</th><th>Size</th><th>Use\%</th><th>Graph of Used</th></tr>\n";
foreach $_ (sort(keys %nas)){
  $im = new GD::Image(302,17) || die;
  $white = $im->colorAllocate(255,255,255);
  $black = $im->colorAllocate(0,0,0);
  $red = $im->colorAllocate(255,0,0);
  $blue = $im->colorAllocate(38,160,218);
  $im->fill(1,1,$black);
  $im->filledRectangle(1,1,300,15,$white);
  if($nas{$_}[2]>=80){$cl=$red;}else{$cl=$blue;}
  if( int($nas{$_}[2]*0.3+0.5) >0 ){$im->filledRectangle(1,1,int($nas{$_}[2]*3+0.5),15,$cl);}
  open (DISPLAY, ">".$_dop_."df".$i.".png") || die;
  print DISPLAY $im->png;
  close DISPLAY;
  printf DAT "<tr><td class=name>$_</td><td>$nas{$_}[0]GB</td><td>$nas{$_}[1]GB</td><td>$nas{$_}[2]\%</td><td class=graph><img src=\"./disk/df$i.png\" border=0></td></tr>\n";
  $i++;
}
print DAT "</table></p>\n";
close DAT;

#DISK health

#$_hdat_='/var/www/html/disk/dh.dat';
#system("/usr/local/bin/startpg.sh >/dev/null 2>&1");
#foreach $_ (sort(keys %nas)){
#  
#}
