---
title: SQL 语法
toc: true
date: 2024-03-23 21:14:05
categories:
  - work
  - review
  - database systems
tags:
  - database systems
  - sql
---

转载自：https://github.com/CyC2018/cs-notes

## 一、基础

数据库创建与使用：

```sql
CREATE DATABASE test;
USE test;
```

<!--more-->

- 库级操作：需要带上 DATABASE 字段，再写库名
- 表级操作：需要带上 TABLE 字段，再写表名
- 行级操作：只需写表名

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

## 四、插入

普通插入

```sql
INSERT INTO mytable(col1, col2)
VALUES(val1, val2);
```

## 五、更新

```sql
UPDATE mytable
SET col = val
WHERE id = 1;
```

## 六、删除

```sql
DELETE FROM mytable
WHERE id = 1;
```

## 七、查询

### DISTINCT

相同值只会出现一次。它作用于所有列，也就是说所有列的值都相同才算相同。

```sql
SELECT DISTINCT col1, col2
FROM mytable;
```

### LIMIT

限制返回的行数。可以有两个参数，第一个参数为偏移（即跳过多少行）；第二个参数为返回的总行数。

返回前 5 行：

```sql
SELECT *
FROM mytable
LIMIT 5;
```

```mysql
SELECT *
FROM mytable
LIMIT 0, 5;
```

返回第 3 ~ 5 行：

```sql
SELECT *
FROM mytable
LIMIT 2, 3;
```

在 MySQL 中，`OFFSET` 和 `LIMIT` 是两个用于限制查询结果的关键字，常常和 `SELECT` 语句一起使用。它们可以让你控制查询返回的行的数量，以及从哪一行开始返回。

1. `LIMIT`：这个关键字用于限制查询返回的行数。例如，`SELECT * FROM table LIMIT 5;` 这个查询将只返回表中的前5行。
2. `OFFSET`：这个关键字用于指定从哪一行开始返回。例如，`SELECT * FROM table LIMIT 5 OFFSET 10;` 这个查询将跳过前10行，然后返回接下来的5行。

`OFFSET` 和 `LIMIT` 经常一起使用，用于实现分页查询。例如，如果每页显示10行，那么第一页的查询可以是 `SELECT * FROM table LIMIT 10 OFFSET 0;`，第二页的查询可以是 `SELECT * FROM table LIMIT 10 OFFSET 10;`，以此类推。

需要注意的是，虽然 `OFFSET` 和 `LIMIT` 可以很方便地实现分页查询，但如果表的行数非常多，且需要查询的页数较大，使用 `OFFSET` 可能会导致性能问题。这是因为 MySQL 需要扫描从第一行到 `OFFSET` 指定的行。在这种情况下，可能需要使用其他方法来优化分页查询，例如记住上一页的最后一行的 ID，然后在下一页的查询中使用这个 ID 来限制结果。

## 十、通配符

通配符也是用在过滤语句中，但它只能用于文本字段。

- **%** 匹配 >=0 个任意字符；
- **\_** 匹配 ==1 个任意字符；
- **[ ]** 可以匹配集合内的字符，例如 [ab] 将匹配字符 a 或者 b。用脱字符 ^ 可以对其进行否定，也就是不匹配集合内的字符。

使用 Like 来进行通配符匹配。

```sql
SELECT *
FROM mytable
WHERE col LIKE '[^AB]%'; -- 不以 A 和 B 开头的任意文本
```

通配符位于开头处匹配会非常慢。

## 十二、函数

各个 DBMS 的函数都是不相同的，因此不可移植，以下主要是 MySQL 的函数。

### 汇总

|  函 数  |      说 明       |
| :-----: | :--------------: |
|  AVG()  | 返回某列的平均值 |
| COUNT() |  返回某列的行数  |
|  MAX()  | 返回某列的最大值 |
|  MIN()  | 返回某列的最小值 |
|  SUM()  |  返回某列值之和  |

AVG() 会忽略 NULL 行。

使用 DISTINCT 可以汇总不同的值。

```sql
SELECT AVG(DISTINCT col1) AS avg_col
FROM mytable;
```

## 十五、连接

连接用于连接多个表，使用 JOIN 关键字，并且条件语句使用 ON 而不是 WHERE。

连接可以替换子查询，并且比子查询的效率一般会更快。

可以用 AS 给列名、计算字段和表名取别名，给表名取别名是为了简化 SQL 语句以及连接相同表。

### 内连接

内连接又称等值连接，使用 INNER JOIN 关键字。

```sql
SELECT A.value, B.value
FROM tablea AS A INNER JOIN tableb AS B
ON A.key = B.key;
```

可以不明确使用 INNER JOIN，而使用普通查询并在 WHERE 中将两个表中要连接的列用等值方法连接起来。

```sql
SELECT A.value, B.value
FROM tablea AS A, tableb AS B
WHERE A.key = B.key;
```

### 自连接

自连接可以看成内连接的一种，只是连接的表是自身而已。

一张员工表，包含员工姓名和员工所属部门，要找出与 Jim 处在同一部门的所有员工姓名。

```sql
SELECT e1.name
FROM employee AS e1 INNER JOIN employee AS e2
ON e1.department = e2.department
      AND e2.name = "Jim";
```

### 自然连接

自然连接是把同名列通过等值测试连接起来的，同名列可以有多个。

内连接和自然连接的区别：内连接提供连接的列，而自然连接自动连接所有同名列。

```sql
SELECT A.value, B.value
FROM tablea AS A NATURAL JOIN tableb AS B;
```

### 外连接

外连接保留了没有关联的那些行。分为左外连接，右外连接以及全外连接，**左外连接就是保留左表没有关联的行**。

检索所有顾客的订单信息，包括还没有订单信息的顾客。

```sql
SELECT Customers.cust_id, Customer.cust_name, Orders.order_id
FROM Customers LEFT OUTER JOIN Orders
ON Customers.cust_id = Orders.cust_id;
```

customers 表：

| cust_id | cust_name |
| :-----: | :-------: |
|    1    |     a     |
|    2    |     b     |
|    3    |     c     |

orders 表：

| order_id | cust_id |
| :------: | :-----: |
|    1     |    1    |
|    2     |    1    |
|    3     |    3    |
|    4     |    3    |

结果：

| cust_id | cust_name | order_id |
| :-----: | :-------: | :------: |
|    1    |     a     |    1     |
|    1    |     a     |    2     |
|    3    |     c     |    3     |
|    3    |     c     |    4     |
|    2    |     b     |   Null   |
