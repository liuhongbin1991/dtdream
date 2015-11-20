#!/bin/bash
read -nl -p "chose the option word [check/restart]:" answer
case $answer in
check ) 
        echo "check "
restart) 
	 echo "restart"
	exit;;
esac

