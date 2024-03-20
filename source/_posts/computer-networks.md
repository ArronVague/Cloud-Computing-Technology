---
title: 计算机网络
date: 2024-03-20 23:11:44
categories:
  - computer networks
tags:
  - computer networks
toc: true
---

转载自：https://github.com/CyC2018/CS-Notes/tree/master

## 概述

### 网络的网络

网络把主机连接起来，而互连网（internet）是把多种不同的网络连接起来，因此互连网是网络的网络。而互联网（Internet）是全球范围的互连网。

<!--more-->

![image-20240320231555984](computer-networks/image-20240320231555984.png)

### ISP (Internet Service Provider)

互联网服务提供商 ISP 可以从互联网管理机构获得许多 IP 地址，同时拥有通信线路以及路由器等联网设备，个人或机构向 ISP 缴纳一定的费用就可以接入互联网。

![image-20240320231606870](computer-networks/image-20240320231606870.png)

目前的互联网是一种多层次 ISP 结构，ISP 根据覆盖面积的大小分为第一层 ISP、区域 ISP 和接入 ISP。互联网交换点 IXP 允许两个 ISP 直接相连而不用经过第三个 ISP。

![image-20240320231617299](computer-networks/image-20240320231617299.png)

### 主机间的通信方式

- 客户-服务端（C/S）：客户是服务的请求方，服务器是服务的提供方。

![image-20240320231628966](computer-networks/image-20240320231628966.png)

- 对等（P2P）：不区分客户和服务器。

![image-20240320231639197](computer-networks/image-20240320231639197.png)

### 电路交换与分组交换

#### 1. 电路交换

用于电话通信系统，两个用户通信之前需要建立一条专用的物理链路，并且整个通信过程占用该链路。线路利用率低，往往不到10%。

#### 2. 分组交换

每个分组都有首部和尾部，包含了源地址和目的地址等控制信息，在同一个传输线路上同时传输多个分组互相不会影响，也就是说分组交换不需要占用传输线路。

在一个邮局通信系统中，邮局收到一份邮件之后，先存储下来，然后把相同目的地的邮件一起转发到下一个目的地，这个过程就是存储转发过程，分组交换也使用了存储转发过程。

### 时延

总时延 = 排队时延 + 处理时延 + 传输时延 + 传播时延

![image-20240320231707214](computer-networks/image-20240320231707214.png)

#### 1. 排队时延

分组在路由器的输入队列和输出**队列中排队等待**的时间，取决于当前网络通信量。

#### 2. 处理时延

主机或路由器收到分组后，进行处理需要的时间。例如分析首部、从分组中提取数据、进行差错检验或查找适当的路由等。

#### 3. 传输时延

主机或路由器传输数据帧所需要的时间。

![image-20240320231718044](computer-networks/image-20240320231718044.png)

其中 l 表示数据帧的长度，v 表示传输速率。

#### 4. 传播时延

电磁波在信道中传播所需要花费的时间，电磁波传播的速度接近光速。

![image-20240320231728699](computer-networks/image-20240320231728699.png)

其中 l 表示信道长度，v 表示电磁波在信道上的传播速度。

### 计算机网络体系结构

![image-20240320231741490](computer-networks/image-20240320231741490.png)

#### 1. 五层协议

- 应用层：为特定的应用程序提供数据传输服务，如：HTTP、DNS、FTP、SMTP、POP3（已被IMAP取代）、DHCP、TELNET（已被SSH取代）等协议。数据单位：报文（Message）。
- 传输层：为进程提供数据传输服务。定义通用的传输层协议可以支持不断增多的应用层协议。包括两种协议：
  - 传输控制协议TCP，提供面向连接、可靠的数据传输服务，数据单位：报文段（Segment）。
  - 用户数据报协议UDP，提供无连接、尽最大努力的数据传输服务，数据单位：数据报（Datagram）。
- 网络层：为主机提供数据传输服务，网络层把传输层传递下来的报文段或数据报封装成分组。数据单位：分组（Packet）。如：IPv4、IPv6、ARP、ICMP。
- 数据链路层：主机之间有很多链路，链路层为同一链路的主机提供数据传输服务。把网络层传下来的分组封装成帧（Frame）。如以太网（Ethernet），Wi-Fi，和蓝牙。
- 物理层：传输bit流，尽可能屏蔽传输媒体和通信手段的差异，使数据链路层感觉不到。

#### 2. OSI（Open Systems Interconnection）

- 表示层：数据压缩、加密以及数据描述，这使得应用程序不必关心在各台主机中数据内部格式不同的问题。
- 会话层：建立及管理会话。

五层协议将这些功能留给应用开发者处理。

#### 3. TCP/IP

相当于五层协议中数据链路层和物理层合并为网络接口层。

TCP/IP 体系结构不严格遵循 OSI 分层概念，应用层可能会直接使用 IP 层或者网络接口层。

![image-20240320231946518](computer-networks/image-20240320231946518.png)

#### 4. 数据在各层之间的传递过程

在向下的过程中，需要添加下层协议所需要的首部或者尾部，而在向上的过程中不断拆开首部和尾部。

