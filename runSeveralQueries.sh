#!/bin/bash

if [ -z "$1" ];
then
    echo "please provide number of queries"
    exit 1;
fi

echo "[$$] Starting $1 queries" | tee -a Big_Migrate.log
for i in `seq 1 $1`; do
    ./runOneQuery.sh

    if  [  -f /Users/gabriel.breda/stop.txt ]; then
        echo "stop requested"
        exit 0;
    fi
    sleep 1
done
echo "[$$] Done with $1 queries" | tee -a Big_Migrate.log

