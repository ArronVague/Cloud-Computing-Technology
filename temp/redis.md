redis

概述

NoSQL 主要存储键值和五种不同类型的值之间的映射。

## 二、数据类型

| 数据类型 |      可以存储的值      |                             操作                             |
| :------: | :--------------------: | :----------------------------------------------------------: |
|  STRING  | 字符串、整数或者浮点数 | 对整个字符串或者字符串的其中一部分执行操作、对整数浮点数执行自增或者自减操作 |
|   LIST   |          列表          | 从两端压入或者弹出元素、对单个或者多个元素进行修剪、只保留一个范围内的元素 |
|   SET    |        无序集合        | 添加、获取、移除单个元素、检查一个元素是否存在于集合中、计算交集、并集、差集、从集合里面随机获取元素 |
|   HASH   | 包含键值对的无序散列表 | 添加、获取、移除单个键值对、获取所有键值对、检查某个键是否存在 |
|   ZSET   |        有序集合        | 添加、获取、删除元素、根据分值范围或者成员来获取元素、计算一个键的排名 |

### STRING

![image-20240327224252800](redis/image-20240327224252800.png)

```shell
> set hello world
OK
> get hello
"world"
> del hello
(integer) 1
> get hello
(nil)
```

###  LIST

![image-20240327224344178](redis/image-20240327224344178.png)

list的返回值integer为list长度。

```shell
> rpush list-key item 
(integer) 1
> rpush list-key item2
(integer) 2
> rpush list-key item
(integer) 3

> lrange list-key 0 -1
1) "item"
2) "item2"
3) "item"

> lindex list-key 1
"item2"

> lpop list-key
"item"

> lrange list-key 0 -1
1) "item2"
2) "item"
```

### SET

![image-20240327224436955](redis/image-20240327224436955.png)

set中的integer指的是成功操作的数量。

```shell
> sadd set-key item
(integer) 1
> sadd set-key item2
(integer) 1
> sadd set-key item3
(integer) 1
> sadd set-key item
(integer) 0

> smembers set-key
1) "item"
2) "item2"
3) "item3"

> sismember set-key item4
(integer) 0
> sismember set-key item
(integer) 1

> srem set-key item2
(integer) 1
> srem set-key item2
(integer) 0

> smembers set-key
1) "item"
2) "item3"
```

### HASH

![image-20240327224754795](redis/image-20240327224754795.png)

hgetall依次返回键值对

```shell
> hset hash-key sub-key1 value1
(integer) 1
> hset hash-key sub-key2 value2
(integer) 1
> hset hash-key sub-key1 value1
(integer) 0

> hgetall hash-key
1) "sub-key1"
2) "value1"
3) "sub-key2"
4) "value2"

> hdel hash-key sub-key2
(integer) 1
> hdel hash-key sub-key2
(integer) 0

> hget hash-key sub-key1
"value1"

> hgetall hash-key
1) "sub-key1"
2) "value1"
```

### ZSET

![image-20240327224925160](redis/image-20240327224925160.png)

```shell
> zadd zset-key 728 member1
(integer) 1
> zadd zset-key 982 member0
(integer) 1
> zadd zset-key 982 member0
(integer) 0

> zrange zset-key 0 -1 withscores
1) "member1"
2) "728"
3) "member0"
4) "982"

> zrangebyscore zset-key 0 800 withscores
1) "member1"
2) "728"

> zrem zset-key member1
(integer) 1
> zrem zset-key member1
(integer) 0

> zrange zset-key 0 -1 withscores
1) "member0"
2) "982"
```

##  三、数据结构

### 字典

Redis的哈希表实现使用了一种叫做"渐进式rehash"的技术。当Redis的哈希表需要扩容或者缩容时，它并不会一次性地将所有的键值对重新哈希到新的哈希表中，而是分多次、渐进地完成这一任务。

以下是Redis渐进式rehash的基本步骤：