路由器只有下面三层协议，因为路由器位于网络核心中，不需要为进程或者应用程序提供服务，因此也就不需要传输层和应用层。

## 物理层

### 通信方式

三种传输方式：

- 单工通信：单向传输
- 半双工通信：双向交替传输
- 全双工通信：双向同时传输

### 带通调制

模拟信号是连续的信号，数字信号是离散的信号。带通调制把数字信号转换为模拟信号，以便在物理介质上发送的信号。

![image-20240320232029117](computer-networks/image-20240320232029117.png)

## 链路层（不完整）

### 基本问题

#### 1. 封装成帧

将网络层传下来的分组（IP）添加首部和尾部，用于标记帧的开始和结束。

![image-20240320232052656](computer-networks/image-20240320232052656.png)

#### 2. 透明传输

透明表示一个实际存在的事物看起来好像不存在一样。

帧使用首部和尾部进行定界，如果帧的数据部分含有和首部尾部相同的内容，那么帧的开始和结束位置就会被错误的判定。需要在数据部分出现首部尾部相同的内容前面插入转义字符。如果数据部分出现转义字符，那么就在转义字符前面再加个转义字符。在接收端进行处理之后可以还原出原始数据。这个过程透明传输的内容是转义字符，用户察觉不到转义字符的存在。

下图中：

1. **SOH（Start of Header）**：在ASCII中，SOH的十进制值为1。它通常用于标记一段信息的开始，尤其是头部信息的开始。
2. **ESC（Escape）**：在ASCII中，ESC的十进制值为27。它通常用于引入一个转义序列，这是一种改变后续字符含义的机制。例如，在许多编程语言和命令行界面中，ESC字符可以用来引入一个颜色、格式或特殊字符的编码。
3. **EOT（End of Transmission）**：在ASCII中，EOT的十进制值为4。它通常用于标记一段信息的结束，尤其是在通信中标记传输的结束。

![image-20240320232244255](computer-networks/image-20240320232244255.png)

#### 3. 差错检测

目前广泛使用了循环冗余检验（CRC）来检查比特差错。

## 网络层

### 概述

整个互联网的核心，因此尽可能简单。网络层向上只提供简单灵活的、无连接的、尽最大努力交互的数据报服务。

使用 IP 协议，可以把异构的物理网络连接起来，使得在网络层看起来好像是一个统一的网络。

![image-20240320233356850](computer-networks/image-20240320233356850.png)

与 IP 协议配套使用的还有三个协议：

- 地址解析协议 ARP（Address Resolution Protocol），知道网关路由器IP地址，用该协议广播获得网关路由器的MAC地址。
- 网际控制报文协议 ICMP（Internet Control Message Protocol）
- 网际组管理协议 IGMP（Internet Group Management Protocol）

### IP数据报格式

![image-20240320233404661](computer-networks/image-20240320233404661.png)

- **版本** : 有 4（IPv4）和 6（IPv6）两个值；
- **首部长度** : 占 4 位，因此最大值为 15。值为 1 表示的是 1 个 32 位字的长度，也就是 4 字节。因为固定部分长度为 20 字节，因此该值最小为 5。如果可选字段的长度不是 4 字节的整数倍，就用尾部的填充部分来填充。
- **区分服务** : 用来获得更好的服务，一般情况下不使用。
- **总长度** : 包括首部长度和数据部分长度。
- **标识** : 在数据报长度过长从而发生分片的情况下，相同数据报的不同分片具有相同的标识符。
- **标志**（Flags）：这是一个3位的字段，其中最重要的两位是DF（Don't Fragment）和MF（More Fragments）。
  - DF位用于控制数据报是否可以被分片。如果DF位被设置（值为1），那么数据报就不能被分片。如果数据报太大，无法通过下一跳网络，那么它将被丢弃，并且发送ICMP错误消息给发送者。如果DF位没有被设置（值为0），那么数据报可以被分片。
  - MF位用于表示是否还有更多的片段。如果一个数据报被分片，那么除了最后一个片段之外，所有的片段都会设置MF位（值为1）。最后一个片段的MF位不会被设置（值为0）。这样，接收端就可以知道所有的片段是否都已经接收到了。
  - 在IPv6中，由于不再支持在传输过程中的分片，所以没有这两个字段。IPv6只在源端支持分片，并且使用了一个完全不同的机制和头部扩展来处理分片。
- **片偏移** : 和标识符一起，用于发生分片的情况。片偏移的单位为**8 字节**。
- **生存时间** ：TTL，它的存在是为了防止无法交付的数据报在互联网中不断兜圈子。以路由器跳数为单位，当 TTL 为 0 时就丢弃数据报。
- **协议** ：指出携带的数据应该上交给哪个协议进行处理，例如 ICMP、TCP、UDP 等。
- **首部检验和** ：因为数据报每经过一个路由器，都要重新计算检验和，因此检验和不包含数据部分可以减少计算的工作量。

![image-20240320233517464](computer-networks/image-20240320233517464.png)

### IP地址编址方式

IP 地址的编址方式经历了三个历史阶段：

- 分类
- 子网划分
- 无分类

#### 1. 分类

由两部分组成，网络号和主机号，其中不同分类具有不同的网络号长度，并且是固定的。

