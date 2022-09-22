



1 功能简介

低优先级进程和高优先级进程进行通讯的系统，更精细的授权。



1.1 参考文档

《官方手册》

https://www.freedesktop.org/software/polkit/docs/latest/index.html 

https://www.freedesktop.org/software/polkit/docs/latest/polkit.8.html

《man手册（英文）》

http://manpages.ubuntu.com/manpages/trusty/man8/polkit.8.html

《suse文档（中文，推荐！简介、详细配置规则、例子）》

https://documentation.suse.com/zh-cn/sled/15-SP2/html/SLED-all/cha-security-policykit.html (原文已失效，参考转载 https://999526b0.wiz06.com/wapp/pages/view/share/s/2pBiqM0QAh7y2FJV1W2R6SqK0-omCw1YUh7I29Y6nM24yZec)

https://documentation.suse.com/sles/11-SP4/html/SLES-all/cha-policykit.html （新版，英文）

《arch linux wiki（中文，简介、配置规则、例子）》

https://wiki.archlinux.org/title/Polkit_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87)



1.2  应用场景

- 作用

需要验证权限的应用通过polkit验证权限（即指定用户进行认证），polkit本身不涉及提权。

```
每当支持 PolKit 的进程执行特权操作时，系统都会询问 PolKit 此进程是否有权这样做。PolKit 根据针对此进程定义的策略做出回答。回答可能为是、否或需要身份验证。默认情况下，策略包含自动应用于所有用户的隐式特权。您也可以指定应用于特定用户的显式特权。
```

 

- polkit和pam（DA）的区别

pam（DA）为认证管理，决定怎么认证，包含认证的具体实现；

polkit为认证发起者角色管理，决定以哪个用户来开始认证和决定是否需要认证，polkit最终还是通过pam（DA）完成具体的认证。



1.3 原理

需要鉴权的应用需要根据定义的policy的actionid调用polkitd接口去开启认证，polkit也需要配置“需要鉴权的应用”的权限配置（policy文件）



2 配置方法

PolKit 的配置取决于操作（Actions，隐式特权）和认证规则（Authorization rules，显式特权）。

2.1 操作（Actions）

在 /usr/share/polkit-1/actions 中定义，文件是 XML 格式，以 .policy 结尾。每个操作都有一个默认的权限集合。

参见下面的示例：

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE policyconfig PUBLIC
 "-//freedesktop//DTD PolicyKit Policy Configuration 1.0//EN"
 "http://www.freedesktop.org/standards/PolicyKit/1.0/policyconfig.dtd">
<policyconfig>  <!-- Node1 -->
  <action id="org-opensuse-policykit-gparted">  <!-- Node2 -->
    <message>Authentication is required to run the GParted Partition Editor</message>
    <icon_name>gparted</icon_name>
    <defaults>  <!-- Node3 -->
      <allow_any>auth_admin</allow_any>
      <allow_inactive>auth_admin</allow_inactive>
     < allow_active>auth_admin</allow_active>
    </defaults>
    <!-- Node4 -->
    <annotate
      key="org.freedesktop.policykit.exec.path">/usr/sbin/gparted</annotate>
    <annotate
      key="org.freedesktop.policykit.exec.allow_gui">true</annotate>
  </action>
