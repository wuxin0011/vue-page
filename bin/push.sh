
#!/usr/bin/env sh
set -e

# 发布脚本名称，省略sh 比如当前脚本 deploy.sh
source=push

path="$(pwd)/log"
log=$path/$source-error.log


# 项目发布域名
web_url='https://wuxin0011.github.io/vue-page'
# 上传消息
git_message="deploy $web_url"
# 判断是否有输入消息参数
message_check(){
    if [ -n "$1" ]
    then
       git_message=$1
    fi
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

# 执行脚本
exec_project(){
   cd $1
   # 确保脚本抛出遇到的错误
   git add . 2>>$log
   git commit -m "$git_message" 2>>$log
   git push 2>>$log
   echo "项目成功发布到$web_url！🚀"
   cd -
}


message_check
log_check


# 判断当前路径是bin目录还是项目目录
if [[ "$0" == "$source.sh" || "$0" == "./$source.sh" ]]
then
   exec_project ..
else
   exec_project .
fi
