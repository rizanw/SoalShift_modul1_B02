#!/bin/bash

echo "2.a."
awk -F "," '{if($7 == "2012") a[$1]+=$10}END{for(v in a)print a[v]" - "v}' WA_Sales_Products_2012-14.csv | sort -nr | head -1 | awk -F "-" '{print $2}'	

echo "2.b."
awk -F "," '{if($7=="2012" && $1=="United States") a[$4]+=$10} END {for(v in a)print v}' WA_Sales_Products_2012-14.csv | sort -nr | head -3

echo "2.c"
awk -F "," '{if ($7=="2012" && $1=="United States") a[$4]+=$10} END {for(v in a)print a[v]" - "v}' WA_Sales_Products_2012-14.csv | sort -nr | head -3 | awk -F "-" '{print $2}'	