</policyconfig>
```


Node1：策略文件的根元素。

Node2(action id)：仅包含一个操作。

Node3(implicit authorizations)：defaults 元素包含多个权限，这些权限在 SSH、VNC 等远程会话中使用（allow_inactive 元素）、在通过 TTY 或 X 显示器直接登录到计算机时使用（allow_active 元素），或者在这两种情况下均可使用（allow_any 元素）。值 auth_admin 指示需要以管理用户的身份进行身份验证。

Node4(annotate)：annotate 元素包含有关 PolKit 如何执行操作的具体信息。在本例中，它包含可执行文件的路径，并指出是否允许 GUI 打开 X 显示器。



- action id

polkitd会加载 /usr/share/polkit-1/actions下所有的action，需要鉴权的应用需要根据定义的actionid调用polkitd接口去开启认证。

需要鉴权的应用定义action的 .policy由该应用自己维护，安装时安装到actions目录。

```go
// eg1:golang
import polkit "github.com/linuxdeepin/go-dbus-factory/org.freedesktop.policykit1"
authority := polkit.NewAuthority(systemBus)
ret, err = authority.CheckAuthorization(0, subject,actionId, nil, polkit.CheckAuthorizationFlagsAllowUserInteraction, "")
```

```c++
// eg2:qt/c++
#include <polkit-qt5-1/PolkitQt1/Authority>
using namespace PolkitQt1;
Authority::Result result;
result = Authority::instance()->checkAuthorizationSync(actionId, UnixProcessSubject(applicationPid),Authority::AllowUserInteraction);
if (result == Authority::Yes) {
	// ...
}
```



- implicit authorizations

包含三种设置：

```ini
[allow_any]
Implicit authorizations that apply to any client. Optional.
[allow_inactive]
Implicit authorizations that apply to clients in inactive sessions on local consoles. Optional.
[allow_active]
Implicit authorizations that apply to clients in active sessions on local consoles. Optional.
```

设置可选值：

```ini
[yes]
授予特权
[no]
拦截
[auth_self]
用户每次请求特权时都需要使用自己的口令进行身份验证
[auth_self_keep_session]
用户需要为每个会话使用自己的口令进行一次身份验证，会向其授予对整个会话的特权
[auth_self_keep_always]
用户需要使用自己的口令进行一次身份验证，会向其授予对当前及将来的会话的特权
[auth_admin]
用户每次请求特权时都需要使用 root 的口令进行身份验证
[auth_admin_keep_session]
用户需要为每个会话使用 root 的口令进行一次身份验证，会向其授予对整个会话的特权
[auth_admin_keep_always]
用户需要使用 root 的口令进行一次身份验证，会向其授予对当前及将来的会话的特权
```



- annotate

Used for annotating an action with a key/value pair.

以键值对的方式对action添加注释，即用于自定义的上下文。而其中polkit定义了一些key来额外的进行一些操作。

比如`org.freedesktop.policykit.exec.path annotation`：

```
The org.freedesktop.policykit.exec.path annotation is used by the **pkexec** program shipped with polkit - see the [pkexec(1)](https://www.freedesktop.org/software/polkit/docs/latest/pkexec.1.html) man page for details.
```

pkexec执行一个命令时，首先通过find_action_for_path，在 /usr/share/polkit-1/actions找annotation为"org.freedesktop.policykit.exec.path"的policy文件，如果path一致，则自动采用该policy文件的actionid来开启认证。如果没有找到，则用默认的action_id，即"org.freedesktop.policykit.exec"，该默认action的规则不在actions目录的policy文件中，直接在policykit-1项目的代码中描述。（详见[man pkexec](https://www.freedesktop.org/software/polkit/docs/latest/pkexec.1.html)）



2.2 认证规则（Authorization rules）

Changelog for polkit 0.106：from .pkla files (keyfile-format) to .rules files。

（1）Version >= 0.1.06

http://www.freedesktop.org/software/polkit/docs/latest/ref-api.html 上提供了 PolKit API 中各函数的所有类和方法的说明。

- 规则

以 JavaScript 文件形式编写，位于以下两个位置：

```
/usr/share/polkit-1/rules.d/（用于第三方软件包）
/etc/polkit-1/rules.d/（用于本地配置）
```

每个规则文件都会引用操作文件中指定的操作。规则确定允许对用户子集实施哪些限制。例如，某个规则文件可能会否决某个限制性权限，并且允许某些用户允许该权限。

- 优先级

此目录中的文件名以两位数开头，后接一个描述性名称，以 .rules 结尾。这些文件中的函数按其排序顺序执行。例如，00-foo.rules 排在 60-bar.rules 甚至 90-default-privs.rules 的前面（因而也会在它们的前面执行）。

polkitd reads .rules files from the /etc/polkit-1/rules.d and /usr/share/polkit-1/rules.d directories by sorting the files in lexical order based on the basename on each file (if there's a tie, files in /etc are processed before files in /usr). For example, for the following four files, the order is

```
/etc/polkit-1/rules.d/10-auth.rules
/usr/share/polkit-1/rules.d/10-auth.rules
/etc/polkit-1/rules.d/15-auth.rules
/usr/share/polkit-1/rules.d/20-auth.rules
```

- 语法

在文件中，脚本会检查 .policy 文件中定义的指定操作 ID。

例如，如果您要允许 admin 组的任何成员执行 gparted 命令，请检查操作 ID org.opensuse.policykit.gparted：

```javascript
/* Allow users in admin group to run GParted without authentication */
polkit.addRule(function(action, subject) {
    if (action.id == "org.opensuse.policykit.gparted" &&
        subject.isInGroup("admin")) {
        return polkit.Result.YES;
    }
});
```



（2）Version <  0.106

https://www.freedesktop.org/software/polkit/docs/0.105/pklocalauthority.8.html 上提供了pkla更多说明

- 规则

如果 PolKit 版本< 0.106， 没有 .rules 文件，只有旧文件 .pkla 和 .conf 文件.

位于以下两个位置：

```
/etc/polkit-1/
/var/lib/polkit-1/ （用于第三方软件包）
```

- 语法

和.rules类似，以ini的方式描述
```ini
# eg: 10-network-manager.pkla
[Greeter Active WIFI Connection]
# unix-user - 指定使用该规则的用户；unix-group - 指定使用该规则的组
# 多个以;分割，如domain users不是指两个组，而是一个叫“domain users”的组，如果指定两个组就用两个unix-group描述
Identity=unix-user:lightdm;unix-user:grimes;unix-group:domain users 
# 指定被约定的action，多个以;分割，可以使用通配符*
Action=org.freedesktop.NetworkManager.*;org.freedesktop.NetworkManager2
ResultAny=no
ResultInactive=no
ResultActive=yes
```









3 项目组成和实现

3.1 项目组成

- 项目：policykit-1

```shell
一个守护进程：polkitd
X个库文件：libpolkit-gobject-1、libpolkit-agent-1
X个工具：pkaction、pkcheck、pkexec、pkttyagent

## polkitd
  守护进程。

## libpolkit-gobject-1
  库文件。为特权进程提供API用来检测权限验证。

## libpolkit-agent-1
  库文件。为Authentication Agent提供API用来让用户输入口令认证。

## pkaction
  工具应用。查询当前系统实现的action。

## pkcheck
  工具应用。查询一个进程是否已经授权 。

## pkexec
  工具应用。
  pkexec跟其他使用polkit的应用不一样，默认不需要policy文件。

## pkttyagent
  工具应用。
  
  
  
policykit-1（policykit-1）
/usr/lib/policykit-1/polkit-agent-helper-1
/usr/lib/policykit-1/polkitd
/etc/polkit-1/nullbackend.conf.d/
/usr/lib/x86_64-linux-gnu/polkit-1/extensions/libnullbackend.so
/usr/share/deepin/deepin_security_verify.whitelist
/usr/share/polkit-1/actions/org.freedesktop.policykit.policy

libpolkit-agent-1-0（policykit-1）
/usr/lib/x86_64-linux-gnu/libpolkit-agent-1.so.0

libpolkit-gobject-1-0（policykit-1）
/usr/lib/x86_64-linux-gnu/libpolkit-gobject-1.so.0

libpolkit-backend-1-0（policykit-1）
/usr/lib/x86_64-linux-gnu/libpolkit-backend-1.so.0
```



- 项目：polkit-qt5-1

```
/usr/lib/x86_64-linux-gnu/libpolkit-qt5-agent-1.so.1
/usr/lib/x86_64-linux-gnu/libpolkit-qt5-core-1.so.1
/usr/lib/x86_64-linux-gnu/libpolkit-qt5-gui-1.so.1

libpolkit-qt5-1-1
```



- 项目：dde-polkit-agent

```
```









Authentication  Agent

dde-polkit-agent

polkit-agent-hepler-1





4 QA



怎么提权？

https://zhuanlan.zhihu.com/p/100404099 sudo、pkexec等提权方法







1，非admin用户self pkexec获取root权限

可以，但是修改pkexec对应配置文件本身就需要root

2，pkexec admin用有admin权限的用户都可以通过
3，sudo和polkit区别

不具备可比性，一个是提权工具，一个是认证发起者管理。

4，sudo和pkexec区别(错的，重新整理)

都是用于提权，提权前需要认证。sudo可以看作一个简化版的pkexec。

pkexec通过polkit开启认证，因此可以应用指定认证哪个用户是否认证等规则；sudo固定当前用户(错的，重新整理)，必须需要认证。

6，





5 dde定制





















