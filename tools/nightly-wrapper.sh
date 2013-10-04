#!/bin/bash

ODSTOOLS_PATH=/home/mjekovec/odstools
LOG=/var/www/sl.opendatastructures.org/versions-sl/ods-r${1}.log

$ODSTOOLS_PATH/nightly.sh $1 $2 &2>$LOG &
