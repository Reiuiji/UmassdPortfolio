#!/bin/sh
if [ $# -lt 1 ]; then
   echo "Usage: mathmagic [num1] [num2]"
   exit
fi
echo "A:$1 B:$2"
add=`expr $1 + $2`
echo "A+B:$add"
sub=`expr $1 - $2`
if (( $1 < $2 )) ;then
   echo "Warning: value will be negative: $sub";
else
   echo "A-B:$sub"
fi
mult=`expr $1 \* $2`
echo "A*B:$mult"
