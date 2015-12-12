#!/bin/bash
#***************************************************** 
#ScriptName:dockernetwork.sh 
#S#Author: liuhb@dtdream.com 
#S#Create Date:2015-12-10 17:28 
#S#Fuction:this shell is used to give container a static ip

#交互式框架
read -p "please choose the network's mode {nat|bridge}:" networkmode 
case $networkmode in
nat) echo "the nat fucation is developing";;
bridge) echo "the mode your choose is bridge";;
*) echo "please choose the network's mode {nat|bridge}:";;
esac

#the mode of bridge
read -p "please input  the container's name or container id:" container
if test -z $container
then 
echo "input a name or container id"
else 
   pid=`docker inspect -f '{{.State.Pid}}' $container`
   mkdir -p /var/run/netns
   test -f /var/run/netns/$pid || ln -s /proc/$pid/ns/net /var/run/netns/$pid >/dev/null 2>&1
   tcpdump -D |grep -v \(
   sleep 5 
   read -p "input the interfase's name from the list upstairs:" bridge
   if  ip add |grep veth$pid 
      then ip link delete veth$pid;
      else continue;
   fi
   ip link add veth$pid type veth peer name B
   brctl addif $bridge veth$pid
   ip link set veth$pid up
   ip link set B netns $pid
   ip netns exec $pid ip link set dev B name eth0
   ip netns exec $pid ip link set eth0 up
   read -p "set an IP for your container with then netmask like '192.168.1.1/24';" containerip
   ip netns exec $pid ip addr add $containerip dev eth0
   read -p "set an gateway for your container like '192.168.1.254';" containergw
   ip netns exec $pid ip route add default via $containergw
   if ping $containerip 
      then echo"succeed"
      else
          echo "error"
   fi
#   read -p "the network interfaces in your server are listed if you need to add a bridge?{yes|no}:" judgement
#   if $judgement ="yes"
#   then 
#      read -p "input your bridge's name" addbridge
#      ip link add $addbridge peer name B
#   elif $judgement = "no"
#      read -p "input the interface's name upstairs:" existedbridge
#      ip link 
#   

fi



#the mode of nat
