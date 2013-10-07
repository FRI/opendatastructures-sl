#!/bin/bash

LOG=/var/www/sl.opendatastructures.org/versions-sl/ods-r${1}.log

cd `dirname $0`; ./nightly.sh $1 $2 2>&1>$LOG &