1. **分配新哈希表**：当哈希表需要扩容或缩容时，Redis首先会创建一个新的哈希表。新哈希表的大小通常是当前哈希表大小的两倍（扩容）或者当前哈希表大小的一半（缩容）。
2. **渐进式迁移**：每次Redis对哈希表执行添加、删除或查找等操作时，它会顺带地将旧哈希表中的一部分键值对重新哈希到新的哈希表中。这一步是渐进式rehash的核心，通过分摊在每个操作中，避免了一次性rehash带来的大量计算。
3. **切换到新哈希表**：当所有的键值对都被迁移到新的哈希表中后，Redis会释放旧的哈希表，并开始使用新的哈希表。

这种渐进式rehash的方法可以确保即使在哈希表需要进行rehash的时候，Redis仍然能够保持高性能，因为rehash的工作被分摊在了多个操作中，而不是一次性完成。但是，这种方法也会使得rehash过程持续一段时间，具体的时间取决于哈希表的大小和Redis操作的频率。

需要注意的是，虽然Redis使用了渐进式rehash，但是在rehash期间，新旧两个哈希表会同时存在，因此会暂时使用更多的内存。如果内存资源非常紧张，可能需要考虑其他的策略，例如，可以在Redis的空闲时段，例如夜间，手动触发rehash操作。

### 跳跃表

是有序集合的底层实现之一。

跳跃表是基于多指针有序链表实现的，可以看成多个有序链表。

![image-20240327225443124](redis/image-20240327225443124.png)

在查找时，从上层指针开始查找，找到对应的区间之后再到下一层去查找。下图演示了查找 22 的过程。时间复杂度为O(log N)

![image-20240327225454333](redis/image-20240327225454333.png)

与红黑树等平衡树相比，跳跃表具有以下优点：

- 插入速度非常快速，因为不需要进行旋转等操作来维护平衡性；
- 更容易实现；
- 支持无锁操作。

## 四、使用场景

### 计数器

可以对 String 进行自增自减运算，从而实现计数器功能。

Redis 这种内存型数据库的读写性能非常高，很适合存储频繁读写的计数量。

### 缓存

将热点数据放到内存中，设置内存的最大使用量以及淘汰策略来保证缓存的命中率。

### 查找表

例如 DNS 记录就很适合使用 Redis 进行存储。

查找表和缓存类似，也是利用了 Redis 快速的查找特性。但是查找表的内容不能失效，而缓存的内容可以失效，因为缓存不作为可靠的数据来源。

### 消息队列

最好使用 Kafka、RabbitMQ 等消息中间件。

### 分布式锁实现

在分布式场景下，无法使用单机环境下的锁来对多个节点上的进程进行同步。

可以使用 Redis 自带的 SETNX 命令实现分布式锁，除此之外，还可以使用官方提供的 RedLock 分布式锁实现。

1. **SETNX命令**：`SETNX`命令的全称是"SET if Not eXists"，它接受两个参数，一个是键，一个是值。如果键不存在，`SETNX`将键的值设为指定的值，并返回1。如果键已经存在，`SETNX`不做任何操作，并返回0。因此，可以使用`SETNX`命令来尝试获取一个锁，键是锁的名称，值可以是一个标识符，用来标识获取锁的节点。如果`SETNX`返回1，说明成功获取到锁，如果返回0，说明锁已经被其他节点获取。
   1. 这里可能会有问题，如果节点挂掉了，那么这把锁无法释放。
   2. 添加过期时间。
   3. 新的问题：
      1. 过期太早，还在执行就被释放了。
      2. 节点恢复，尝试释放锁，结果释放了其它线程的锁。

   4. 使用看门狗，给锁加唯一id。


1. **RedLock算法**：RedLock是Redis官方提出的一个分布式锁的算法。与`SETNX`不同，RedLock可以在多个Redis实例之间实现真正的分布式锁。RedLock算法的基本思想是，从N个Redis实例中尝试获取锁，只有当超过N/2个Redis实例成功获取到锁时，才认为成功获取到分布式锁。（主从、集群可用）

这些锁是在Redis的数据结构中实现的，具体来说，就是在Redis的键值对中。当一个节点尝试获取锁时，它实际上是在尝试在Redis中创建一个特定的键，如果创建成功，说明该节点成功获取到了锁；如果创建失败，说明锁已经被其他节点获取。当一个节点完成了对共享资源的操作后，它需要删除Redis中对应的键，以释放锁，让其他节点可以获取锁。

