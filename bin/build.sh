#!/usr/bin/env sh
set -e

# 执行打包命令镜像 pnpm/npm/yarn
source=pnpm

# 执行命令，和 当前脚本名保持一致，省略.sh
command=build
path="$(pwd)/log"
log=$path/$source-error.log

exec_project(){
   echo $1
   cd $1
   echo "项目打包中……🍖"
   $source $command  2>>$log
   echo "项目打包成功🚀"
   cd -
}

log_check(){
    # 判断日志路径是否存在
    if [ -e  $path ]
    then
         echo "日志目录已存在，错误日志将输出到 $log"
    else 
        echo "生成日志目录"
        mkdir -p  $path 
    fi
}

log_check

if [[ "$0" == "$command.sh" || "$0" == "./$command.sh" ]]
then
   exec_project ..
else
   exec_project .
fi


