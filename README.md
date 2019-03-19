# NDSLVim

[TOC]

## 简介

这是一款具有极强针对性的Vim配置，可以作为C-family、HTML、CSS、JS这几种语言的开发编辑器。该配置使用尽可能少的插件，在保证Vim本身作为一个文本编辑器的简洁、迅速特性的前提下，使其功能向IDE（除编译、调试功能）靠拢，包括语法检查、文件导航等。

## 安装

### 系统环境

需要`nvim 3.0`及以上版本，`nodejs`，`yarn`，`gcc 7.2`及以上版本并安装以下库：

```shell
sudo apt install cmake libncurses-dev python3-pip python3-dev
```

### 安装

请不要使用`sudo`来启动脚本！

```shell
# 将$NDSLVIM_BASE替换为仓库的路径
cd $NDSLVIM_BASE && ./install.sh

# 或者通常情况下，你需要一个代理来避免网络错误
cd $NDSLVIM_BASE && proxychains ./install.sh
```

## 快捷键

|键名|操作|
|----|----|
|`<F3>`|是否显示换行符|
|`<F4>`|是否折叠行|
|`<F5>`|是否开启PASTE模式|
|`<F6>`|是否开启语法高亮|
|`<ctrl-c>`|相当于`<ESC>`，任何模式下都有效|
|`,/`|取消高亮（通常是指搜索的高亮）|
|`;`|相当于按下了`:`，省去按住shift的烦恼|
|上下左右键|在窗口中上下左右导航，适用于split党|
|`,<number>`|跳到其中一个tab，适用于tabedit党|
|`<ctrl-t>`|打开一个新的tab|
|`<ctrl-n>`|打开目录树|
|`<ctrl-f>`|打开文件搜索和导航功能|
|`<ctrl-e>`|emmet代码扩展|
|`<ctrl-h>`|前往前一个tab|
|`<ctrl-l>`|前往后一个tab|
|`{n},c<space>`|（反）注释n行（n可选），或选中区域|
|`,<space>`|清除文件中多余的空格|
|`,n`|前往文件中下一个被修改过的地方（基于git diff）|
|`,N`|前往文件中上一个被修改过的地方（基于git diff）|
|`gd`|go to definitions|
|`gh`|go to references|
|`<ctrl-j>`和`<ctrl-k>`|补全后可以在snippet内部进行跳转|

## 插件说明

> 使用vim-plug作为插件管理工具；以下插件均可以使用`:help <插件名>`来获取更多帮助（忽略大小写）

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

### Language Support

使用`coc.nvim`来作为标准的Language Client，使用`ccls`作为C语言补全工具，你可以
自行添加其他的语言功能，详情请见![coc.nvim](https://github.com/neoclide/coc.nvim)。
另外，`ccls`可以使用额外的项目级别的配置来自定义你自己的项目编译方式，详情见
![ccls](https://github.com/MaskRay/ccls)

你也可以使用如下命令来屏蔽语言支持功能：

```shell
alias vimp="vim --cmd \"let g:ignore_language_support=1\""
```

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
