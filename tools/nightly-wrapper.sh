#!/bin/bash

LOG=/var/www/sl.opendatastructures.org/versions-sl/ods-r${1}.log
REV=`svn info https://lusy.fri.uni-lj.si/svn/ods/sl --username ods-nightly --password y4FV\&X8C6 --non-interactive --trust-server-cert | grep Revision | awk -F": " '{print $2}'`

cd `dirname $0`
./nightly.sh $REV 2>&1>$LOG &
