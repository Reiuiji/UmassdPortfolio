#!/usr/bin/perl

print " Program Name: $0 \n";
$numarg=$#ARGV + 1;
print " Number of arguments: $numarg \n";

$factorial=1;
$Multi=$ARGV[0];

print " Arguments are: $ARGV[0] ";

for($i=1;$i<$numarg;$i++)
{
	print "$ARGV[$i] ";
 	$factorial=($i+1)*$factorial;
	$Multi=$Multi*$ARGV[$i];
}

print "\n Multiplication result: $Multi \n";
print " Factorial : ", "$factorial","\n";
