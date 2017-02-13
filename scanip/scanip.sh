#/bin/bash
#this shell is used for scan all used ip and echo the ips who are useable
#Time 2017-02-13
#Auth liu.hongbin@h3c.com

#define a subnet
read -p "please input a subnet like 192.168.1.0/24:" orgnetwork
if test -z $orgnetwork
then
        echo "error input";
        exit
else
        network=`echo $orgnetwork |awk -F'.' 'BEGIN{OFS="."}{print $1,$2,$3}'`;
        for ((i=1;i<=254;i++));
        do
                if ping -c 1 -w 0.1 $network\.$i |grep "100% packet loss" >/dev/null 2>&1;
                then
                        #echo "haha" >/dev/null 2>&1;
                        echo $network\.$i can be used;
                fi

        done;
fi
