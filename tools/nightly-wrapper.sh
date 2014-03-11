#!/bin/bash

REV=`svn info https://lusy.fri.uni-lj.si/svn/ods/sl --username ods-nightly --password y4FV\&X8C6 --non-interactive --trust-server-cert | grep Revision | awk -F": " '{print $2}'`
LOG=/var/www/sl.opendatastructures.org/versions-sl/ods-sl-r${REV}.log

cd `dirname $0`
./nightly.sh $REV 2>&1>>$LOG
