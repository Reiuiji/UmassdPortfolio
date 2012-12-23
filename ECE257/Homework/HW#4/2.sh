gawk '/silver/ {ounces += $2} /silver/ {count ++}END {print("We have " count " coins"  "\nTotal weight: " ounces " oz \nTotal value of gold(34.35 per oz) : $ " ounces*34.35)}' coins.txt

