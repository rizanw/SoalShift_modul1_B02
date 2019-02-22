#!/bin/bash

lowercase=(a b c d e f g h i j k l m n o p q r s t u v w x y z)
uppercase=(A B C D E F G H I J K L M N O P Q R S T U V W X Y Z)

tgl=`date +"%d"`
bln=`date +"%m"`
thn=`date +"%Y"`
jam=`date +"%H"`
mnt=`date +"%M"`

home="/home/sherly"
namafile="$home/$jam:$mnt $tgl-$bln-$thn.txt"
bawah=${lowercase[$jam]}
atas=${uppercase[$jam]}
cat /var/log/syslog > /home/sherly/syslog4.txt
cat /home/sherly/syslog4.txt | tr '[a-z]' "[$bawah-za-$bawah]" | tr '[A-Z]' "[$atas-ZA-$atas]" > "$namafile"
