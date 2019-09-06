#!/bin/bash

logFile="/Users/gabriel.breda/Big_Migrate.log"
listOfSelects="/Users/gabriel.breda/selects.txt"

date | tee -a $logFile

# double precaution: not needed
# head -n 1 $listOfSelects | tee -a $logFile | sed -E 's/^/SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;/' | mysql --login-path=live0 --ssl-ca=aws.pem -v -v mm_symfony_production | tee -a $logFile

# try to run unlocking
# head -n 1 $listOfSelects | sed -E 's/^/SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;/' | tee -a $logFile | mysql --login-path=live0 --ssl-ca=aws.pem -v -v -v mm_symfony_production 2>&1 | tee -a $logFile

# new VPC: access with tunnel
head -n 1 $listOfSelects | sed -E 's/^/SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;/' | tee -a $logFile | mysql --login-path=master --ssl-ca=aws.pem -v -v -v mm_symfony_production 2>&1 | tee -a $logFile

# this is still locking
# head -n 1 $listOfSelects | tee -a $logFile | mysql --login-path=live0 --ssl-ca=aws.pem -v -v mm_symfony_production 2>&1 | tee -a $logFile

# delete what we have just run
sed -i -e 1,1d $listOfSelects 2>&1 | tee -a $logFile

echo " done at `date`" | tee -a $logFile
