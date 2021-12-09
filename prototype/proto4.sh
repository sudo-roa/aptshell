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

# testコマンドでフォルダの有無を確認する方式に変更
# upgrade, autoremoveもlogファイルを作成

echo "aptパッケージの更新を始めます"

startTime=$SECONDS

sudo apt-get update > ./log/update/update`date "+%Y%m%d_%H%M"`
echo 'updateが完了しました。'

sudo apt-get -y upgrade > ./log/upgrade/upgrade`date "+%Y%m%d_%H%M"`
echo 'upgradeが完了しました。'

sudo apt-get -y autoremove > ./log/autoremove/autoremove`date "+%Y%m%d_%H%M"`
echo 'autoremoveが完了しました。'

# echo 'starttime:'$startTime
# echo 'endtime:'$SECONDS
echo "$(($SECONDS-$startTime))秒かかりました。"

#次はエラーが出た場合どうするかを考える
