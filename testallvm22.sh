#!/bin/bash
#*****************************************************
#ScriptName:testallvm22.sh
#Author: liuhb@dtdream.com
#Create Date:2015-11-30 11:18
#Fuction: this script is for users to test all vm's ssh 
houyiregiondb=ecs.mysql.rds.pcloud.ga
houyiregiondbport=3022
houyiregiondbuser=ecs
houyiregiondvpasswd=rcwpAeak97qPsdfz
mysql -h$houyiregiondb -P$houyiregiondbport -p$houyiregiondvpasswd -uhouyiregiondbuser houyiregiondb -e "select * from vm where status='running'; " >/tmp/allrunningvm
sed -i '1d' /tmp/allrunningvm
if [ -f /tmp/allvmrefuse ]
then 
    > /tmp/allvmrefuse
else
    touch /tmp/allvmrefuse
    > /tmp/allvmrefuse
fi
if [ -f /tmp/allvmaliip ]
then
    > /tmp/allvmaliip
else
    touch /tmp/allvmaliip
    > /tmp/allvmrefuse
fi
for i in `cat /tmp/allrunningvm`;do go2which $i|grep 'instance_ips' |awk -F '|' '{print $1}' |awk '{print $2,substr($2,4,13)}' |awk '{print $2}' >>/tmp/allvmaliip ;done;
echo "================"
date
for i in `cat /tmp/allvmaliip`;do for (( j = 1; j <= 100; j++));do nc -zvw3 $i 22; done ;done 2>/tmp/allvmrefuse 1>/dev/null
cat /tmp/allvmrefuse |sort |uniq