### 其它

Set 可以实现交集、并集等操作，从而实现共同好友等功能。

ZSet 可以实现有序性操作，从而实现排行榜等功能。

## 五、Redis 与 Memcached

| 特性       | Redis                                                        | Memcached                                                    |
| ---------- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| 数据类型   | 支持字符串、列表、集合、有序集合和哈希表等多种数据类型       | 仅支持简单的键值对，值通常是字符串                           |
| 数据持久化 | 支持RDB和AOF两种持久化策略，可以定期或者根据数据更新频率将数据写入磁盘 | 不支持持久化，数据存储在内存中，如果服务器关闭，数据会丢失   |
| 分布式支持 | Redis Cluster支持分布式，可以实现数据的分片存储              | 本身不支持分布式，但可以在客户端使用一致性哈希等技术实现分布式存储 |
| 内存管理   | Redis使用了一种称为LRU（Least Recently Used，最近最少使用）的策略来淘汰旧的数据，可以将一些很久没用的value交换到磁盘 | Memcached将内存划分为固定大小的块来存储数据，每个块内存不足的部分会被浪费 |
| 应用场景   | 适用于需要持久化和高性能的场景，以及需要利用其丰富数据类型进行复杂计算的场景 | 适用于简单的缓存场景，以及对数据持久化要求不高，但需要快速访问的场景 |

## 六、键的过期时间

Redis 可以为每个键设置过期时间，当键过期时，会自动删除该键。

对于散列表这种容器，只能为整个键设置过期时间（整个散列表），而不能为键里面的单个元素设置过期时间。

## 七、数据淘汰策略

可以设置内存最大使用量，当内存使用量超出时，会施行数据淘汰策略。

Redis 具体有 6 种淘汰策略：

|      策略       |                         描述                         |
| :-------------: | :--------------------------------------------------: |
|  volatile-lru   | 从已设置过期时间的数据集中挑选最近最少使用的数据淘汰 |
|  volatile-ttl   |   从已设置过期时间的数据集中挑选将要过期的数据淘汰   |
| volatile-random |      从已设置过期时间的数据集中任意选择数据淘汰      |
|   allkeys-lru   |       从所有数据集中挑选最近最少使用的数据淘汰       |
| allkeys-random  |          从所有数据集中任意选择数据进行淘汰          |
|   noeviction    |                     禁止驱逐数据                     |

作为内存数据库，出于对性能和内存消耗的考虑，Redis 的淘汰算法实际实现上并非针对所有 key，而是抽样一小部分并且从中选出被淘汰的 key。

使用 Redis 缓存数据时，为了提高缓存命中率，需要保证缓存数据都是热点数据。可以将内存最大使用量设置为热点数据占用的内存量，然后启用 allkeys-lru 淘汰策略，将最近最少使用的数据淘汰。

Redis 4.0 引入了 volatile-lfu 和 allkeys-lfu 淘汰策略，LFU 策略通过统计访问频率，将访问频率最少的键值对淘汰。

## 八、持久化

Redis 是内存型数据库，为了保证数据在断电后不会丢失，需要将内存中的数据持久化到硬盘上。

### RDB 持久化

一种快照的形式。

将某个时间点的所有数据（内存数据的二进制序列化形式）都存放到硬盘上。

可以将快照复制到其它服务器从而创建具有相同数据的服务器副本。

如果系统发生故障，将会丢失最后一次创建快照之后的数据。

如果数据量很大，保存快照的时间会很长。

fork子进程，由子进程完成持久化。

性能高：快照文件，恢复速度快。

文件紧凑：文件体积较小

### AOF 持久化

将写命令添加到 AOF 文件（Append Only File）的末尾。

使用 AOF 持久化需要设置同步选项，从而确保写命令同步到磁盘文件上的时机。这是因为对文件进行写入并不会马上将内容同步到磁盘上，而是先存储到缓冲区，然后由操作系统决定什么时候同步到磁盘。有以下同步选项：

