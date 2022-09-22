## [systemd.unit]



### ***Before=, After=***

强制指定单元之间的先后顺序，接受一个空格分隔的单元列表。 假定 foo.service 单元包含 Before=bar.service 设置， 那么当两个单元都需要启动的时候， bar.service 将会一直延迟到 foo.service 启动完毕之后再启动。 注意，停止顺序与启动顺序正好相反，也就是说， 只有当 bar.service 完全停止后，才会停止 foo.service 单元。 After= 的含义与 Before= 正好相反。

```
Before、After：
1，不会拉起相关单元
2，只在相关单元同时启动时才生效，如果不是同时启动，可以理解为Before、After没有作用。
```



### ***Requires=***

设置此单元所必须依赖的其他单元。如果此处列出的某个单元启动失败、并且恰好又设置了到这个失败单元的 After= 依赖，那么将不会启动此单元。此外，无论是否设置了到被依赖单元的 After= 依赖，只要某个被依赖的单元被显式停止，那么该单元也会被连带停止。

```
0，会拉起依赖的单元
1, 依赖的单元不存在，那自身单元也不会启动。依赖的单元存在但是启动失败，那自身单元也会启动。
2，依赖的单元<显式>（如systemctl stop为显示）停止时，自身单元会自动停止。
3，单元A存在Requires+After=B，Requires=C同时存在时，C会立刻启动，A会在B启动成功后启动
```



### ***Requisite=***

与 `Requires=` 类似。不同之处在于：当此单元启动时，这里列出的依赖单元必须已经全部处于启动成功的状态， 否则，此单元将会立即进入启动失败的状态，并且也不会启动那些尚未成功启动的被依赖单元。

```
0，当依赖的服务没启动，不会拉起依赖的单元，自身也直接失败。
1, 依赖的单元没有启动成功，那自身单元也不会启动。
2，依赖的单元停止时，自身单元会自动停止。
3，顺序可以打破Requisite规则，只有Requisite+After，才会在依赖的单元不是启动状态自身就不会启动。Requisite+Before 或者 Requisite+RequiredBy，在依赖的单元不是启动状态时自身可以启动成功。
4，Requisite+Before的用法。如test1.target中有Requisite+Before=test2.target，这里设置Requisite不是用于启动流程而是用于停止流程，有Requisite后，test2.target崩溃时，test1.target也会被停止（不用PartOf是因为，PartOf是停止和重启，不包含崩溃）。这里加个Before是因为，确保在test2没启动之前，test1能够正常启动。
```



### ***Wants=***

此选项是 `Requires=` 的弱化版。

```
0，会拉起依赖的单元
1, 依赖的单元没有启动成功，那自身单元也会启动。
2，依赖的单元停止时，自身单元不会自动停止。

对比Requires：
1，依赖的单元不存在，Wants也会启动，而Requires不会；
2，依赖的单元的停止或者重启，本单元都不会受影响；
```



### ***BindsTo=***

与 `Requires=` 类似，但是依赖性更强；如果这里列出的任意一个单元停止运行或者崩溃，那么也会连带导致该单元自身被停止。

```
0，会拉起依赖的单元
1, 依赖的单元没有启动成功，那自身单元也不会启动。
2，依赖的单元停止时，自身单元会自动停止。

对比Requires：
1，启动时，Requires会拉起依赖服务，但是依赖服务启动失败，本服务也会启动，而BindsTo在依赖服务启动失败时，本服务也会失败；
2，停止时，Requires只会在依赖显式停止时，本服务才会停止；而BindsTo在依赖非显式停止时（如崩溃），本服务也会停止；
```



### ***PartOf=***

与 `Requires=` 类似， 不同之处在于：仅作用于单元的停止或重启。 其含义是，当停止或重启这里列出的某个单元时， 也会同时停止或重启该单元自身。 注意，这个依赖是单向的， 该单元自身的停止或重启并不影响这里列出的单元。

```
对比Requires：
1， Requires包含PartOf的功能的。
2， PartOf缺少Requires的拉起依赖Unit的功能；
```



### ***模版***

