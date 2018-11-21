# NDSLVim

[TOC]

## 简介

这是一款具有极强针对性的Vim配置，可以作为C-family、HTML、CSS、JS这几种语言的开发编辑器。该配置使用尽可能少的插件，在保证Vim本身作为一个文本编辑器的简洁、迅速特性的前提下，使其功能向IDE（除编译、调试功能）靠拢，包括语法检查、文件导航等。

## 安装

### 系统环境

#### python

我们需要安装python及其包管理工具（如果你能确定编译vim时提供了对应版本的python支持，那么可以只安装对应版本即可，建议使用python3）：

```shell
sudo apt install python python3 python3-pip python-pip
```

如果你是ubuntu的用户，升级gcc的步骤可以参考[这篇文章](http://www.linuxidc.com/Linux/2016-02/128327.htm)

#### node

如果你是一个JavaScript开发者并且希望使用相应的代码补全功能，那么你还需要在系统中安装Node。详细的安装步骤可以参看[官网的安装说明](https://nodejs.org/en/download/)，或者[使用包管理工具来安装](https://nodejs.org/en/download/package-manager/)。

#### Vim

考虑到插件更新状况和性能原因，目前本仓库从Vim迁移至![neovim](https://github.com/neovim/neovim)，计划在v2.0发布后开始兼容Vim 8.1及以上版本。要使用完整的语言支持功能，请下载最新版本的neovim（^v0.3.0）。

## 安装

```shell
# 将$NDSLVIM_BASE替换为仓库的路径
cd $NDSLVIM_BASE && ./install.sh
```

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

> 使用cquery，LanguageClient-neovim，ncm2的组合替代了原有的YCM

`Language Support`功能使用LanguageClient-neovim替代了原有的YCM，来作为新的语法支持工具。目前只实现了对C-family语言的支持，该支持基于`compile_commands.json`实现，具体的生成`compile_commands.json`文件的方法，请参考你所使用的编译工具链的说明（主流的编译器或工具链都有对应的工具支持，如cmake，clang，gcc等）。

鉴于cquery在超大的C-family项目中内存占用巨大，启动时间较长（对于完整的chrome项目，内存占用最高可达10G），你可以在启动时增加额外的参数来屏蔽`Language Support特性`：

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