|       选项       |         同步频率         |
| :--------------: | :----------------------: |
|      always      |     每个写命令都同步     |
| everysec（常用） |       每秒同步一次       |
|        no        | 让操作系统来决定何时同步 |

- always 选项会严重减低服务器的性能；
- everysec 选项比较合适，可以保证系统崩溃时只会丢失一秒左右的数据，并且 Redis 每秒执行一次同步对服务器性能几乎没有任何影响；
- no 选项并不能给服务器性能带来多大的提升，而且也会增加系统崩溃时数据丢失的数量。

AOF缓冲区，AOF重写流程去掉冗余命令

更可靠：记录了每个写命令



## 为什么redis快？

单线程模型

I/O多路复用：监听多个socket，与客户端一一对应。

文件事件分派器（逐个处理，并发转为单线程处理）

- 连接应答处理器
- 命令请求处理器
- 命令回复处理器
- 这几个处理器是并发的

对于文件事件，Redis 使用了一个文件事件分派器。这个分派器的作用就是把套接字上的事件（比如可读事件、可写事件等）和事件的处理器关联起来。当一个事件在套接字上产生时，分派器会调用相应的处理器来处理这个事件。

文件事件分派器包括以下三个主要的处理器：

1. **连接应答处理器**：当一个新的客户端连接到 Redis 服务器时，服务器会使用这个处理器来接受客户端的连接请求，创建一个新的客户端状态，并将这个新的客户端状态添加到服务器的客户端状态列表中。
2. **命令请求处理器**：当 Redis 服务器变得**可读**时（也就是说，有客户端发送了新的命令请求），服务器会使用这个处理器来读取客户端发送的命令请求，然后对命令请求进行解析，并执行相应的命令。
3. **命令回复处理器**：当 Redis 服务器变得可写时（也就是说，有命令的执行结果需要发送给客户端），服务器会使用这个处理器来把命令的执行结果写入到输出缓冲区，并在适当的时候，将输出缓冲区中的内容发送给客户端。

以上就是关于 Redis 文件事件分派器的三个处理器的详细介绍。这个模型使得 Redis 能够以高效、非阻塞的方式来处理多个客户端的请求。

## 过期策略

Redis 提供了几种不同的键过期策略，用于处理设置了过期时间的键。以下是 Redis 的主要过期策略：

1. **惰性删除**：只有当客户端访问一个键时，Redis 才会检查该键是否过期，如果过期则删除。这种策略的优点是节省了 CPU 资源。但是这种策略的缺点是如果过期键数量很大，且这些键都没有被访问，那么这些过期键就会一直存在于内存中，造成内存浪费。
2. **定期删除**：每隔一段时间，程序就对数据库进行一次检查，删除里面的过期键。至于要删除多少过期键，以及要检查多少个数据库，则由算法决定。

实际上，Redis 同时使用了惰性删除和定期删除两种策略：当某个键被访问时，如果该键已过期，那么就会被删除；另一方面，Redis 也会定期地在后台进行扫描，通过一种称为 "渐进式" 的方式来删除过期键，以此来减轻对 CPU 时间的占用。

定期删除可能会造成内存溢出，所以引入了淘汰策略。

## 哨兵机制

人工介入切换主节点可能会导致缓存击穿。

Sentinel监控redis master

多数哨兵节点认为master出现异常。

哨兵选举决定唯一哨兵执行主从切换。

首先拿到半数投票的哨兵成为领导者。

每个哨兵只会投一次票。

## 无效把关

### 缓存击穿

缓存击穿是指一个存在的 key，在缓存过期的一刹那，恰好有大量的请求同时查询这个 key，这时候所有的请求都会击穿缓存直接查询数据库，从而可能对数据库造成很大的压力。

为了防止缓存击穿，可以采取以下措施：

1. **设置热点数据永不过期**：这样可以确保任何时候查询热点数据都会直接从缓存中获取，不会访问数据库（自动任务设置）。
2. **使用互斥锁**：当缓存失效的时候，不是立即去加载数据库，而是先使用缓存工具的某些机制（比如 Redis 的 SETNX 命令）去设置一个锁，当设置成功后，再去加载数据库，否则就等待。这样可以避免大量的并发请求同时去查询数据库。

