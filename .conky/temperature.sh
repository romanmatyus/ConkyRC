#!/bin/bash
temp=`cat /sys/class/hwmon/hwmon1/temp1_input`
temp=`bc -l<<<"$temp/1000"`
temp=$(printf "%.1f" ${temp//./,})
echo 'Graphic temperature$alignr '$temp'°C'