IP 地址 ::= {< 网络号 >, < 主机号 >}

![image-20240320233535616](computer-networks/image-20240320233535616.png)

#### 2. 子网划分

通过在主机号字段中拿一部分作为子网号，把两级 IP 地址划分为三级 IP 地址。

IP 地址 ::= {< 网络号 >, < 子网号 >, < 主机号 >}

要使用子网，必须配置子网掩码。一个 B 类地址的默认子网掩码为 255.255.0.0，如果 B 类地址的子网占两个比特，那么子网掩码为 11111111 11111111 11000000 00000000，也就是 255.255.192.0。

注意，外部网络看不到子网的存在。

一些约定：

- 子网部分：全为 0——本网络。
- 主机部分：全为 0——本主机。
- 主机部分：全为 1—— 广播地址，这个网络的所有主机。

#### 3. 无分类

无分类编址 CIDR 消除了传统 A 类、B 类和 C 类地址以及划分子网的概念，使用网络前缀和主机号来对 IP 地址进行编码，网络前缀的长度可以根据需要变化。

IP 地址 ::= {< 网络前缀号 >, < 主机号 >}

CIDR 的记法上采用在 IP 地址后面加上网络前缀长度的方法，例如 128.14.35.7/20 表示前 20 位为网络前缀。

CIDR 的地址掩码可以继续称为子网掩码，子网掩码首 1 长度为网络前缀的长度。

一个 CIDR 地址块中有很多地址，一个 CIDR 表示的网络就可以表示原来的很多个网络，并且在路由表中只需要一个路由就可以代替原来的多个路由，减少了路由表项的数量。把这种通过使用网络前缀来减少路由表项的方式称为路由聚合，也称为 **构成超网** 。

在路由表中的项目由“网络前缀”和“下一跳地址”组成，在查找时可能会得到不止一个匹配结果，应当采用最长前缀匹配来确定应该匹配哪一个。

### 地址解析协议ARP

网络层实现主机之间的通信，而链路层实现具体每段链路之间的通信。因此在通信过程中，IP 数据报的源地址和目的地址始终不变，而 MAC 地址随着链路的改变而改变。

![image-20240320233614781](computer-networks/image-20240320233614781.png)

ARP 实现由 IP 地址得到 MAC 地址。

![image-20240320233622336](computer-networks/image-20240320233622336.png)

每个主机都有一个 ARP 高速缓存，里面有本局域网上的各主机和路由器的 IP 地址到 MAC 地址的映射表。

如果主机 A 知道主机 B 的 IP 地址，但是 ARP 高速缓存中没有该 IP 地址到 MAC 地址的映射，此时主机 A 通过广播的方式发送 ARP 请求分组，主机 B 收到该请求后会发送 ARP 响应分组给主机 A 告知其 MAC 地址，随后主机 A 向其高速缓存中写入主机 B 的 IP 地址到 MAC 地址的映射。

![image-20240320233632927](computer-networks/image-20240320233632927.png)

### 网际控制报文协议ICMP

位于网络层，但是封装在IP数据报中。ICMP 是为了更有效地转发 IP 数据报和提高交付成功的机会。

![image-20240320233705195](computer-networks/image-20240320233705195.png)

ICMP 报文分为差错报告报文和询问报文。

![image-20240320233735273](computer-networks/image-20240320233735273.png)

#### 1. Ping

Ping 是 ICMP 的一个重要应用，主要用来测试两台主机之间的连通性。

Ping 的原理是通过向目的主机发送 ICMP Echo 请求报文，目的主机收到之后会发送 Echo 回答报文。Ping 会根据时间和成功响应的次数估算出数据包往返时间以及丢包率。

#### 2. Traceroute

Traceroute 是 ICMP 的另一个应用，用来跟踪一个分组从源点到终点的路径。

Traceroute 发送的 IP 数据报封装的是无法交付的 UDP 用户数据报，并由目的主机发送终点不可达差错报告报文（type = 3）。

- 源主机向目的主机发送一连串的 IP 数据报。第一个数据报 P1 的生存时间 TTL 设置为 1，当 P1 到达路径上的第一个路由器 R1 时，R1 收下它并把 TTL 减 1，此时 TTL 等于 0，R1 就把 P1 丢弃，并向源主机发送一个 ICMP 时间超过差错报告报文（type = 11）；
- 源主机接着发送第二个数据报 P2，并把 TTL 设置为 2。P2 先到达 R1，R1 收下后把 TTL 减 1 再转发给 R2，R2 收下后也把 TTL 减 1，由于此时 TTL 等于 0，R2 就丢弃 P2，并向源主机发送一个 ICMP 时间超过差错报文。
- 不断执行这样的步骤，直到最后一个数据报刚刚到达目的主机，主机不转发数据报，也不把 TTL 值减 1。但是因为数据报封装的是无法交付的 UDP，因此目的主机要向源主机发送 ICMP 终点不可达差错报告报文（type = 3）。
- 之后源主机知道了到达目的主机所经过的路由器 IP 地址以及到达每个路由器的往返时间。

### 虚拟专用网VPN

