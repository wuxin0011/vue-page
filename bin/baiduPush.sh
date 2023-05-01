#!/usr/bin/env sh
cd ..
# 确保脚本抛出遇到的错误
set -e

source=baiduPush


if [[ "$0" == "$source.sh" || "$0" == "./$source.sh" ]]
then
   exec_project ..
else
   exec_project .
fi




exec_project(){
    cd $1
    echo "百度链接推送中……🍖"
    # 百度链接推送
    curl -H 'Content-Type:text/plain' --data-binary @urls.txt "http://data.zz.baidu.com/urls?site=https://xugaoyi.com&token=T5PEAzhGaPNbjQ2X"

    echo "百度链接推送成功🚀"
    rm -rf urls.txt # 删除文件
    cd -
}
