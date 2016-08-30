#!/bin/bash

# Created By: Gavin
# Created At: 2016.8.30

echo "autoPub start"

echo "请输入你的名字："

# 变量定义
# 变量名与值之间不能有空格
a="heiheihei"

branchName="gh-pages"

# 变量销毁
unset a

# 1. 切换到新分支
cmd_1="git checkout $branchName"
$cmd_1

# 2. 将_book文件夹内的文件全部移除来
cmd_2="mv _book/* ./"
$cmd_2

# 3. 将_book文件夹删除
cmd_3="rmdir _book"
$cmd_3

# 4. 进入_source，删除全部
cmd_4="cd _source"
$cmd_4

# 5.

# 获取用户输入的值
# read name