单元文件可以通过一个"实例名"参数从"模板文件"构造出来(这个过程叫"实例化")。 "模板文件"(也称"模板单元"或"单元模板")是定义一系列同类型单元的基础。 模板文件的名称必须以 "@" 结尾(在类型后缀之前)。 通过实例化得到的单元，其完整的单元名称是在模板文件的类型后缀与 "@" 之间插入实例名称形成的。在通过实例化得到的单元内部， 可以使用 "%i" 以及其他说明符来引用实例参数。

如上所述，单元可以从模板实例化而来。 这样就可以用同一个模板文件衍生出多个单元。 当 systemd 查找单元文件时，会首先查找与单元名称完全吻合的单元文件， 如果没有找到，并且单元名称中包含 "@" 字符， 那么 systemd 将会继续查找拥有相同前缀的模板文件， 如果找到，那么将从这个模板文件实例化一个单元来使用。 例如，对于 getty@tty3.service 单元来说， 其对应的模板文件是 getty@.service (也就是去掉 "@" 与后缀名之间的部分)。

可以在模板文件内部 通过 "%i" 引用实例字符串(也就是上例中的"tty3")。

```
1，实例名称可以传递
test4@.target中有BindsTo=test5@.target，
systemctr start test4@11.target时，会启动一个单元test5@11.target
```



### ***程序退出状态***

显式停止：程序由systemd控制退出的

隐式停止：程序自身退出（包含崩溃、return等）



- 程序崩溃

Requires不退出，BindsTo退出

>Active: failed (Result: exit-code) since Wed 2022-08-24 18:32:58 CST; 886ms ago
>Process: 24367 ExecStart=/home/feng08/code/go/src/hello/hello-d (code=exited, status=2)
>Main PID: 24367 (code=exited, status=2)

- 程序return 0

Requires不退出，BindsTo退出

>Active: inactive (dead) since Wed 2022-08-24 18:34:37 CST; 692ms ago
>Process: 24819 ExecStart=/home/feng08/code/go/src/hello/hello-r0 (code=exited, status=0/SUCCESS)
>Main PID: 24819 (code=exited, status=0/SUCCESS)

- 程序return 1

Requires不退出，BindsTo退出

> Active: failed (Result: exit-code) since Wed 2022-08-24 18:39:36 CST; 258ms ago
> Process: 26791 ExecStart=/home/feng08/code/go/src/hello/hello-r1 (code=exited, status=1/FAILURE)
> Main PID: 26791 (code=exited, status=1/FAILURE)

- 程序return -1

Requires不退出，BindsTo退出

> Active: failed (Result: exit-code) since Wed 2022-08-24 18:40:28 CST; 274ms ago
> Process: 27184 ExecStart=/home/feng08/code/go/src/hello/hello-r-1 (code=exited, status=255/EXCEPTION)
> Main PID: 27184 (code=exited, status=255/EXCEPTION)

- systemctrl stop

> Active: inactive (dead)





### ***几种Unit关系差异表***

A为当前服务，B为依赖的服务；

启、停：启动、停止

重启：如systemctl restart X，[Service]中的Restart=always这个重启也会生效这个依赖规则；

|           | A启B启 | A停B停 | B显停A停 | B隐停A停 | B重启A重启 | B启A启 |
| --------- | ------ | ------ | -------- | -------- | ---------- | ------ |
| Requires  | 是     | 否     | 是       | 否       | 是         | 否     |
| Requisite | 否     | 否     | 是       | 否       | 是         | 否     |
| PartOf    | 否     | 否     | 是       | 否       | 是         | 否     |
| BindsTo   | 是     | 否     | 是       | 是       | 是         | 否     |
| Wants     | 是     | 否     | 否       | 否       | 否         | 否     |

"B隐停A停"补充说明：B崩溃时，B是隐式停止，然后自动停止A，A其实是属于显式停止；

"B重启A重启"补充说明：B重启时，A在运行状态A才会被重启；

“A启B启”补充说明：因为依赖，启动A时先自动启动B。B的不同状态对A的启动也有影响；

