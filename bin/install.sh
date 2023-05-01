#!/usr/bin/env sh
set -e

# 执行命令，和 当前脚本名保持一致，省略.sh
# 打包命令 pnpm/yarn/npm
build_source=pnpm
build_command=install




path="$(pwd)/log"
log=$path/$build_command-error.log

# 判断当前路径是bin目录还是项目目录
if [ -e  $path ]
then
     echo "日志目录已存在，错误日志将输出到 $log"
else 
    echo "生成日志目录"
    mkdir -p  $path 
fi



exec_project(){
   cd $1
   echo "依赖开始安装中……🍖"
   $build_source $build_command 2>>$log
   echo "依赖安装成功！🚀"
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

if [[ "$0" == "$build_command.sh" || "$0" == "./$build_command.sh" ]]
then
   exec_project ..
else
   exec_project .
fi


