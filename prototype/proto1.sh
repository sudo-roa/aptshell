#!/bin/bash


startTime=$SECONDS

echo 'aptパッケージの更新を開始します。'
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

# logファイルを作成できるようにしたい
# ->aptは安定したCLIではないのでスクリプトでは注意して使用してくださいと警告が出る。
# WARNING: apt does not have a stable CLI interface. Use with caution in scripts.
#
# 極力ログを出さないためのオプション-qq
# 更新時の許可を省略する-yを使用