|           | A启时，B的service不存在或错误service | A启时，B的service存在但自动启动失败 | A启时，B的service存在且自动启动成功 |
| --------- | ------------------------------------ | ----------------------------------- | ----------------------------------- |
| Requires  | A不会启动                            | A能启动                             | A能启动                             |
| BindsTo   | A不会启动                            | A不会启动                           | A能启动                             |
| Wants     | A能启动                              | A能启动                             | A能启动                             |
| PartOf    | 特殊：A独立启动，不依据B的情况       | 特殊：A独立启动，不依据B的情况      | 特殊：A独立启动，不依据B的情况      |
| Requisite | 特殊：A启动时，B需要已在运行         | 特殊：A启动时，B需要已在运行        | 特殊：A启动时，B需要已在运行        |



### Unit关系配置方法

- 无依赖

  Unit不使用Requires、Wants等关系配置，独立运行；

- 仅启动依赖

  Unit期望，只被其他Unit自动拉起来运行，但不会因其他Unit而退出。

  ```ini
  [Unit]
  Description=service
  # Unit中不使用Requires、Wants等关系配置
  [Service]
  # 可以通过Restart自己维护自己的启停
  Restart=always
  [Install]
  # 由xx.target拉起，需要systemctl enable生效，自动生效见<WantsBy=>
  WantsBy=xx.target
  ```

  

- 启停依赖

  Unit A强依赖某个Unit B，Unit B退出后，Unit A无法正常工作。Unit B重启时，Unit A也需要伴随重启。

  ```ini
  [Unit]
  Description=service
  # 用Requires，xx.target退出或重启，也会导致当前Unit退出或重启
  # 注意Requires只会在xx.target显式停止时，当前Unit才会受影响，见<程序退出状态>和<几种Unit关系差异表>
  # 用于xx.target BintsTo xx.service关联的方式，xx.service哪怕隐式停止，xx.target也只会显式停止
  Requires=xx.target
  [Service]
  # 被xx.target影响自动停止时，这里的Restart没什么用，不生效
  # Restart=always
  [Install]
  # 由xx.target拉起
  WantsBy=xx.target
  ```





### ***WantsBy=***







### ***Conflicts***=

指定单元之间的冲突关系。 接受一个空格分隔的单元列表，表明该单元不能与列表中的任何单元共存， 也就是说：

(1)当此单元启动的时候，列表中的所有单元都将被停止；

 (2)当列表中的某个单元启动的时候，该单元同样也将被停止。 注意，此选项与 After= 和 Before= 选项没有任何关系。

```shell
# conflicts/after组合
# bbb.target配置如下
Conflicts=aaa.target
After=aaa.target
# 作用
Conflicts和After没有直接关系，这里组合使用决定了，如果几个互斥的服务被同时拉起，这几个互斥的服务谁留到最后。
如c.target同时want了bbb.target和aaa.target，最终保留的都是bbb.target
```



### ***OnFailure=***

接受一个空格分隔的单元列表。 当该单元进入失败("failed")状态时， 将会启动列表中的单元。

（1）注意什么场景时状态为"failed"，见<***程序退出状态***>

（2）如果使用了 Restart= 的服务单元仅在超出启动频率限制之后， 才会进入失败(failed)状态。



##  [systemd.service]

### ***Type=***

- Type=simple

service的状态是绑定ExecStart指定的二进制的，二进制退出，则服务停止

```ini
[Service]
Type=simple
ExecStart=/home/feng08/code/go/src/hello/hello
```



- Type=dbus

service的状态是绑定BusName指定的dbus服务的，dbus服务不存在了，则服务停止

```ini
# /usr/lib/systemd/user/com.test1.service
[Service]
Type=simple
BusName=com.deepin.test1
ExecStart=/home/feng08/code/go/src/hello/hello
```

上述配置描述了com.test1.service的systemd服务，start com.test1.service后，直到“com.deepin.test1”的dbus服务起来后，该systemd服务才认为启动完成。



拓展dbus服务的应用：

```ini
# /usr/share/dbus-1/services/com.deepin.test1.service
[D-BUS Service]
Name=com.deepin.test1
Exec=/home/feng08/code/go/src/hello/hello
SystemdService=com.test1.service
```

