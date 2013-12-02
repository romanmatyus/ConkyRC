#!/bin/bash
list=()
while read line
do
	if [ `cat /sys/class/net/$line/operstate` == "up" ]; then
		list+=("$line")
	fi
done < <(ls -1 /sys/class/net)

if [ "$list" ]; then
	echo ""
	echo ""
	echo "C O N N E C T I O N S"
	echo "\${hr}"
	for line in "${list[@]}"
	do
		echo ''$line'$alignr D:${downspeed '$line'} U:${upspeed '$line'}'
		echo 'Total$alignr D:${totaldown '$line'} U:${totalup '$line'}'
		if echo $line | grep -q "wlan"; then
			now=`iwconfig $line|grep 'Link Quality='|grep '='|grep --max-count=1 -o '\=\([0-9]\+\)'|grep --max-count=1 -o '\([0-9]\+\)'`
			all=`iwconfig $line|grep 'Link Quality='|grep '='|grep --max-count=1 -o '/\([0-9]\+\)'|grep --max-count=1 -o '\([0-9]\+\)'`
			strength=`bc -l<<<"100/$all*$now"`
			strength=$(printf "%.0f" ${strength//./,})
			echo '${wireless_essid '$line'}$alignr '$strength'%'
		fi
	done
fi


