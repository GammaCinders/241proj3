#! /bin/bash

if [ $# -eq 0 ]
then
	echo "give me some arguments man!"
	exit
fi

backupPath="${HOME}/backup"
if ! [ -d "${backupPath}" ]
then
	mkdir ${backupPath}
fi

for arg in $*
do
	if [ $(echo $arg | cut -b-1) = "-" ]
	then
		echo
		case $arg in

			-l)
				echo "Files in ~/backup:" 
				ls "${backupPath}"
				echo
				;;
			-c)
				echo "Number of files and directories in ~/backup $(ls $backupPath | wc -w)"
				echo "Disk usage of files and directories in ~/backup $(du -b $backupPath)"
				echo
				;;
			--help)
				echo "HELP : backup copies provided files to ~/backup with options"
				echo "Usage : "
				echo "	backup [FILES...] [OPTIONS...]"
				echo "OPTIONS are :"
				echo "	-c, displays number of files and directories in ~/backup as well as disk usage of them"
				echo "	-l, displays all files in ~/backup"
				echo "	--help, displays this text"	
				echo
				;;
			*)
				echo "$arg is an invalid arg"
				echo
				;;
		esac
	else
		if [ -e $arg ]
		then
			cp -r $arg $backupPath
		else
			echo "$arg does not exist"
		fi
	fi	
done