对一个dbus服务（如com.deepin.test1）发起一个调用时，先检查dbus总线中该dbus服务是否已经运行，如果是则直接调用。

如果该dbus服务未运行，会去/usr/share/dbus-1/services/找是否有该服务的service文件，如果没有则调用失败。

如果有，则根据service文件来启动该dbus服务。

***如果没有配置“SystemdService”， 该dbus服务会直接运行“Exec”指定的二进制完成启动；***

> 1, 在dbus服务未启动完成前，如果多个调用请求拉起同一个dbus服务（如com.deepin.test1.service），最终只会运行一个hello进程；
>
> 2, 在dbus服务未启动完成前，如果多个调用请求拉起不同一个dbus服务（如com.deepin.test1.service和com.deepin.test2.service，com.deepin.test2.service的Exec也是“/home/feng08/code/go/src/hello/hello”）。最终会运行两个hello进程；

***如果配置了“SystemdService”， 该dbus服务会通过start com.test1.service的systemd服务来完成启动；***

> 1, 如果调用请求拉起同一个dbus服务（如com.deepin.test1.service），在systemd服务com.test1.service实际启动完成前，
>
> 通过别的方式start com.test1.service，最终只会运行一个hello进程；



- Type=notify

该服务将会在启动完成之后通过 sd_notify(3)之类的接口发送一个通知消息。systemd收到该消息才认为该service启动完成

```ini
[Service]
Type=notify
NotifyAccess=all
ExecStart=/home/feng08/code/go/src/hello/hello
```

NotifyAccess可以设为 none(默认值), main, exec, all 之一。 none 表示不更新任何守护进程的状态，忽略所有状态更新消息。 main 表示仅接受主进程的状态更新消息。 exec 表示仅接受主进程以及 Exec*= 进程的状态更新消息。 all 表示接受该服务cgroup内所有进程的状态更新消息。

golang sd_notify：

```go
cmd := exec.Command("systemd-notify", "--ready")
cmd.Start() # 该方式是子进程发送的notify， NotifyAccess=main时不生效，需要设置为all
```

c++ sd_notify：

```c++
# 库依赖， pkg_check_modules(Systemd REQUIRED IMPORTED_TARGET libsystemd)
#include <systemd/sd-daemon.h>
sd_notify(0, "READY=1");
```



### ***Restart***=

当服务进程 正常退出、异常退出、被杀死、超时的时候， 是否重新启动该服务。

当进程是由于 systemd 的正常操作(例如 systemctl stop|restart)而被停止时， 该服务不会被重新启动。

***如当前服务Requires依赖的服务停止导致当前服务停止，当前服务是由systemd停止，相当于stop操作，当前服务的Restart不生效；***





## [slice和scope]

slice和scope都是对systemd下unit的分组方法。

slice：以 "`.slice`" 为后缀的单元文件，用于封装管理一组进程资源占用的控制组的 slice 单元。

scope：范围(scope)单元并不通过单元文件进行配置， 而是仅能以编程的方式通过 systemd D-Bus 接口创建。 范围单元的名称都以 ".scope" 作为后缀。 与服务(service)单元不同，范围单元用于管理 一组外部创建的进程， 它自身并不派生(fork)任何进程。



1，scope无法通过unit文件配置，也就意味着，要指定某个unit运行到某个scope，都是在程序中显式指定的。即，通过例如配置Requires后由systemd自启动的unit无法指定到具体的某个scope。systemd自启动的unit自有一套通过配置unit文件的自动启动和自动停止的方法，不应该对unit文件配置的unit用scope分组。

2，slice用于对unit文件配置的unit进行分组，scope用于对没有unit文件的外部进程（临时unit）进行分组。



- slice分组方法

（1）在unit的文件中，添加：

```
[Service]
Slice=test.slice
```

如果test.slice文件存在，直接用test.slice，如果不存在也会成功，会自动创建临时slice。

（3）多层级slice

```
# test.service
[Service]
Slice=app1-box1-test.slice
```

通过命令中的“-”来约定层级，上述test.service运行后，层级如下：

