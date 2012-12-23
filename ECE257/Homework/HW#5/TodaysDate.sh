#!/bin/csh
echo "the programs name is $0"
set Based_date=`date -d "1900/1/1" "+%s"`
echo $Based_date
echo $argv[1] 
switch ($argv[1])
	case "jan"
		set month=1
		breaksw
	case "feb"
		set month=2
		breaksw
	case "mar"
		set month=3
		breaksw
	case "april"
		set month=4
		breaksw
	case "may"
		set month=5
		breaksw
	case "june"
		set month=6
		breaksw
	case "july"
		set month=7
		breaksw
	case "august"
		set month=8
		breaksw
	case "sept"
		set month=9
		breaksw
	case "oct"
		set month=10
		breaksw
	case "nov"
		set month=11
		breaksw
	case "dec"
		set month=12
		breaksw
	default:
		echo "invalid mouth[see sh for exact input of month"
endsw
echo "date entered: $argv[3]/$month/$argv[2]"
set Entered_date=`date -d "$argv[3]/$month/$argv[2]" "+%s"`
set difference=`expr $Entered_date - $Based_date`
set conv=`expr 60 \* 60 \* 24`
echo `expr $difference / $conv`