由于 IP 地址的紧缺，一个机构能申请到的 IP 地址数往往远小于本机构所拥有的主机数。并且一个机构并不需要把所有的主机接入到外部的互联网中，机构内的计算机可以使用仅在本机构有效的 IP 地址（专用地址）。

有三个专用地址块：

- 10.0.0.0 ~ 10.255.255.255
- 172.16.0.0 ~ 172.31.255.255
- 192.168.0.0 ~ 192.168.255.255

VPN 使用公用的互联网作为本机构各专用网之间的通信载体。专用指机构内的主机只与本机构内的其它主机通信；虚拟指好像是，而实际上并不是，它有经过公用的互联网。

下图中，场所 A 和 B 的通信经过互联网，如果场所 A 的主机 X 要和另一个场所 B 的主机 Y 通信，IP 数据报的源地址是 10.1.0.1，目的地址是 10.2.0.3。数据报先发送到与互联网相连的路由器 R1，R1 对内部数据进行加密，然后重新加上数据报的首部，源地址是路由器 R1 的全球地址 125.1.2.3，目的地址是路由器 R2 的全球地址 194.4.5.6。路由器 R2 收到数据报后将数据部分进行解密，恢复原来的数据报，此时目的地址为 10.2.0.3，就交付给 Y。

![image-20240320233824232](computer-networks/image-20240320233824232.png)

### 网络地址转换NAT

专用网内部的主机使用本地 IP 地址又想和互联网上的主机通信时，可以使用 NAT 来将本地 IP 转换为全球 IP。

在以前，NAT 将本地 IP 和全球 IP 一一对应，这种方式下拥有 n 个全球 IP 地址的专用网内最多只可以同时有 n 台主机接入互联网。为了更有效地利用全球 IP 地址，现在常用的 NAT 转换表把传输层的端口号也用上了，使得多个专用网内部的主机共用一个全球 IP 地址。使用端口号的 NAT 也叫做网络地址与端口转换 NAPT。

![image-20240320233838217](computer-networks/image-20240320233838217.png)

![image-20240319094259385](computer-networks/image-20240319094259385.png)

![image-20240319094315691](computer-networks/image-20240319094315691.png)

### 路由器的结构

路由器从功能上可以划分为：路由选择和分组转发。

分组转发结构由三个部分组成：交换结构、一组输入端口和一组输出端口。

![image-20240320233852959](computer-networks/image-20240320233852959.png)

### 路由器分组转发流程

- 从数据报的首部提取目的主机的 IP 地址 D，得到目的网络地址 N。
- 若 N 就是与此路由器直接相连的某个网络地址，则进行直接交付；
- 若路由表中有目的地址为 D 的特定主机路由，则把数据报传送给表中所指明的下一跳路由器；
- 若路由表中有到达网络 N 的路由，则把数据报传送给路由表中所指明的下一跳路由器；
- 若路由表中有一个默认路由，则把数据报传送给路由表中所指明的默认路由器；
- 报告转发分组出错。

![image-20240320233906140](computer-networks/image-20240320233906140.png)

### 路由选择协议

路由选择协议都是自适应的，能随着网络通信量和拓扑结构的变化而自适应地进行调整。

互联网可以划分为许多较小的自治系统 AS，一个 AS 可以使用一种和别的 AS 不同的路由选择协议。

可以把路由选择协议划分为两大类：

- 自治系统内部的路由选择：RIP 和 OSPF
- 自治系统间的路由选择：BGP

#### 1. 内部网关协议 RIP（已经被OSPF取代）

RIP 是一种基于距离向量（基于Bellman-Ford算法）的路由选择协议。距离是指跳数，直接相连的路由器跳数为 1。跳数最多为 15，超过 15 表示不可达。

RIP 按固定的时间间隔仅和相邻路由器交换自己的路由表，经过若干次交换之后，所有路由器最终会知道到达本自治系统中任何一个网络的最短距离和下一跳路由器地址。

距离向量算法：

- 对地址为 X 的相邻路由器发来的 RIP 报文，先修改报文中的所有项目，把下一跳字段中的地址改为 X，并把所有的距离字段加 1；
- 对修改后的 RIP 报文中的每一个项目，进行以下步骤：
- 若原来的路由表中没有目的网络 N，则把该项目添加到路由表中；
- 否则：若下一跳路由器地址是 X，则把收到的项目替换原来路由表中的项目；否则：若收到的项目中的距离 d 小于路由表中的距离，则进行更新（例如原始路由表项为 Net2, 5, P，新表项为 Net2, 4, X，则更新）；否则什么也不做。
- 若 3 分钟还没有收到相邻路由器的更新路由表，则把该相邻路由器标为不可达，即把距离置为 16。

RIP 协议实现简单，开销小。但是 RIP 能使用的最大距离为 15，限制了网络的规模。并且当网络出现故障时，要经过比较长的时间才能将此消息传送到所有路由器。

#### 2. 内部网关协议 OSPF

开放最短路径优先 OSPF，是为了克服 RIP 的缺点而开发出来的。

开放表示 OSPF 不受某一家厂商控制，而是公开发表的；最短路径优先表示使用了 Dijkstra 提出的最短路径算法 SPF。

OSPF 具有以下特点：

