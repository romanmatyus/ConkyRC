#!/bin/bash
list=`ls -1 /media/|sed -e 's/cdrom0//' -e 's/cdrom//' -e 's/sda1//' -e 's/sda2//' -e 's/sda4//' -e 's/usb0//' -e 's/usb//' -e 's/sdb1//'|sed '/^$/d'`
if [ "$list" ]; then
	echo ""
	echo ""
	echo "R E M O V A B L E   P L A C E S"
	echo "\${hr}"
	echo "$list" | while read line
	do
		name="${line:0:12}"
		echo ''$name'$alignr${fs_used /media/'$line'}/${fs_size /media/'$line'}'
	done
fi
