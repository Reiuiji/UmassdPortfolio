gawk '/gold/ {ounces += $2} /gold/ {count ++}END {print("We have " count " coins"  "\nTotal weight: " ounces " oz \nTotal value of gold(1770.5 per oz) : $ " ounces*1770.50)}' coins.txt

