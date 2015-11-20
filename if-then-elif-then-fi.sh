#!/bin/bash
#below we test a input
if  [ -z $1 ]
then 
       echo "this shell must choose {checkyc|rs}";
elif [ $1 = "checkyc" ]
then
	pwd && echo "checkyc";
elif [ $1 = "rs" ]
then
	echo "rs";
fi
