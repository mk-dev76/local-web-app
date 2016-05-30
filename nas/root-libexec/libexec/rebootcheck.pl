#!/usr/bin/perl


if(-f "/var/www/dat/shutdown"){
  if(-f "/var/www/dat/stop_shutdown"){
    unlink "/var/www/dat/stop_shutdown";
  }
  unlink "/var/www/dat/shutdown";
  system("/sbin/shutdown -h now >/dev/null 2>&1");
}