- 向本自治系统中的所有路由器发送信息，这种方法是洪泛法。
- 发送的信息就是与相邻路由器的链路状态，链路状态包括与哪些路由器相连以及链路的度量，度量用费用、距离、时延、带宽等来表示。
- 只有当链路状态发生变化时，路由器才会发送信息。

所有路由器都具有全网的拓扑结构图，并且是一致的。相比于 RIP，OSPF 的更新过程收敛的很快。

#### 3. 外部网关协议 BGP

基于距离矢量算法。

BGP（Border Gateway Protocol，边界网关协议）

AS 之间的路由选择很困难，主要是由于：

- 互联网规模很大；
- 各个 AS 内部使用不同的路由选择协议，无法准确定义路径的度量；
- AS 之间的路由选择必须考虑有关的策略，比如有些 AS 不愿意让其它 AS 经过。

BGP 只能寻找一条比较好的路由，而不是最佳路由。

每个 AS 都必须配置 BGP 发言人，通过在两个相邻 BGP 发言人之间建立 TCP 连接来交换路由信息。

![image-20240320233951219](computer-networks/image-20240320233951219.png)

## 传输层

网络层只把分组发送到目的主机，但是真正通信的是主机中的进程。传输层提供了进程间的逻辑通信，向高层用户屏蔽了网络层的核心细节，使应用程序看起来像是在两个传输层实体之间有一条端到端的逻辑通信信道。

### UDP和TCP的特点

- 用户数据报协议 UDP（User Datagram Protocol）无连接，尽最大可能交付，没有拥塞控制，面向报文（对于应用程序传下来的报文不合并也不拆分，只是添加 UDP 首部），支持一对一、一对多、多对一和多对多的交互通信。
- 传输控制协议 TCP（Transmission Control Protocol）面向连接的，提供可靠交付，有流量控制，拥塞控制，提供全双工通信，面向字节流（把应用层传下来的报文看成字节流，把字节流组织成大小不等的数据块），每一条 TCP 连接只能是点对点的（一对一）。

### UDP首部格式

![image-20240320234048388](computer-networks/image-20240320234048388.png)

首部字段只有 8 个字节，包括源端口、目的端口、长度、检验和。12 字节的伪首部是为了计算检验和临时添加的，并不会真正地发送出去。

### TCP首部格式

![image-20240320234214934](computer-networks/image-20240320234214934.png)

- **序号** ：用于对字节流进行编号，例如序号为 301，表示第一个字节的编号为 301，如果携带的数据长度为 100 字节，那么下一个报文段的序号应为 401。
- **确认号** ：期望收到的下一个报文段的序号。例如 B 正确收到 A 发送来的一个报文段，序号为 501，携带的数据长度为 200 字节，因此 B 期望下一个报文段的序号为 701，B 发送给 A 的确认报文段中确认号就为 701。
- **数据偏移** ：指的是数据部分距离报文段起始处的偏移量，实际上指的是首部的长度。
- **确认 ACK** ：当 ACK=1 时确认号字段有效，否则无效。TCP 规定，在连接建立后所有传送的报文段都必须把 ACK 置 1。
- **同步 SYN** ：在连接建立时用来同步序号。当 SYN=1，ACK=0 时表示这是一个连接请求报文段。若对方同意建立连接，则响应报文中 SYN=1，ACK=1。
- **终止 FIN** ：用来释放一个连接，当 FIN=1 时，表示此报文段的发送方的数据已发送完毕，并要求释放连接。
- **窗口** ：窗口值作为接收方让发送方设置其发送窗口的依据。之所以要有这个限制，是因为接收方的数据缓存空间是有限的。

### TCP的三次握手

![image-20240320234247573](computer-networks/image-20240320234247573.png)

上图中，大写的SYN、ACK为bit位，seq为序列号，ack为确认号。

假设 A 为客户端，B 为服务器端。

- 首先 B 处于 LISTEN（监听）状态，等待客户的连接请求。
- A 向 B 发送连接请求报文，SYN=1，ACK=0（表示这是一个连接请求报文段。），选择一个初始的序号 x。
- B 收到连接请求报文，如果同意建立连接，则向 A 发送连接确认报文，SYN=1，ACK=1，确认号为 x+1（也是希望收到的下一个报文段的序列号），同时也选择一个初始的序号 y。
- A 收到 B 的连接确认报文后，还要向 B 发出确认，确认号为 y+1，序号为 x+1。
- B 收到 A 的确认后，连接建立。

**三次握手的原因**

第三次握手是为了防止失效的连接请求到达服务器，让服务器错误打开连接。

客户端发送的连接请求如果在网络中滞留，那么就会隔很长一段时间才能收到服务器端发回的连接确认。客户端等待一个超时重传时间之后，就会重新请求连接。但是这个滞留的连接请求最后还是会到达服务器，如果不进行三次握手，那么服务器就会打开两个连接。如果有第三次握手，客户端会忽略服务器之后发送的对滞留连接请求的连接确认，不进行第三次握手，因此就不会再次打开连接。

### TCP的四次挥手

![image-20240320234310912](computer-networks/image-20240320234310912.png)

