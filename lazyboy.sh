#!/bin/bash

port='port.txt'

for portservice in `cat $port`
do
	tmsh create ltm pool Pool_DCST_$portservice members add { 10.163.135.74:$portservice 10.163.135.75:$portservice } monitor tcp
	tmsh create ltm virtual vs_14.225.247.11_$portservice destination 14.225.247.11:$portservice profiles add { f5-tcp-wan { context clientside } f5-tcp-lan { context serverside } } source-address-translation { type snat pool SNAT_VLAN19 } pool Pool_DCST_$portservice
	echo "Create portservice $portservice done!"
done;
