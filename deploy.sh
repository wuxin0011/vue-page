
#!/usr/bin/env sh
set -e

# 发布脚本名称，省略sh 比如当前脚本 deploy.sh
source=deploy

# 打包命令 pnpm/yarn/npm
build_source=pnpm
# build
build_command=build

dist_path=docs/.vuepress/dist # 打包生成的文件夹路径

# 项目发布域名
web_url=https://wuxin0011.github.io/vue-page
# 项目git 地址
git_source=https://github.com/wuxin0011/vue-page
# 上传分支，如果是 master 请使用 main_branch=master
main_branch=main
# 项目打包生成的上传分支
pages_branch=test-pages
# 上传消息
git_message="deploy $web_url"


# 日志
path="$(pwd)/log"
log=$path/$source-error.log


message_check(){
    # 判断是否有输入消息参数
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
   echo "项目打包中……🍊"
   $build_source $build_command  2>>$log
   echo "项目打包成功！推送消息到主分支🍝"
 
   # 发布到主分支的消息
   git add -A  2>>$log
   git commit -m "$git_message"  2>>$log
   git push -f "$git_source" "$main_branch"  2>>$log
   echo "主分支推送成功！进入项目打包目录 🍖"

   # 进入生成的文件夹
   cd $dist_path
   echo "当前文件夹 $(pwd)"

   # 如果是发布到自定义域名
   # echo 'www.example.com' > CNAME
   git init  2>>$log
   git add -A  2>>$log
   git commit -m "$git_message" 2>>$log
   git push -f "$git_source" "$main_branch:$pages_branch" 2>>$log

   echo "正在清理打包文件！🧹"
   rm -rf $dist_path  2>>$log
   cd -

   echo "项目成功发布!"
   echo "$web_url"
}


log_check
message_check

# 判断当前路径是bin目录还是项目目录
if [[ "$0" == "$source.sh" || "$0" == "./$source.sh" ]]
then
   echo "当前执行目录为bin目录 🚗"
   exec_project ..
else
   echo "当前执行目录为工程目录 🛹"
   exec_project .
fi

git add .
git commit -m 'deploy to https://wuxin0011.github.io 🎉'
git push