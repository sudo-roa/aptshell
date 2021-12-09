#!/bin/bash

##########
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

#logファイルがなければ作成してから、あるならそのまま更新を始めるようにする
#ファイルの場合-e, ディレクトリの場合は-dの演算子を使う。
#warningが気になる。
##########

startTime=$SECONDS

sudo apt -qq update > ./log/update/update`date "+%Y%m%d_%H%M"`
echo 'updateが完了しました。'

sudo apt -y upgrade
echo 'upgradeが完了しました。'

sudo apt -y autoremove
echo 'autoremoveが完了しました。'

# echo 'starttime:'$startTime
# echo 'endtime:'$SECONDS
echo "$(($SECONDS-$startTime))秒かかりました。"

echo 'apt_update'
date "+%Y%m%d_%H%M"

