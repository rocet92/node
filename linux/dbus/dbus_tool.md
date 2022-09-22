## dbus基础工具

### 1 d-feet
d-feet是dbus的一个调试工具。它可以显示service提供的所有对象、信号、和方法。另外还可以通过它实现方法调用。

想要在d-feet显示对象路径及接口信息，需要实现对应接口的org.freedesktop.DBus.Introspectable.Introspect方法。go-dbus-factory能够根据接口描述xml自动化生成这些方法。

在uos的安装方法，应用商店下载或者命令行输入：
```
sudo apt install d-feet
```

### 2 dconf-editor
dconf-editor 是 dconf 的一个图形化操作程序。用来查看和编辑本地的gsettings配置文件。

在uos的安装方法：
```
sudo apt install dconf-editor
```

### 3 dbus-monitor
`dbus-monitor` — debug probe to print message bus messages

```
Usage: dbus-monitor [--system | --session | --address ADDRESS] [--monitor | --profile | --pcap | --binary ] [watch expressions]
```


- 总线类别（[--system | --session | --address ADDRESS] ）

    `--system`：监视系统消息总线

    `--session`：监视会话消息总线 （默认设置）

    `--address ADDRESS`：监视指定地址的任意消息总线(eg:--address  unix:path=/run/user/1000/bus)

- 输出模式（[--monitor | --profile | --pcap | --binary ]）

    `--monitor`：经典文本模式（默认设置）

    `--profile`：分析文本模式。分析格式是一种紧凑的格式，每条消息只有一行，并且具有微秒分辨率的定时信息。

    `--pcap`：二进制模式。PCAP模式在输出的开头添加一个PCAP文件头，并在每条消息前面添加一个PCAP消息头。

    `--binary`：二进制模式。输出整个二进制消息流。


- 监听表达式（[watch expressions]）
  表达式用于过滤监听的消息，有如下5个监听条件：

  `type`：3种消息类型（signal、method_call、method_return）

  `sender`：发送方

  `destination`：接收方

  `path`：对象路径

  `interface`：接口

  `member`：方法

可以多个[ watch expressions ]组合起来使用，如：
```
$ dbus-monitor path='/com/feng/object1',sender='com.feng.bus',type='signal'
signal time=1619598102.160454 sender=:1.1998 -> destination=(null destination) serial=33 path=/com/feng/object1; interface=org.freedesktop.DBus.Properties; member=PropertiesChanged
   string "com.feng.object1"
   array [
      dict entry(
         string "Name"
         variant             string "name-changed122"
      )
   ]
   array [
   ]

```

参考监听到的结果，可以注意到各监听条件对应的信息。

监视某些系统级接口时，需要加上sudo权限，如监视lastore更新模块：
```
$ sudo dbus-monitor --system --profile interface='com.deepin.devicemanager'
```



### 4 dbus-send

`dbus-send` — 向消息总线模拟发送一条消息
```
Usage: dbus-send [--help] [--system | --session | --bus=ADDRESS | --peer=ADDRESS] [--dest=NAME] [--type=TYPE] [--print-reply[=literal]] [--reply-timeout=MSEC] <destination object path> <message name> [contents ...]
```

命令参数说明：
```
--dest：指定接收消息的连接名称
--print-reply：阻止对已发送消息的答复，打印收到的所有答复。消息类型--type = method_call。
--print-reply=literal：阻止对已发送消息的答复，并打印答复内容，如果答复是对象路径或字符串，则按原样打印，没有标点，转义字符等。
--reply-timeout：等待答复最大毫秒值，默认25秒
--system和--session：系统总线和会话总线，默认会话总线
--bus：在指定的消息总线上注册，通常是dbus-daemon
--peer：发送非DBus消息到指定的DBus服务上，dbus-send将不会调用Hello方法
--sender：发送消息之前，给发送者授权， 退出时，释放该发送者
--type：指定method_call或signal（默认为“ signal”）

```

必须始终指定对象路径和要发送的消息的名称，消息内容后面可以携带输入参数，参数类型说明如下：

```
<contents>  ::= <item> | <container> [ <item> | <container>...]
<item>    ::= <type>:<value>
<container> ::= <array> | <dict> | <variant>
<array>   ::= array:<type>:<value>[,<value>...]
<dict>    ::= dict:<type>:<type>:<key>,<value>[,<key>,<value>...]
<variant>  ::= variant:<type>:<value>
<type>    ::= string | int16 | uint16 | int32 | uint32 | int64 | uint64 | double | byte | boolean | objpath
```

多消息内容典型例子：

```
dbus-send --dest=org.freedesktop.ExampleName                \
         /org/freedesktop/sample/object/name                \
         org.freedesktop.ExampleInterface.ExampleMethod     \
         int32:47                                           \
         string:'hello world'                               \
         double:65.32                                       \
         array:string:"1st item","next item","last item"    \
         dict:string:int32:"one",1,"two",2,"three",3        \
         variant:int32:-8                                   \
         objpath:/org/freedesktop/sample/object/name
```

调用dbus_demo例子：

```
$ dbus-send  --dest=com.feng.bus --print-reply=literal --type=method_call /com/feng/object1 com.feng.object1.GetString
object1 methods test
```