以下描述不讨论序号和确认号，因为序号和确认号的规则比较简单。并且不讨论 ACK，因为 ACK 在连接建立之后都为 1。

- A 发送连接释放报文，FIN=1。
- B 收到之后发出确认（此时FIN=0），此时 TCP 属于半关闭状态，B 能向 A 发送数据但是 A 不能向 B 发送数据。
- 当 B 不再需要连接时，发送连接释放报文，FIN=1。
- A 收到后发出确认，进入 TIME-WAIT 状态，等待 2 MSL（最大报文存活时间）后释放连接。
- B 收到 A 的确认后释放连接。

**四次挥手的原因**

客户端发送了 FIN 连接释放报文之后，服务器收到了这个报文，就进入了 CLOSE-WAIT 状态。这个状态是为了让**服务器端发送还未传送完毕的数据**，传送完毕之后，服务器会发送 FIN 连接释放报文。

**TIME_WAIT**

客户端接收到服务器端的 FIN 报文后进入此状态，此时并不是直接进入 CLOSED 状态，还需要等待一个时间计时器设置的时间 2MSL。这么做有两个理由：

- 确保最后一个确认报文能够到达。如果 B 没收到 A 发送来的确认报文，那么就会重新发送连接释放请求报文，A 等待一段时间就是为了处理这种情况的发生。
- 等待一段时间是为了让本连接持续时间内所产生的所有报文都从网络中消失，使得下一个新的连接不会出现旧的连接请求报文。

### TCP可靠传输

TCP 使用超时重传来实现可靠传输：如果一个已经发送的报文段在超时时间内没有收到确认，那么就重传这个报文段。

一个报文段从发送再到接收到确认所经过的时间称为往返时间 RTT，加权平均往返时间 RTTs 计算如下：

$$
RTT_s=(1-\alpha)\cdot(RTT_s)+\alpha\cdot RTT
$$
其中，0 ≤ a ＜ 1，RTTs 随着 a 的增加更容易受到 RTT 的影响。

超时时间 RTO 应该略大于 RTTs，TCP 使用的超时时间计算如下：

$$
RTO=RTT_s+4\cdot RTT_d
$$
其中 RTTd 为偏差的加权平均值。
$$
RTT_d=(1-\beta)\cdot RTT_d+\beta\cdot |RTT_s-RTT|
$$
RTTs和RTTd的计算应该同时进行，因此，两个算式中右边的RTTs都是旧的RTTs。

### TCP滑动窗口

窗口是缓存的一部分，用来暂时存放字节流。发送方和接收方各有一个窗口，接收方通过 TCP 报文段中的窗口字段告诉发送方自己的窗口大小，发送方根据这个值和其它信息设置自己的窗口大小。

发送窗口内的字节都允许被发送，接收窗口内的字节都允许被接收。如果发送窗口左部的字节已经发送并且收到了确认，那么就将发送窗口向右滑动一定距离，直到左部第一个字节不是已发送并且已确认的状态；接收窗口的滑动类似，接收窗口左部字节已经发送确认并交付主机，就向右滑动接收窗口。

接收窗口只会对窗口内最后一个**按序到达**的字节进行确认，例如接收窗口已经收到的字节为 {31, 34, 35}，其中 {31} 按序到达，而 {34, 35} 就不是，因此只对字节 31 进行确认。发送方得到一个字节的确认之后，就知道这个字节之前的所有字节都已经被接收。

![image-20240320234736573](computer-networks/image-20240320234736573.png)

### TCP流量控制

为了控制发送方发送速率，保证接收方来得及接收。

接收方发送的确认报文中的窗口字段可以用来控制发送方窗口大小，从而影响发送方发送速率。如果设置为0，则发送方不能发送数据。

### TCP拥塞控制

如果网络出现拥塞，分组将会丢失，此时发送方会继续重传，从而导致网络拥塞程度更高。因此当出现拥塞时，应当控制发送方的速率。这一点和流量控制很像，但是出发点不同。

流量控制是为了让接收方来得及接收，拥塞控制是为了降低整个网络的拥塞程度。

![image-20240320234748836](computer-networks/image-20240320234748836.png)

四个算法：

- 慢开始
- 拥塞避免
- 快重传
- 快恢复

发送方需要维护一个叫做拥塞窗口（cwnd）的状态变量，注意拥塞窗口与发送方窗口的区别：拥塞窗口只是一个状态变量，实际决定发送方能发送多少数据的是发送方窗口。

为了便于讨论，做如下假设：

- 接收方有足够大的接收缓存，因此不会发生流量控制；
- 虽然 TCP 的窗口基于字节，但是这里设窗口的大小单位为报文段。

![image-20240320234811272](computer-networks/image-20240320234811272.png)

#### 1. 慢开始与拥塞避免

发送的最初执行慢开始（指数增长），令 cwnd = 1，发送方只能发送 1 个报文段；当收到确认后，将 cwnd 加倍，因此之后发送方能够发送的报文段数量为：2、4、8 ...

注意到慢开始每个轮次都将 cwnd 加倍，这样会让 cwnd 增长速度非常快，从而使得发送方发送的速度增长速度过快，网络拥塞的可能性也就更高。设置一个慢开始门限 ssthresh，当 cwnd >= ssthresh 时，进入拥塞避免，每个轮次只将 cwnd 加 1。

