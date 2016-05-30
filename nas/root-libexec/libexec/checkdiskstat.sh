#!/bin/sh

/sbin/smartctl -H /dev/sdd | /bin/grep 'SMART overall-health self-assessment test result:' > /var/www/dat/nas1.stat
/sbin/smartctl -H /dev/sde | /bin/grep 'SMART overall-health self-assessment test result:' > /var/www/dat/nas2.stat
/sbin/smartctl -H /dev/sdb | /bin/grep 'SMART overall-health self-assessment test result:' > /var/www/dat/nas3.stat
/sbin/smartctl -H /dev/sdc | /bin/grep 'SMART overall-health self-assessment test result:' > /var/www/dat/nas4.stat


/bin/chmod 755 /var/www/dat/nas1.stat
/bin/chmod 755 /var/www/dat/nas2.stat
/bin/chmod 755 /var/www/dat/nas3.stat
/bin/chmod 755 /var/www/dat/nas4.stat