```
app1.slice
   └─app1-box1.slice
            └─app1-box1-test.slice
                      └─test.service

```

同样，这3个slice，任意一个如果存在对应slice文件，如app1-box1.slice，则直接用这个文件的slice，如果不存在则临时slice。



- scope分组方法

用systemd提供的dbus接口：StartTransientUnit，指定pid的进程到某个scope。

```
cmd := exec.Command(filePath, args...)
cmd.Start()

userSystemd = systemd1.NewManager(service.Conn())
unitName := fmt.Sprintf("app-dde-%s-%d.scope", appID, pid)

properties := []systemd1.Property{
	{
		Name:  "Description",
		Value: dbus.MakeVariant("Launched by DDE"),
	},
	{
		Name:  "PIDs",
		Value: dbus.MakeVariant([]uint{pid}),
	},
	{
		Name:  "CollectMode",
		Value: dbus.MakeVariant("inactive-or-failed"),
	},
}
userSystemd.StartTransientUnit(0, unitName, "fail", properties, nil)
```



## [systemd.timer]

以 ".timer" 为后缀的单元文件， 封装了一个由 systemd 管理的定时器， 以支持基于定时器的启动。

如果在启动时间点到来的时候，匹配的单元已经被启动， 那么将不执行任何动作，也不会启动任何新的服务实例。

timer单元不会阻塞，等待期间认为timer单元已完成启动。

timer单元同样可以用[Unit]配置，可以以此设置启动顺序。

```ini
# A.timer
[Unit]
After=B.target
[Timer]
OnActiveSec=5s # 相对于该单元自身被启动的时间点
AccuracySec=100ms # 定时器的触发精度
RandomizedDelaySec=1s # 随机延迟一小段时间，避免造成资源争抢
RemainAfterElapse=no
Unit=A.service
```

- Unit=

每个定时器单元都必须有一个与其匹配的单元， 用于在特定的时间启动。如不指定Unit=，则默认是与该单元名称相同的 .service 单元(不算后缀)。

- RemainAfterElapse=

timer单元定时结束，启动A.service后，timer单元本身不会退出，仍为运行状态；

当RemainAfterElapse=yes，A.service停止后，timer单元变为Elapse状态，再次start A.timer，不会再生效；

当RemainAfterElapse=no，A.service停止后，timer单元变为inactive状态，再次start A.timer，会再生效；



## [systemctl]

### ***Auto Enable***





## [启动流程]

我们可以这么来梳理一下linux桌面登录场景。

1、如果systemd设置了开机启动display manager(通常就会在/etc/systemd/system目录下找到display-manager.service)，那么就会首先启动dm，现在流行的dm有多种实现，主流的包括lightdm(ubuntu、deepin、uos等都是用的这个)，sddm(plasma用的就是这种)等。上面说的display-manager.service往往只是具体的dm的一个软链接。当然往往这个dm的service需要设置alisa字段，要不然在enable的时候可不会自动关联到dm上面来。

2、dm启动后，通常会占用tty1(这个是可配置的)，然后加载出登录界面(greeter)，用户通过在对话框中输入用户名密码进行pam验证。验证成功后，dm会重新拉起一个子进程，并开启一个新的session(应该是调用logind的相关接口来实现的)，这个新的session就对应新用户，同时会设置各种XDG以及SESSION相关的环境变量。同时会启动对应的session dbus。然后拉起窗口管理服务(wm，比如xorg或者kwinwayland、kwin_x11之类的)。接着拉起整个桌面环境。后面拉起来的这些进程都是用户级别的，可以访问到同一条session dbus的。

3、当需要切换到新用户的时候。桌面会调用dm的切换用户相关的接口。dm来触发用户切换流程。通常会在systemd上创建一个新的session，然后把这个新的session激活，同时上一个session就会处于非激活状态(但是相关的进程都是在运行的)，然后重新拉起窗口管理服务和桌面环境(上面说了这些进程都是用户级别，所以没创建一个新的登录session都会创建窗口管理服务和桌面环境)。然后就切换到了新用户的桌面环境下了。





