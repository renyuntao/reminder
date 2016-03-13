#!/usr/bin/env bash
# DATE: 2016-03-13     
# MAINTAINER: YtRen <rytubuntulinux@gmail.com>               
         
# Initial flags
HFlag='0'
MFlag='0'
SFlag='0'
hFlag='0'
tFlag='0'

# Initial variable
HCount='0'
MCount='0'
SCount='0'

# Store the specific time string that user input
tString=''


TerminalNotify()
{
	count=50
	for((i=0; i<=$count; i=i+1))
	do
		echo -e "\n\e[1m\e[31mIt is time to relax!!!\e[0m" > $1
	done
}

DesktopNotify()
{
	count=10
	for((i=0; i<=$count; i=i+1))
	do
		notify-send Remind "It's time to relax!!!"
		sleep 8
	done
}

PlayMusic()
{
	MusicPath='/home/ryt/Reminder/TaoMaGan.mp3'
	mpg123 -q $MusicPath
}

# Parse command line arguments
while getopts 'hH:M:S:t:' opt
do
	case $opt in
		t)
			tFlag='1'
			tString="$OPTARG"
			;;
		H)
			HFlag='1'
			HCount="$OPTARG"
			;;
		M)
			MFlag='1'
			MCount=$OPTARG
			;;
		S)
			SFlag='1'
			SCount=$OPTARG
			;;
		h)
			hFlag='1'
			;;
		\?)
			echo "Invalid option, please use -h option to see help."

	esac
done

# Check if exist the conflict flag(-t and [-H|-M|S] can't appear simultaneously)
if [ "$tFlag" == "1" ]
then
	if [ "$HFlag" == "1" -o "$MFlag" == "1" -o "$SFlag" == "1" ]
	then
		echo -e "\e[1m-t\e[0m can't appear with [\e[1m-H\e[0m|\e[1m-M\e[0m|\e[1m-S\e[0m] simultaneously."
		exit 1
	fi
fi

# Check other flags
# 'HELP' flag is set
if [ "$hFlag" == "1" ]
then
	echo "Show help"
	exit 0
fi

# Use countdown
if [ "$HFlag" == "1" -o "$MFlag" == "1" -o "$SFlag" == "1" ]
then
	if [ "$HCount" -lt "0" -o "$HCount" -gt "24" ]
	then
		echo "Hour should in [0,24]"
		exit 1
	elif [ "$MCount" -lt "0" -o "$MCount" -gt "60" ]
	then
		echo "Minute should in [0,60]"
		exit 1
	elif [ "$SCount" -lt "0" -o "$SCount" -gt "60" ]
	then
		echo "Second should in [0,60]"
		exit 1
	fi

	sleep ${HCount}h ${MCount}m ${SCount}s 
	clear
	for i in `who`
	do
		if echo $i | grep -q 'pts'
		then
			i='/dev/'$i
			TerminalNotify $i
		fi
	done
	PlayMusic | DesktopNotify 

# Use specific time
else
	echo "$tString"	
	time_arr=(${tString//:/ })

	# Strip time_arr[0]'s prefix 0
	if echo ${time_arr[0]} | grep -q '0[0-9]'
	then
		time_arr[0]=$(echo ${time_arr[0]} | cut -c 2)
	fi
	
	# Strip time_arr[1]'s prefix 0
	if echo ${time_arr[1]} | grep -q '0[0-9]'
	then
		time_arr[1]=$(echo ${time_arr[1]} | cut -c 2)
	fi

	# Strip time_arr[2]'s prefix 0
	if echo ${time_arr[2]} | grep -q '0[0-9]'
	then
		time_arr[2]=$(echo ${time_arr[2]} | cut -c 2)
	fi

	echo "Hours:${time_arr[0]}  Minutes:${time_arr[1]}  Seconds:${time_arr[2]}"
	FutrTotalSecond=$((${time_arr[0]}*3600 + ${time_arr[1]}*60 + ${time_arr[2]}))
	curr_hour=$(date +%H)
	curr_minute=$(date +%M)
	curr_second=$(date +%S)

	# Strip curr_hour's prefix 0
	if echo ${curr_hour} | grep -q '0[0-9]'
	then
		curr_hour=$(echo $curr_hour | cut -c 2)
	fi
	 
	# Strip curr_minute's prefix 0
	if echo ${curr_minute} | grep -q '0[0-9]'
	then
		curr_minute=$(echo $curr_minute | cut -c 2)
	fi

	# Strip curr_second's prefix 0
	if echo ${curr_second} | grep -q '0[0-9]'
	then
		curr_second=$(echo $curr_second | cut -c 2)
	fi

	CurrTotalSecond=$((${curr_hour}*3600+${curr_minute}*60+${curr_second}))
	DiffSecond=$((${FutrTotalSecond}-${CurrTotalSecond}))

	echo "DiffSecond: $DiffSecond"

	if [ "$DiffSecond" -lt "0" ]
	then
		echo "Input time can't earlier than current time."
		exit 1
	fi

	sleep ${DiffSecond}s
fi

