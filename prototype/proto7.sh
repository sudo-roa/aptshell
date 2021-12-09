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
# >で処理が接続されていても、標準出力内容の終了ステータスが表示された
# $ cat a.txt > test.txt ; echo $?
#  cat: a.txt: そのようなファイルやディレクトリはありません
#  1
# $ cat a.txt &> test.txt ; echo $?
#  1

#エラーcheck用の変数hoge
hoge=1

if [[ "$?" -eq 0 ]]
then
	printf "+----------------+\n"
	printf "|\e[32m Success Update\e[m |\n"
	printf "+----------------+\n"
else
	printf "+----------------+\n"
	printf "|\e[31m Failure Update\e[m |\n"
	printf "+----------------+\n"
fi

printf "\n"
echo "$prompt $ sudo apt-get -y upgrade"
sudo apt-get -y upgrade > ./log/upgrade/upgrade$execTime.log
tail -n 1 ./log/upgrade/upgrade$execTime.log
if [[ "$?" -eq 0 ]]
then
	printf "+-----------------+\n"
	printf "|\e[32m Success Upgrade\e[m |\n"
	printf "+-----------------+\n"
else
	printf "+-----------------+\n"
	printf "|\e[31m Failure Upgrade\e[m |\n"
	printf "+-----------------+\n"
fi

printf "\n"
echo "$prompt $ sudo apt-get -y autoremove"
sudo apt-get -y autoremove > ./log/autoremove/autoremove$execTime.log
tail -n 1 ./log/autoremove/autoremove$execTime.log
if [[ "$?" -eq 0 ]]
then
	printf "+--------------------+\n"
	printf "|\e[32m Success Autoremove\e[m |\n"
	printf "+--------------------+\n"
else
	printf "+--------------------+\n"
	printf "|\e[31m Failure Autoremove\e[m |\n"
	printf "+--------------------+\n"
fi

printf "\n"
echo "今回のパッケージ更新は$(($SECONDS-$startTime))秒かかりました。"

#終了ステータスでsuccessとfailureの出力を分ける
