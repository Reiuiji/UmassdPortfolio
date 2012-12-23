#!/bin/sh
if [ $# -lt 1 ]; then
   echo "Usage: mathmagic [num1] [num2] .. .. .."
   exit
fi
#add sub all variables
x=1
add=$1
sub=$1
mult=$1
arg=`expr $# - 1`
shift 1;
while [ $x -le $arg ]
do
	add=`expr $add + $1`
	sub=`expr $sub - $1`
	mult=`expr $mult \* $1`
	(( x = $x + 1 ))
	shift 1 
done
echo "Total Add:$add"
echo "Total Sub:$sub"
echo "Total Mult:$mult"
