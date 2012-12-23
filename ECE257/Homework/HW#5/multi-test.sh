#!/bin/sh
#
if [ $# -lt 1 ]; then
   echo "Usage: multi number"
   exit
fi
x=1					# set outer loop value
while [ $x -le $1 ]				# outer loop
do
  y=1					# set inner loop value
  while [ $y -le $1 ]
  do					# generate one table entry
    (( entry = $x * $y ))
    echo -e -n "$entry\t"
    (( y = $y + 1 )) 			# update inner loop count
  done
  echo					# blank line
  (( x = $x + 1 ))				# update outer loop count
done
