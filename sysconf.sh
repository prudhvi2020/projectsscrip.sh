#!/bin/bash
PORT=22
TIMEOUT=3
CPU_LOAD=90
echo "THE FREE MEMORY ON THE ABOVE DATE AND TIME IS AS FOLLOWS:" >> sys.txt
echo "--------------------------------------------------------" >> sys.txt
echo "DATE=$(date +%d.%m.%Y)"  >> sys.txt
echo "TIME=$(date +%H:%M:%S)"  >> sys.txt
for SERVER in $(cat servers.txt)
do
# Open a socket and send a char
    echo "-" | nc -w $TIMEOUT $SERVER $PORT &> /dev/null

 # Check exit code of NC
if [ $? -eq 0 ]; then
echo "$SERVER is Available."
# it will give the value of total freememory in server
freememory=$(ssh $SERVER free -mt | grep -w "Total" | awk '{print $4}')
# it will give diskspace
diskspace=$(ssh $SERVER df -h | awk '{print $1" " $4 }'| cut -d "." -f 2)
it will give the value of cpu usage
cpu_usage=$(ssh $SERVER top -b -n 2 -d1 | grep "Cpu(s)" | tail -n1 | awk '{print $2}' | cut -d "." -f 1)
# -n Returns true if the string is not empty
if [ -n $CPU_LOAD ]; then
if [ $cpu_usage -ge $CPU_LOAD ]; then
wall echo "WARNING:your cpu load is very high"
else
wall echo "plz check sys.txt for output"
fi
fi
echo "server:$SERVER" >> sys.txt
echo "freememory:$freememory" >> sys.txt
echo "cpu_usage:$cpu_usage" >> sys.txt
echo "diskspace:$diskspace" >> sys.txt
else
echo "$SERVER is Unavailable."
fi
done

