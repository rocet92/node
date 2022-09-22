# auditd用于文件监控


可以用auditd实现监控文件被什么进程修改


### 安装
apt install auditd

包内容如下：

`auditd` 是后台守护进程，负责监控记录

`auditctl` 配置规则的工具

`auditsearch` 搜索查看

`aureport` 根据监控记录生成报表



### 运行
systemctr start auditd

开机启动：systemctr enable auditd 


### 设置监控规则
* 临时规则

监控 /etc/passwd文件是否被修改过：
sudo auditctl -w /etc/passwd -p war -k My\_Key

`-w` 指明要监控的文件

`-p` awrx 要监控的操作类型， 指定的触发条件，r 读取权限，w 写入权限，x 执行权限，a 属性（attr）
`-k` 给当前这条监控规则起个名字，方便搜索过滤


* 永久规则

```bash
# /etc/audit/rules.d/audit.rules

# 如下增加一行规则，重启auditd
-w /etc/passwd -p rwxa -k My_Key
```
* 查看规则

`sudo auditctl -l`



### 查看修改纪录
ausearch -i -k My\_Key



### 例子
* 监控/etc/passwd被什么进程修改

先添加规则，操作类型只指定w(write)：-w /etc/passwd -p w -k USER\_PW

重启auditd后，开始监控，之后查看结果：ausearch -i -k USER\_PW | grep PROCTITLE