如果出现了超时，则令 ssthresh = cwnd / 2，cwnd = 1，然后重新执行慢开始。

#### 2. 快重传与快恢复

注意：快重传后紧跟快恢复

在接收方，要求每次接收到报文段都应该对最后一个**已收到的有序报文段**进行确认。例如已经接收到 M1 和 M2，此时收到 M4，应当发送对 M2 的确认。

在发送方，如果收到三个重复确认（也就是收到了四个一样的确认），那么可以知道下一个报文段丢失，此时执行快重传，立即重传下一个报文段。例如收到三个 M2，则 M3 丢失，立即重传 M3。

在这种情况下，只是丢失个别报文段，而不是网络拥塞。因此执行快恢复，令 ssthresh = cwnd / 2 ，cwnd = ssthresh（不同的TCP分支有不同的处理方式），注意到此时直接进入拥塞避免。

慢开始和快恢复的快慢指的是 cwnd 的设定值，而不是 cwnd 的增长速率。慢开始 cwnd 设定为 1，而快恢复 cwnd 设定为 ssthresh。

![image-20240320234840219](computer-networks/image-20240320234840219.png)

## 应用层

### 域名系统

DNS是一个分布式数据库（每个站点只保留自己的部分数据），提供了主机名和IP地址之间相互转换的服务。

域名具有层次结构，从上到下依次为：根域名、顶级域名、二级域名。

![image-20240320235442988](computer-networks/image-20240320235442988.png)

DNS可以用UDP或TCP传输，使用端口号都为53。大多数情况，DNS使用UDP传输，这就要求域名解析器和域名服务器都必须自己处理超时和重传以保证可靠性。两种情况下会使用TCP传输：

- 返回的响应超过UDP能携带的最大数据。
- 区域传送（是主域名服务器向辅助域名服务器传送变化的那部分数据）。

### 文件传送协议

FTP使用TCP进行连接，需要两个连接来传送一个文件：

- 控制连接：服务器打开端口号 21 等待客户端的连接，客户端主动建立连接后，使用这个连接将客户端的命令传送给服务器，并传回服务器的应答。
- 数据连接：传送一个文件数据。

根据数据连接是否是服务器端主动建立，FTP 有主动和被动（主语为服务器）两种模式：

- 主动模式：服务器端主动建立数据连接，其中服务器端的端口号为 20，客户端的端口号随机，但是必须大于 1024，因为 0~1023 是熟知端口号。

![image-20240320235524028](computer-networks/image-20240320235524028.png)

- 被动模式：客户端主动建立数据连接，其中客户端的端口号由客户端自己指定，服务器端的端口号随机。

![image-20240320235533138](computer-networks/image-20240320235533138.png)

主动模式要求客户端开放端口号给服务器端，需要去配置客户端的防火墙。被动模式只需要服务器端开放端口号即可，无需客户端配置防火墙。但是被动模式会导致服务器端的安全性减弱，因为开放了过多的端口号。

### 动态主机配置协议

DHCP (Dynamic Host Configuration Protocol) 提供了即插即用的连网方式，用户不再需要手动配置 IP 地址等信息。

DHCP 配置的内容不仅是 IP 地址，还包括子网掩码、网关 IP 地址。

DHCP 工作过程如下（跟找工作差不多……）：

1. 客户端发送 Discover 报文，该报文的目的地址为 255.255.255.255:67，源地址为 0.0.0.0:68，被放入 UDP 中，该报文被广播到同一个子网的所有主机上。如果客户端和 DHCP 服务器不在同一个子网，就需要使用中继代理。
2. DHCP 服务器收到 Discover 报文之后，发送 Offer 报文给客户端，该报文包含了客户端所需要的信息。因为客户端可能收到多个 DHCP 服务器提供的信息，因此客户端需要进行选择。
3. 如果客户端选择了某个 DHCP 服务器提供的信息，那么就发送 Request 报文给该 DHCP 服务器。
4. DHCP 服务器发送 Ack 报文，表示客户端此时可以使用提供给它的信息。

![image-20240320235655694](computer-networks/image-20240320235655694.png)

### 远程登录协议

TELNET（已经被SSH协议取代） 用于登录到远程主机上，并且远程主机上的输出也会返回。

TELNET 可以适应许多计算机和操作系统的差异，例如不同操作系统系统的换行符定义。

### 电子邮件协议

电子邮件系统组成部分：

- 用户代理
- 邮件服务器
- 邮件协议
  - 发送协议（常用SMTP）
  - 读取协议（常用POP3和IMAP）

![image-20240320235718371](computer-networks/image-20240320235718371.png)

#### 1. SMTP

SMTP 只能发送 ASCII 码，而互联网邮件扩充 MIME 可以发送二进制文件。MIME 并没有改动或者取代 SMTP，而是增加邮件主体的结构，定义了非 ASCII 码的编码规则。

![image-20240320235727170](computer-networks/image-20240320235727170.png)

#### 2. POP3

特点是只要用户从服务器上读取了邮件，就删除该邮件。已经被IMAP取代。

#### 3. IMAP

