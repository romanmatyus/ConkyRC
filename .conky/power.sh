#!/bin/bash
# Need ACPI
if [ `cat /sys/class/power_supply/BAT1/present` == "1" ]; then
	status=`cat /sys/class/power_supply/BAT1/status`
	echo ""
	echo ""
	echo "B A T T E R Y"
	echo "\${hr}"
	echo ''$status'$alignr ${battery_percent BAT1}%'
	if [ $status == "Discharging" ]; then
		consuption=`echo - | awk "{printf \"%.1f\", $((  $(cat /sys/class/power_supply/BAT1/current_now) *   $(cat /sys/class/power_supply/BAT1/voltage_now) )) / 1000000000000 }"`
		echo 'Consuption$alignr '$consuption' W'
		remaining_h=`acpi -b | grep "Battery" | awk '{print $5}' | cut -c 1-5|grep --max-count=1 -o '\([0-9]\+\):'|grep --max-count=1 -o '\([0-9]\+\)'| sed 's/^0\(.*\)$/\1/'`
		remaining_m=`acpi -b | grep "Battery" | awk '{print $5}' | cut -c 1-5|grep --max-count=1 -o '\:\([0-9]\+\)'|grep --max-count=1 -o '\([0-9]\+\)'| sed 's/^0\(.*\)$/\1/'`
		if [ $remaining_h != "0" ]; then
			echo 'Remaining$alignr '$remaining_h'h '$remaining_m'm'
		else
			echo 'Remaining$alignr '$remaining_m'm'
		fi
	fi
fi
