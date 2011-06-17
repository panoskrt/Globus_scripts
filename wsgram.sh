#!/bin/bash

HOSTNAME=`hostname`
VERSION=4.2.1

if [ "$1" == "start" ]; then

   if [ "$USER" == "globus" ]; then
     export GLOBUS_LOCATION=/usr/local/globus-$VERSION/
     export LD_LIBRARY_PATH=/usr/local/globus-$VERSION/lib
     export GLOBUS_HOSTNAME=$HOSTNAME

     cd $GLOBUS_LOCATION
     ./bin/globus-start-container &
     PID=`ps aux | grep DGLOBUS | grep -v grep | awk {'print $2'}`
     echo "WS-GRAM started with PID $PID"
   else
     echo "Only globus user can start the WS-GRAM service"
     exit 1;
   fi

elif [ "$1" == "stop" ]; then

   if [ "$USERID" == "globus" ] || [ $UID -eq 0 ]; then
     PID=`ps aux | grep DGLOBUS | grep -v grep | awk {'print $2'}`
     kill -9 $PID
     echo "WS-GRAM stopped"
   else
     echo "Only user globus and root can stop WS-GRAM"
     exit 1;
   fi

fi