客户端和服务器上的邮件保持同步，如果不手动删除邮件，那么服务器上的邮件也不会被删除。IMAP 这种做法可以让用户随时随地去访问服务器上的邮件。

### 常用端口

| 应用             | 应用层协议 | 端口号  | 传输层协议 | 备注                        |
| ---------------- | ---------- | ------- | ---------- | --------------------------- |
| 域名解析         | DNS        | 53      | UDP/TCP    | 长度超过 512 字节时使用 TCP |
| 动态主机配置协议 | DHCP       | 67/68   | UDP        |                             |
| 简单网络管理协议 | SNMP       | 161/162 | UDP        |                             |
| 文件传送协议     | FTP        | 20/21   | TCP        | 控制连接 21，数据连接 20    |
| 远程终端协议     | TELNET     | 23      | TCP        |                             |
| 超文本传送协议   | HTTP       | 80      | TCP        |                             |
| 简单邮件传送协议 | SMTP       | 25      | TCP        |                             |
| 邮件读取协议     | POP3       | 110     | TCP        |                             |
| 网际报文存取协议 | IMAP       | 143     | TCP        |                             |

### Web 页面请求过程

![image-20240318105358847](computer-networks/image-20240318105358847.png)

#### 1. DHCP配置主机信息

- 假设主机最开始没有IP地址及其它信息，需要先试用DHCP获取。
- 主机生成DHCP请求报文，放入UDP数据报中，目的端口67，源端口68。
- 放入IP数据报中，广播 IP 目的地址(255.255.255.255) 和源 IP 地址（0.0.0.0）。
- 放入MAC帧中，具有目的地址FF:FF:FF:FF:FF:FF，将广播到与交换机连接的所有设备。
- 连接在交换机的DHCP服务器收到广播帧后，不断地向上分解得到 IP 数据报、UDP 报文段、DHCP 请求报文，之后生成 DHCP ACK 报文，该报文包含以下信息：IP 地址、DNS 服务器的 IP 地址、默认网关路由器的 IP 地址和子网掩码。该报文被放入 UDP 报文段中，UDP 报文段有被放入 IP 数据报中，最后放入 MAC 帧中。
- 该帧的目的地址是请求主机的 MAC 地址，因为交换机具有自学习能力，之前主机发送了广播帧之后就记录了 MAC 地址到其转发接口的交换表项，因此现在交换机就可以直接知道应该向哪个接口发送该帧。
- 主机收到该帧后，不断分解得到 DHCP 报文。之后就配置它的 IP 地址、子网掩码和 DNS 服务器的 IP 地址，并在其 IP 转发表中安装默认网关。

![image-20240318105418710](computer-networks/image-20240318105418710.png)

![image-20240318105431532](computer-networks/image-20240318105431532.png)

#### 2. ARP（网络层）解析MAC地址

- 主机为了生成套接字，需要知道网站的域名对应的IP地址。
- 主机生成一个DNS查询报文，封装在UDP中。
- 放入IP数据报中，目的地址DNS服务器IP地址。
- 放入以太网帧中，将帧发送到网关路由器。
- 但是这时候还不知道网关路由器的MAC地址，因为DHCP过程只知道网关路由器的IP地址。因此需要使用ARP协议。
- 主机生成一个ARP查询报文，目的地址为网关路由器的IP地址。放入以太网帧中，具有广播目的地址FF:FF:FF:FF:FF:FF的以太网帧中，并向交换机发送该以太网帧，交换机转发给所有连接设备。
- 网关路由器接收后，不断分解得到ARP报文，发现其中IP地址与其接口IP地址匹配，因此发送ARP回答报文，包含了它的MAC地址，发回给主机。

![image-20240318110448792](computer-networks/image-20240318110448792.png)

#### 3. DNS解析域名

- 网关路由器接收到DNS查询以太帧后，抽取IP数据报，并根据转发表决定应该转发的路由器。
- 路由到NDS服务器的路由表由内部网关协议（RIP、OSPF）和外部网关协议（BGP）创建。
- 到达DNS服务器后，服务器抽取出DNS查询报文，并在DNS数据库中查找待解析的域名。
- 找到DNS记录后，发送DNS回答报文，放入UDP数据报中，放入IP数据报中，通过路由器反向转发回网关路由器，并经过以太网交换机到达主机。

![image-20240318123102054](computer-networks/image-20240318123102054.png)

#### 4. HTTP请求页面

- 有了HTTP服务器的IP地址后，主机生成TCP套接字，用于向Web服务器发送HTTP GET报文。
- 生成套接字之前，需要与服务器三次握手来建立连接。客户端生成一个SYN报文段（x），发送给服务器。
- 服务器发回SYN ACK报文段（x + 1, y）。
- 客户端发送ACK报文段（y + 1），连接建立。此步为第三次握手，可同时将HTTP GET报文发送给服务器。
- 服务器从TCP套接字中读取HTTP GET报文，生成HTTP响应报文，将Web页面内容发回给主机。
- 主机抽取出内容，渲染，显示Web页面。

![image-20240318124318116](computer-networks/image-20240318124318116.png)

![image-20240318124331487](computer-networks/image-20240318124331487.png)