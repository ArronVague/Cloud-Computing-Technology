---
title: SQL 语法
toc: true
date: 2024-03-23 21:14:05
categories:
- work
- database systems
tags:
- database systems
- sql
---

## 一、基础

数据库创建与使用：

```sql
CREATE DATABASE test;
USE test;
```

<!--more-->

## 二、创建表

```sql
CREATE TABLE mytable (
  # int 类型，不为空，自增
  id INT NOT NULL AUTO_INCREMENT,
  # int 类型，不可为空，默认值为 1，不为空
  col1 INT NOT NULL DEFAULT 1,
  # 变长字符串类型，最长为 45 个字符，可以为空
  col2 VARCHAR(45) NULL,
  # 日期类型，可为空
  col3 DATE NULL,
  # 设置主键为 id
  PRIMARY KEY (`id`));
```

