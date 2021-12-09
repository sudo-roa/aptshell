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
execTime=`date "+%Y%m%d_%H%M"`

printf "\n"
echo "$prompt $ sudo apt-get update" 
sudo apt-get update > ./log/update/update$execTime.log
printf "+---------------------+\n"
printf "|\e[32m Successfully Update\e[m |\n"
printf "+---------------------+\n"

printf "\n"
echo "$prompt $ sudo apt-get -y upgrade"
sudo apt-get -y upgrade > ./log/upgrade/upgrade$execTime.log
tail -n 1 ./log/upgrade/upgrade$execTime.log
printf "+----------------------+\n"
printf "|\e[32m Successfully Upgrade\e[m |\n"
printf "+----------------------+\n"

printf "\n"
echo "$prompt $ sudo apt-get -y autoremove"
sudo apt-get -y autoremove > ./log/autoremove/autoremove$execTime.log
tail -n 1 ./log/autoremove/autoremove$execTime.log
printf "+-------------------------+\n"
printf "|\e[32m Successfully autoremove\e[m |\n"
printf "+-------------------------+\n"

printf "\n"
echo "今回のパッケージ更新は$(($SECONDS-$startTime))秒かかりました。"

#各操作の最後の行を出力して、結果がどうだったかを可視化した
