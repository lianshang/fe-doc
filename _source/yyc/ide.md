
# 1、命令行工具：term2
官网：[http://www.iterm2.com/](http://www.iterm2.com/)

虽然mac自带终端，也不是很难看，但功能不是很多，term2是mac上非常好的一款命令行工具，可以完全替代系统自带的终端。term2具有很多优点：

	1:选中即复制，不用command＋c了；
	2:全文查找并高亮显示：command＋f
	3:方便的分屏显示：垂直分屏：command＋d，水平分屏：command＋shift＋d
	4:自定义快捷键
	5:强大的节目自定义，设置配色方案，透明背景，等等

此外还有其它有点，我暂时没用到。

# 2、终端软件包管理工具：brew
官网：[http://brew.sh/](http://brew.sh/)

在使用的过程中，可能需要安装Xcode，按要求安装即可。

就和ubuntu下的apt－get功能类似，可以很方便的管理软件。
安装方式，直接在终端里输入：
<pre>
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
</pre>
运行完即可安装软件了，安装方式和apt－get相同：
<pre>
sudo brew install xxx
</pre>

# 3、终端复用工具：tmux
官网：[http://tmux.github.io/](http://tmux.github.io/)

可以直接通过brew安装：

	sudo brew install tmux

tmux强大之处不在多说，谁用谁知道。

有时候，安装tmux的时候会出现各种各样的问题，比如：


	dyld: Library not loaded: /usr/local/lib/libevent-2.0.5.dylib
	Referenced from: /usr/local/Cellar/tmux/1.9a/bin/tmux
	Reason: image not found
	Trace/BPT trap: 5


也不知道出的什么错误，干脆下载重新安装，可是又出现下面的问题：


	Error: You must `brew link libevent' before tmux can be installed`


当你执行上面代码的时候，又出现问题：


	Linking /usr/local/Cellar/libevent/2.0.22...
	Error: Could not symlink lib/libevent/libevent.pc
	/usr/local/lib/libevent is not writable.


上面的问题着实头疼，解决方法如下：


	sudo chown yangyoucun /usr/local/lib/pkgconfig


这样即可，然后在进行：


	brew link libevent
	brew install tmux


# 4、安装node、npm、git
直接通过brew安装即可，我没有尝试，我是通过官网下载的程序安装的。安装node自带npm，git貌似系统自带。

或者直接去官网下载安装：node官网：[nodejs](https://nodejs.org/)

# 5、vim包管理工具vunble
接下来就是配置vim编辑器，首先是Vundle,即bundle，vim的插件管理工具
github: [https://github.com/VundleVim/Vundle.vim](https://github.com/VundleVim/Vundle.vim)

安装vunble：

	$ git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim


然后，在～目录下新建.vimrc，输入：

	set nocompatible             
	filetype off              
	set rtp+=~/.vim/bundle/Vundle.vim
	call vundle#begin()
	Plugin 'VundleVim/Vundle.vim'


然后，退出vim的编辑模式，输入：BunbleInstall（注意前面要有冒号），此时插件开始安装。

# 6、配置vim
前面已经安装了vunble，那么其他的插件安装变得更简单，先来进行一些简单的vim配置：

	set nu              " 显示行号
	syntax on           " 语法高亮
	autocmd InsertLeave * se nocul  " 用浅色高亮当前行
	autocmd InsertEnter * se cul    " 用浅色高亮当前行
	set ruler           " 显示标尺
	colorscheme molokai " 设置配色方案 molokai
	set autoindent      " 设置自动缩进
	set backspace=2
	set nowrap          " 不自动换行
	set tabstop=4       " tab相当于四个字符
	set softtabstop=4   " 按一次tab前进4个字符
	set expandtab       " 用空格代替tab
	set ai!             " 设置自动缩进
	set cindent shiftwidth=4 " 缩进的字符个数
	set hlsearch        " 高亮搜索的关键字
	set ignorecase      " 搜索忽略大小写
	set history=100     " 设置命令历史行数


# 7、vim配色方案molokai
github：[https://github.com/tomasr/molokai](https://github.com/tomasr/molokai)

配置很简单，在～/.vim/colors下，复制进去molokai.vim即可。

这里我找到一个适合前端的vim配置文件，点击这里：[myVimrc](https://github.com/Gavin-YYC/vimrc)，需要提前安装vunble。

# 8、vim安装插件
通过vunble安装：
在.vimrc中，输入：Bundle 'mattn/emmet-vim'，然后退出编辑模式，输入：BunbleInstall即可，如果没有，则推出vim重新进入，在执行安装命令。

# 9、zsh安装on my zsh
有时候会发现执行命令时前面一串系统自带的字符串很长，想移去，此时久可以用zsh

	wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh


zsh的强大之处在于可以自定义快捷键。比我，我要执行webpack，但是每次都要输入webpack太麻烦了，就算为了节省力气，使用webpack －－watch，也要输入很长的命令，而通过wp则简单的很：

只需在～/.zshrc中输入以下规则即可。

	alias wp='webpack'
	alias wpw='webpack --progress --colors --watch'
	alias wps='webpack-dev-server --progress --colors'


这样，我们直接在命令行中输入wp就是执行的webpack，输入wpw，即启动了观察模式，输入wps，则启动了服务器，是不是很简单？！

# 10、autojump

和zsh结合使用，功能更强大，可实现目录的快速跳转


	brew install autojump


然后，在`~/.zshrc`中添加如下语句：


	[[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && . $(brew --prefix)/etc/profile.d/autojump.sh


这样，autojump变回记录你使用cd进入过的用户名，那之后，你想进入某个目录，最少只需敲两个字母：


	//j 是快捷键，autojump的简单写法
	j d
	//d 表示之前cd进入过Document


# 11、fis安装

fis是前端开发的自动化工具，因项目中需要使用fis2，所以在这里也要安装fis。fis直接通过npm安装即可：

官网：[fis2](http://fex.baidu.com/fis-site/index.html)


	npm install -g fis


当然，安装还是比较简单的，能否执行成功需要跑一遍官方的例子进行测试：


	//clone 代码
	git clone https://github.com/hefangshi/fis-quickstart-demo.git

	//启动server
	fis server start

	//此时，如果提示安装java，可去下载java，也可以不用安装java，使用node版本
	fis server start --type node

	//浏览器会自动打开，但是并没有目录文件，因为还没发布
	cd fis-quickstart-demo
	fis release

	//此时，浏览器应该显示todo示例了，到此，fis也算安装成功。


# 12、fis+php环境配置，（fis-plus）

FIS-PLUS 是基于 FIS，应用于后端是 PHP，模板是 Smarty 的场景。现在被大多数百度产品使用。

安装fis-plus，需要提前安装以下环境：node、jre、php-cgi，node之前已经安装，下面是jre和php-cgi的安装：

**安装java**

jre：网址：[下载适用于 Mac OS X 的 Java](http://www.java.com/zh_CN/download/mac_download.jsp)，或者去网盘下载：链接: http://pan.baidu.com/s/1eQMNAsa 密码: w4kv。然后，按要求安装即可，安装完成后，会自动弹出一个页面。

chrome不支持java的插件，链接复制到safari浏览器中进行验证也可以。另外，下载60M的那个java文件应该不行，最好去官网下载220M的那个。[地址](http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html)

<a href="http://youthol.top/wp-content/uploads/2016/01/屏幕快照-2016-01-21-上午11.50.00.png"><img src="http://youthol.top/wp-content/uploads/2016/01/屏幕快照-2016-01-21-上午11.50.00.png" alt="屏幕快照 2016-01-21 上午11.50.00" width="818" height="346" class="aligncenter size-full wp-image-1881" /></a>

**安装fis-plus**

	npm install -g fis-plus

安装需要花些时间，完成后，执行`fisp -v`，看到版本号，即安装成功。

![pic](http://youthol.top/wp-content/uploads/2016/01/屏幕快照-2016-01-21-上午11.20.49.png)

**安装php-cgi**

直接通过brew安装即可：

	brew install php55 --with-cgi


如果提示找不到php55，则先执行下面一句，在执行上面的安装php55


	//先执行
	brew tap homebrew/homebrew-php
	//然后执行，需要花费些时间，耐心等待
	brew install php55 --with-cgi


**安装lights**

lights 是 fis 提供的包管理工具，托管了 fis 所有资源。是使用 fis 的时候，必不可少的利器。


	npm install -g lights


**使用官方示例，看是否成功跑起来**


	//下载demo
	fisp init pc-demo

	//执行这一步，要不然不成功！
	fisp server init

	//发布
	cd pc-demo
	fisp release -r common
	fisp release -r home

	//预览，启动服务器
	fisp server start


> 如果提示没有php-cgi的环境，而又一直装不好，可以下载这个文件[php-mac](http://pan.baidu.com/s/1dEk6pqx)，解压以后，把lib/bin/php-cgi 复制到/usr/local/bin目录下即可。



# 13、编辑器：phpStorm、sublime

编辑器按照个人喜好安装，如果你喜欢sublime，则安装sublime即可，也可以使用phpStorm或者vim，vim配置上面一说说过了。

sublime官网：[sublimetext3](http://www.sublimetext.com/3)

phpstorm官网：[phpstorm](http://www.jetbrains.com/phpstorm/) 或者：链接: http://pan.baidu.com/s/1eQP576y 密码: y75e

好像都是免费30天，其他需要破解的话可去网上搜索。这里有一个简单的激活phpstorm的方法，在注册的时候选择License server，然后输入：http://idea.lanyus.com/，点击OK即可。

sublime3 有个破解版，内含注册码：[点击下载](http://pan.baidu.com/s/1hrjeo7M)

# 14、tree

tree插件可以显示当前的目录结构：


	brew install tree

![pic](http://youthol.top/wp-content/uploads/2016/01/屏幕快照-2016-01-21-下午1.55.33.png)


# 15、node版本管理 n

node版本更新迭代很快，版本就会有很多，如何切换版本就成了大问题，所以可以使用`n`来进行node版本的管理


	sudo npm install -g n


命令如下：


	//查看版本
	n

	//安装制定版本
	n 0.11.12

	//安装最新版本
	n lastet

	//安装稳定版本
	n stable

	//安装lts版本
	n lts a

	//删除版本
	n rm 0.11.12