### 缓存雪崩

缓存雪崩是指在某一个时间段内，缓存中的大部分或全部数据突然失效（比如缓存服务重启，或者大量缓存数据同时过期），导致所有的请求都直接访问数据库，可能会对数据库造成极大的压力，甚至导致数据库崩溃。

这种情况通常发生在大量缓存数据设置了相同的过期时间，当这个时间点到来时，所有的数据都会同时过期，如果此时有大量的请求查询这些数据，那么所有的请求都会去访问数据库，这就可能引发缓存雪崩。

为了防止缓存雪崩，可以采取以下措施（可以使用防止缓存击穿的两种措施）：

1. **设置不同的过期时间**：避免大量数据同时过期，可以在原有的过期时间基础上加上一个随机值。
2. 集群、主从复制：将数据分布到多个缓存服务中，即使某个缓存服务挂掉，也只会影响到部分数据。
3. **预热缓存**：在缓存可能会大面积失效前，手动触发加载缓存的操作。
4. **限流、降级和熔断**：当数据库访问量过大时，可以限制部分请求，或者直接返回简化的结果，或者直接拒绝请求，防止数据库崩溃。
5. 多级缓存

### 缓存穿透

缓存穿透是指查询的数据既不在缓存中，也不在数据库中。对于这种情况，每次查询都会“穿透”缓存直接查询数据库。如果有恶意用户大量发起这种查询，数据库可能会承受很大的压力。

例如，假设你有一个网站，用户可以通过商品 ID 查询商品信息。通常，你会把商品信息缓存在 Redis 中，当用户查询一个商品时，首先在 Redis 中查找，如果找不到，再去数据库中查找，并把查找的结果放入 Redis 中。但是，如果用户查询的商品 ID 在数据库中不存在，那么每次查询都会去访问数据库，这就是缓存穿透。

为了防止缓存穿透，可以采取以下措施：

1. **使用布隆过滤器**：布隆过滤器是一种空间效率极高的概率型数据结构，它能够判断一个元素是否在一个集合中。你可以把所有可能的商品 ID 都放入布隆过滤器中，当用户查询一个商品 ID 时，首先使用布隆过滤器判断该商品 ID 是否可能存在，如果布隆过滤器判断该商品 ID 不存在，那么直接返回错误，不需要去访问数据库。
2. **缓存空结果**：即使数据库中没有查询到结果，也把这个“空结果”缓存起来。这样，当用户再次查询这个不存在的商品 ID 时，可以直接从缓存中获取到这个“空结果”，不需要去访问数据库。但是需要注意，这个“空结果”的缓存时间不能太长，以防止当这个商品 ID 后来在数据库中存在时，还是获取不到结果。
3. 参数校验

## redis和mysql保证一致性

1. **缓存穿透**：当需要查询的数据在 Redis 中不存在时（即缓存穿透），可以先从 MySQL 中查询数据，然后将查询结果存入 Redis，最后返回查询结果。这样可以确保 Redis 和 MySQL 中的数据是一致的。
2. **缓存更新**：当数据在 MySQL 中被修改时，可以同时更新 Redis 中的数据，或者直接删除 Redis 中的数据，让下一次查询时重新从 MySQL 中加载数据。这样也可以保持 Redis 和 MySQL 的数据一致性。但是，这种方法需要注意操作的原子性，否则可能会出现数据不一致的情况。
3. **设置过期时间**：对于 Redis 中的数据，可以设置一个过期时间。当数据过期后，下一次查询时会从 MySQL 中重新加载数据。这种方法可以在一定程度上保持数据的一致性，但是在数据过期前，Redis 和 MySQL 中的数据可能会不一致。
4. **使用消息队列**：当 MySQL 的数据被修改时，可以将修改操作发送到一个消息队列（如 RabbitMQ 或 Kafka），然后有一个消费者从消息队列中读取修改操作，并更新 Redis 中的数据。这种方法可以确保 Redis 和 MySQL 的数据一致性，但是需要处理消息队列的延迟问题。

3和4都不是强一致性的
