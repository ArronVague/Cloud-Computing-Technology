---
title: Linux
toc: true
date: 2024-03-25 10:44:17
categories:
  - work
  - review
  - operating systems
tags:
  - linux
---

## 常用的 shell 命令

### 文件操作

- `ls`: 列出目录中的文件和子目录
- `cd`: 更改当前目录
- `pwd`: 打印当前工作目录
- `cp`: 复制文件或目录
- `mv`: 移动或重命名文件或目录
- `rm`: 删除文件或目录
- `touch`: 创建一个新的空文件
- `cat`: 查看文件内容
- `more` or `less`: 分页查看文件内容
- `head` or `tail`: 查看文件的开始部分或结束部分

<!--more-->

### 文本处理

- `grep`: 在文本中搜索匹配的字符串
- `sort`: 对文本行进行排序
- `cut`: 从文本行中剪切字段
- `awk`: 对文本进行复杂的处理
- `sed`: 对文本进行流编辑

#### grep

`grep`命令用于在文本中搜索匹配的字符串。它的基本语法如下：

```shell
grep [options] pattern [file...]
```

这里，`pattern`是你要搜索的字符串，`file`是要搜索的文件。如果没有指定文件，`grep`会从标准输入读取数据。

例如，如果你想要在`file.txt`中搜索字符串`hello`，你可以这样做：

```shell
grep 'hello' file.txt
```

`grep`有很多选项，例如：

- `-i`：忽略大小写
- `-v`：反向匹配，即只输出不匹配的行
- `-r`或`-R`：递归搜索目录
- `-l`：只输出包含匹配的文件名
- `-n`：输出匹配的行号

#### cut

`cut`命令用于从文本行中剪切字段。它的基本语法如下：

```shell
cut [options] [file...]
```

`cut`命令主要有两种模式：字符模式和字段模式。字符模式使用`-c`选项，字段模式使用`-f`选项。

例如，如果你想要从每行中剪切第 2 到第 5 个字符，你可以这样做：

```shell
cut -c 2-5 file.txt
```

如果你的数据是以制表符分隔的，你可以使用`-f`选项来剪切字段。例如，如果你想要剪切第 1 和第 3 个字段，你可以这样做：

```shell
cut -f 1,3 file.txt
```

默认情况下，`cut`使用制表符作为分隔符。如果你的数据使用其他字符（如逗号）作为分隔符，你可以使用`-d`选项来指定分隔符。例如：

```shell
cut -d ',' -f 1,3 file.txt
```

### 进程管理

- `ps`: 显示当前进程状态
- `top`: 动态显示进程状态
- `kill`: 结束进程
- `bg`: 在后台运行进程
- `fg`: 在前台运行进程

### 权限管理

- `chmod`: 改变文件或目录的权限
- `chown`: 改变文件或目录的所有者
- `chgrp`: 改变文件或目录的所属组

可以使用数字来表示权限。每种权限都对应一个数字：4 表示读，2 表示写，1 表示执行。要设置权限，只需将这些数字加起来。3 个位分别代表**所有者/组/其他用户权限**。例如，如果你想要设置所有者的权限为读/写（4+2=6），组的权限为读（4），其他用户的权限为无（0），你可以这样做：

```shell
chmod 640 file.txt
```

### 网络命令

- `ping`: 检查网络连接
- `netstat`: 显示网络状态
- `ssh`: 远程登录
- `scp`: 远程复制文件
- `curl` or `wget`: 下载网络内容

### 系统信息

- `date`: 显示或设置系统日期和时间
- `df`: 显示磁盘空间使用情况
- `du`: 显示目录或文件的磁盘使用情况
- `free`: 显示内存使用情况
- `uname`: 显示操作系统信息