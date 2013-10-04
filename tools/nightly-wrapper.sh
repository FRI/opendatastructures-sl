#!/bin/bash

ODSTOOLS_PATH=/home/mjekovec/odstools
LOG=$OUT_PATH/ods-r${$1}.log

$ODSTOOLS_PATH/nightly.sh $1 $2 &2>$LOG &
