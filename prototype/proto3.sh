#!/bin/bash

if [ -d "log" ]
then
	if [ -d "log/update" ]
	then
		echo "aptパッケージの更新を始めます"
	else
		mkdir log/update
		echo "aptパッケージの更新を始めます"
	fi
else
	mkdir log
	mkdir log/update
	echo "aptパッケージの更新を始めます"
fi

startTime=$SECONDS

sudo apt-get update > ./log/update/update`date "+%Y%m%d_%H%M"`
echo 'updateが完了しました。'

sudo apt-get -y upgrade
echo 'upgradeが完了しました。'

sudo apt-get -y autoremove
echo 'autoremoveが完了しました。'

# echo 'starttime:'$startTime
# echo 'endtime:'$SECONDS
echo "$(($SECONDS-$startTime))秒かかりました。"

echo 'apt_update'
date "+%Y%m%d_%H%M"

#aptはスクリプト利用すると、対話型なのでスクリプト利用しないでくれと注意書きが出る
#apt-getならwarningは出ないらしい。

