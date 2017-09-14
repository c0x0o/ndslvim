# NDSLVim

## 简介

这是一款具有极强针对性的Vim配置，可以作为C-family、HTML、CSS、JS这几种语言的开发编辑器。该配置使用尽可能少的插件，在保证Vim本身作为一个文本编辑器的简洁、迅速特性的前提下，使其功能向IDE（除编译、调试功能）靠拢，包括语法检查、文件导航等。

## 安装环境

### 系统环境

首先，请保证系统中安装了Clang，且版本在3.9以上，这一要求是为了代码补全功能`YouCompleteMe`可以顺利使用。

```shell
# 保证版本在3.9以上
clang --version
```

否则，请到[Clang的官网](http://releases.llvm.org/download.html)上下载最新的版本（目前是4.0.1）。

如果你是Ubuntu的用户（我最爱的Linux发行版之一），可以使用以下命令：

```shell
# for ubuntu user
sudo apt install clang-3.9 clang-3.9-dev
alias clang="clang-3.9"
```

然后，我们还需要安装python及其开发者包：

```shell
sudo apt install python python3 python-dev python3-dev
```

对于Ubuntu14.04的用户，你或许还需要检查一下python3的版本是否高于3.3。

接下来，由于编译YouCompleteMe插件需要你的C++编译器完整的支持c++11特性，如果你使用GNU gcc作为你的编译工具请确保它的版本在4.9及以上。

```shell
g++ --version
```

如果你是ubuntu14.04的用户，升级gcc的步骤可以参考[这篇文章](http://www.linuxidc.com/Linux/2016-02/128327.htm)

### Vim

由于插件的限制，需要对vim本身的版本进行一下检查。如果你不打算使用插件，而是仅仅使用Vim的基础配置，可以跳过这步。

```shell
# 检查版本，只看前两行
# 第一行代表了Vim的主版本号，请确认它大于7.4
# 第二行代表了补丁号，形式为x-xxxx，请确保短线后面的数字大于1578
vim --version

# 检查接口
# 请观察输出结果中是否含有'+python'或'+python3'字样，确保它们存在
vim --version | grep "python"
```

如果你的Vim没有满足第一个要求，你将不能使用代码补全和语法检查功能。如果你没有满足第二个要求，那么悲剧了，你需要重新自行编译Vim或者下载满足要求的Vim。

Tips: ubuntu14.04默认的Vim不满足版本要求，但是可以使用除代码检查和补全之外的其它功能。想要升级的用户，可以参考[这篇文章](http://blog.csdn.net/gatieme/article/details/52752070)


## 安装

首先使用`git`将本仓库克隆至本地。

执行如下命令：

```shell
#请将${repo_path}替换为仓库路径
ln -s ${repo_path} ~/.vim
ln -s ${repo_path}/vimrc ~/.vimrc
ln -s ${repo_path}/vimrc.bundles ~/.vimrc.bundles
```

此时，你已经可以使用Vim的基础配置了（包含各类不涉及插件的快捷键）。

接着启动Vim，然后输入`:PlugInstall`，等待安装完成。由于插件安装涉及从github克隆插件仓库，这将花费大量的时间（约2～3个小时，取决于你的网速和人品），没有什么特别好的方法，也许后面我会提供一个镜像供大家下载。

如果你顺利的完成了插件的下载，还有最后一项工作，编译YouCompleteMe：

```shell
cd ~/.vim/bundle/YouCompleteMe && python ./install.py --clang-completer --tern-completer --system-libclang && cd -
```

注意，在执行`install.py`时，如果你的Vim之前显示的是`+ Python`（即拥有python2支持），请使用pyhton2执行该文件，否则请使用python3.3以上的版本执行。

## 快捷键

|键名|操作|
|----|----|
|`<F3>`|是否显示换行符|
|`<F4>`|是否折叠行|
|`<F5>`|是否开启PASTE模式|
|`<F6>`|是否开启语法高亮|
|`;;`|相当于`<ESC>`，任何模式下都有效|
|`,/`|取消高亮（通常是指搜索的高亮）|
|`;`|相当于按下了`:`，省去按住shift的烦恼|
|上下左右键|在窗口中上下左右导航，适用于split党|
|`,<number>`|跳到其中一个tab，适用于tabedit党|
|`,tf`|前往第一个tab|
|`,tl`|前往最后一个tab|
|`,tm`|相当于`:tabmove`|
|`,tc`|相当于`:tabclose`|
|`ctrl-n`|打开目录树|
|`,f`|打开文件搜索和导航功能|
|`ctrl-e`|emmet代码扩展|
|`{n},c<space>`|（反）注释n行（n可选），或选中区域|
|`,<space>`|清除文件中多余的空格|
|`<Ctrl-j>`|触发语义补全菜单,在补全函数的时候非常有用|
|`,n`|前往文件中下一个被修改过的地方（基于git diff）|
|`,N`|前往文件中上一个被修改过的地方（基于GIT DIFF）|

## 插件说明

> 使用vim-plug作为插件管理工具
> 以下插件均可以使用`:help <插件名>`来获取更多帮助（忽略大小写）

### airline

一个非常友好的底部状态栏，显示诸如文件类型、行数、文件是否已保存等信息

### ctrlP

用于在当前项目、缓冲区、编辑记录中快速寻找和打开文件，拥有自己的LRU算法和缓冲区管理算法，免去了用户自己去关闭缓冲区的烦恼。

当前项目的定义是：
1. 使用距离编辑文件最近的.git(.svn等)所在目录作为项目根目录；
2. 若第一条不符合，则使用正在编辑文件所在的目录作为根目录。你可以直接在项目根目录下直接启动vim来指定根目录。

使用`,f`来打开文件搜索功能

### TheNerdTree

一个目录树显示插件，还以进行简单的文件系统操作（创建，删除等）。

使用ctrl-n来打开或关闭，使用:help NERDTree来获取更多帮助

### YouCompleteMe

非常强大的代码补全和语法检查工具，支持*非常多*的语言。编译型语言的语法检查配置文件位于`~/.vim/.ycm_extra_conf.py`，它通过FlagsForFile函数来导出编译当前文件所需要的编译选项，YouCompleteMe主要通过其中的-I选项来搜索头文件。在搜索当前文件所引用的头文件时，默认的配置文件遵循以下的准则：

1. 搜索系统路径`/usr/include`，`/usr/lib`
2. 搜索当前路径
3. 搜索当前文件的所有祖先路径（包括当前路径），直到找到最近的在`INCLUDE_DIRECTORIES`中定义的目录（每一种只要存在就会被添加）
4. 如果当前文件同级路径中存在其它目录（`INCLUDE_DIRECTORIES`定义的目录除外），那么在每一个目录中再次应用本准则；这一条主要用于处理module,比如我们可能会在`src`目录中添加若干第三方模块，那么我们需要把第三方模块的头文件也加入搜索路径。

另外，现在默认配置会根据文件后缀名来自动判断使用哪一种语言规范，默认`.c`和`.cc`文件使用`c99`规范来进行语法检查，而`.cpp`和`.cxx`使用`c++11`规范。

如果上述行为不符合你的项目，你可以参考`~/.vim/.ycm_extra_conf.py`中的`FlagsForFile`函数来自行编写新的行为（注意，`FlagsForFile`函数是必需的）。

使用`<tab>`键来选择。

### emmet

Web开发中非常著名的编码辅助工具，其使用方式可以参见[emmet的官方文档](https://docs.emmet.io/)。

使用`ctrl-e`来触发代码扩展操作。

### nerdCommenter

快速代码注释工具，使用`,c<space>`来切换代码的注释状态（普通和选择模式下）。

### vim-trailing-whitespace

用红色标出多余的空格，可以使用`,<space>`来全局清除多余的空格。

### delitimate

帮你自动补全成对括号之类的符号

### matchit

增强`%`匹配跳转命令的功能，使它可以配对诸如HTML、LaTeX等标签语，甚至可以用来匹配`begin end`这样的配对

### 样式性插件

1. rainbow\_parenthese：彩色括号
2. vim-colors-solarized：全局样式，solarized，默认
3. molokai：全局样式

### git-tools

#### vim-gitgutter

用于显示文件的修改状态的插件

#### vim-fugitive

Vim的git-wrapper插件，可以在Vim中轻松地执行各种git命令。

1. 使用`:Gstatus`来执行`git status`，并且你可以在对应行上按`p`或`-`来分别执行`git add`或`git reset`
2. 然后使用`:Gcommit`来执行`git commit`
3. 使用`:Gmove`来执行`git mv`
4. 使用`:Gdelete`来执行`git rm`
5. 使用`:Ggrep`来执行`git grep`
6. 使用`:Gdiff`来执行`git diff`，个人感觉不好用，有gitgutter就够用了
7. 使用`:Gread`来执行`git checkout --filename`

使用`:help fugitive`来获取更多帮助

## 致谢

感谢[k-vim](https://github.com/wklken/k-vim)带给我的启发，还有[VimAwesome](http://vimawesome.com)这个超棒插件站。
