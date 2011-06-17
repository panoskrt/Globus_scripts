#!/bin/bash

HOSTNAME=`hostname`
VERSION=4.2.1

if [ "$1" == "start" ]; then

   if [ $UID -eq 0 ]; then
     export GLOBUS_LOCATION=/usr/local/globus-$VERSION/
     export LD_LIBRARY_PATH=/usr/local/globus-$VERSION/lib
     export GLOBUS_TCP_PORT_RANGE=20000,25000
     export GLOBUS_HOSTNAME=$HOSTNAME
     export GRID_SECURITY_DIR=/etc/grid-security/
     export X509_USER_KEY=/etc/grid-security/hostkey.pem
     export X509_USER_CERT=/etc/grid-security/hostcert.pem
     export X509_CERT_DIR=/etc/grid-security/certificates
     export GRIDMAP=/etc/grid-security/grid-mapfile

     $GLOBUS_LOCATION/sbin/sshd &
     PID=`ps u | grep $GLOBUS_LOCATION/sbin/sshd | grep -v grep | awk {'print $2 '}`
     echo "GSISSH started with PID $PID"
   else
     echo "Only root can start GSISSH service"
     exit 1;
   fi

elif [ "$1" == "stop" ]; then

   if [ $UID -eq 0 ]; then
     PID=`ps aux | grep globus | grep sshd | grep -v grep | awk {'print $2 '}`
     kill -9 $PID
     echo "GSISSH stopped"
   else
     echo "Only root can stop GSISSH"
     exit 1;
   fi

fi
