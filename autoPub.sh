#!/bin/bash

# Created By: Gavin
# Created At: 2016.8.30

echo "autoPub start"
echo "该脚本会创建一个新分支，以后再该分支得到所有的html文件"

read -p "请输入新分支名称：" branchName

if [ ! "$branchName" = "" ]
then
    
    echo "$branchName"

    # 1. 切换到新分支
    switchBrand="git checkout -b ${branchName:-gh-pages}"

    # 2. 将_book文件夹内的文件全部移除来
    moveHTMLToOuter="mv _book/* ./"

    # 3. 将_book、_source文件夹删除
    RmDir="rm -rfi _book _source"

    # 4. git 添加
    GitAdd="git add ."
    GitCommit='git commit -m "f"'

    # 执行
    $switchBrand && $moveHTMLToOuter && $RmDir && $GitAdd && $GitCommit
    echo "执行git push origin $branchName 来提交代码把！"
else 
    echo "分支名为空！"
fi
