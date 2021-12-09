#!/bin/bash

if [ -d "log" ]
then
	test ! -d log/update && mkdir log/update
	test ! -d log/upgrade && mkdir log/upgrade
	test ! -d log/autoremove && mkdir log/autoremove
else
	mkdir log
	mkdir log/update log/upgrade log/autoremove
fi

echo "aptパッケージの更新を始めます。"

startTime=$SECONDS
prompt=$USER@`basename $PWD`

printf "\n"
echo "$prompt $ sudo apt-get update" 
sudo apt-get update > ./log/update/update`date "+%Y%m%d_%H%M"`.log
printf "+---------------------+\n"
printf "|\e[32m Successfully Update\e[m |\n"
printf "+---------------------+\n"

printf "\n"
echo "$prompt $ sudo apt-get -y upgrade"
sudo apt-get -y upgrade > ./log/upgrade/upgrade`date "+%Y%m%d_%H%M"`.log
printf "+----------------------+\n"
printf "|\e[32m Successfully Upgrade\e[m |\n"
printf "+----------------------+\n"

printf "\n"
echo "$prompt $ sudo apt-get -y autoremove"
sudo apt-get -y autoremove > ./log/autoremove/autoremove`date "+%Y%m%d_%H%M"`.log
printf "+-------------------------+\n"
printf "|\e[32m Successfully autoremove\e[m |\n"
printf "+-------------------------+\n"

printf "\n"
echo "今回のパッケージ更新は$(($SECONDS-$startTime))秒かかりました。"


