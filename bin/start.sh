#!/usr/bin/env sh
set -e

# 执行打包命令镜像 pnpm/npm/yarn
source=pnpm

# 执行命令，和 当前脚本名保持一致，省略.sh
command=dev

path="$(pwd)/log"
log=$path/$command-error.log


exec_project(){
   cd $1
   log_check
   echo "项目启动中……🍖"
   $source $command 2>>$log
   echo "项目启动成功 🚀"
   cd -
}

log_check(){
   # 判断当前路径是bin目录还是项目目录
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


