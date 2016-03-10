#!/bin/bash
IP=192.168.1
read -p "network:" network;
#init IPlist for scan
IP=`echo $network |awk -F'.' 'BEGIN{OFS="."}{print $1,$2,$3}'`
>./IPlist 
for ((i=1;i<=255;i++));do echo $IP.$i >>./IPlist;done;
#echo $network |awk -F'.' 'BEGIN{OFS="."}{print $1,$2,$3}' >IP
#sed -i '' 's/192.168.1/'$IP'/g' /Users/liuhongbin/GitHub/dtdream/scanip/IPlist
#IP=$network |awk -F'.' 'BEGIN{OFS="."}{print $1,$2,$3}'
#echo $IP
#ping -c $i
for i in `cat ./IPlist`;
do if ping -c 1  -W 200  $i |grep time= >/dev/null 2>&1
	then echo $i
fi ;
done;
