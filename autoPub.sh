#!/bin/bash

# Created By: Gavin
# Created At: 2016.8.30

brandName="gh-pages"
echo "autoPub start"
echo "该脚本会删除${brandName}分支并重新创建"

read -p "继续执行？(y/n)" going

if [ ! "$going" = "y" ]
then

    echo "开始删除${brandName}分支"
    deleteGhPages="git branch -D ${brandName}"
    $deleteGhPages
    echo "删除${brandName}分支完成"

    # 1. 切换到新分支
    switchBrand="git checkout -b ${brandName}"

    # 2. 将_book文件夹内的文件全部移除来
    moveHTMLToOuter="mv _book/* ./"

    # 3. 将_book、_source文件夹删除
    # 该步骤不进行也可以
    RmDir="rm -rfi _book _source"

    # 4. git 添加
    GitAdd="git add ."
    GitCommit='git commit -m "f"'

    # 执行
    $switchBrand && $moveHTMLToOuter && $RmDir && $GitAdd && $GitCommit

    # 代码提交
    push="git push origin ${brandName} -f"
    $push

else
    echo "脚本已取消"
fi
