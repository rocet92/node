# 桌面环境调研1

kde、xfce、gnome

原因之一是KDEConnect，它与安卓手机之间的互动比较好，目前没有发现其替代品。

经评论如网友提醒，现在GNOME也可以通过gsconnect与安卓互动，不过需要3.24及以上

session2.scope: start\_kdeinit, kdeinit5, klauncher, kded5等

TODO：kde运行环境概览

TODO：kframwork

TODO：熟悉dde-service-manager，是否适合在这上面改造

```
Control group /:
-.slice
├─user.slice
│ └─user-1000.slice
│   ├─user@1000.service
│   │ ├─xdg-permission-store.service
│   │ │ └─1011 /usr/libexec/xdg-permission-store
│   │ ├─session.slice
│   │ │ ├─xdg-document-portal.service
│   │ │ │ ├─1007 /usr/libexec/xdg-document-portal
│   │ │ │ └─1018 fusermount3 -o rw,nosuid,nodev,fsname=portal,auto_unmount,subtype=portal -- /run/user/1000/doc
│   │ │ ├─xdg-desktop-portal.service
│   │ │ │ └─996 /usr/libexec/xdg-desktop-portal
│   │ │ ├─pipewire-media-session.service
│   │ │ │ └─1061 /usr/bin/pipewire-media-session
│   │ │ ├─plasma-xdg-desktop-portal-kde.service
│   │ │ │ └─1045 /usr/lib/x86_64-linux-gnu/libexec/xdg-desktop-portal-kde
│   │ │ └─pipewire.service
│   │ │   └─1060 /usr/bin/pipewire
│   │ ├─background.slice
│   │ │ ├─plasma-kactivitymanagerd.service
│   │ │ │ └─1090 /usr/lib/x86_64-linux-gnu/libexec/kactivitymanagerd
│   │ │ ├─plasma-kscreen.service
│   │ │ │ └─1240 /usr/lib/x86_64-linux-gnu/libexec/kf5/kscreen_backend_launcher
│   │ │ └─plasma-kglobalaccel.service
│   │ │   └─1093 /usr/bin/kglobalaccel5
│   │ ├─pulseaudio.service
│   │ │ ├─834 /usr/bin/pulseaudio --daemonize=no --log-target=journal
│   │ │ └─878 /usr/libexec/pulse/gsettings-helper
│   │ ├─app.slice
│   │ │ ├─app-org.kde.konsole-2a3dd93489174085b3ae62137a9e18fb.scope
│   │ │ │ ├─1327 /usr/bin/konsole
│   │ │ │ ├─1337 /bin/bash
│   │ │ │ ├─2203 systemd-cgls
│   │ │ │ └─2204 pager
│   │ │ └─app-firefox-463f15a98c444438a245e897e0a801d8.scope
│   │ │   ├─1877 /usr/lib/firefox/firefox
│   │ │   ├─1943 /usr/lib/firefox/firefox -contentproc -parentBuildID 20220519220738 -prefsLen 1 -prefMapSize 238956 -appDi>
│   │ │   ├─2016 /usr/lib/firefox/firefox -contentproc -childID 1 -isForBrowser -prefsLen 1976 -prefMapSize 238956 -jsInitL>
│   │ │   └─2160 /usr/lib/firefox/firefox -contentproc -childID 6 -isForBrowser -prefsLen 9572 -prefMapSize 238956 -jsInitL>
│   │ ├─init.scope
│   │ │ ├─827 /lib/systemd/systemd --user
│   │ │ └─828 (sd-pam)
│   │ ├─xdg-desktop-portal-gtk.service
│   │ │ └─1027 /usr/libexec/xdg-desktop-portal-gtk
│   │ ├─obex.service
│   │ │ └─1245 /usr/lib/bluetooth/obexd
│   │ ├─at-spi-dbus-bus.service
│   │ │ ├─971 /usr/libexec/at-spi-bus-launcher
│   │ │ ├─976 /usr/bin/dbus-daemon --config-file=/usr/share/defaults/at-spi2/accessibility.conf --nofork --print-address 3
│   │ │ └─993 /usr/libexec/at-spi2-registryd --use-gnome-session
│   │ └─dbus.service
│   │   ├─ 855 /usr/bin/dbus-daemon --session --address=systemd: --nofork --nopidfile --systemd-activation --syslog-only
│   │   ├─ 956 /usr/libexec/ibus-portal
│   │   ├─1040 /usr/libexec/dconf-service
│   │   └─1068 /usr/bin/gnome-keyring-daemon --start --foreground --components=secrets
│   └─session-3.scope
│     ├─ 825 /usr/lib/x86_64-linux-gnu/sddm/sddm-helper --socket /tmp/sddm-authea246ee8-2177-4f04-a66f-79144bda446f --id 1 >
│     ├─ 838 /usr/bin/gnome-keyring-daemon --daemonize --login
│     ├─ 846 /usr/bin/kwalletd5 --pam-login 13 14
│     ├─ 847 /usr/bin/startplasma-x11
│     ├─ 922 /usr/bin/ssh-agent /usr/bin/im-launch /usr/bin/startplasma-x11
│     ├─ 944 /usr/bin/ibus-daemon --daemonize --xim
│     ├─ 947 /usr/libexec/ibus-dconf
│     ├─ 949 /usr/libexec/ibus-ui-gtk3
│     ├─ 951 /usr/libexec/ibus-extension-gtk3
│     ├─ 953 /usr/libexec/ibus-x11 --kill-daemon
│     ├─1002 /usr/bin/plasma_session
│     ├─1015 /usr/libexec/ibus-engine-simple
│     ├─1028 /usr/lib/x86_64-linux-gnu/libexec/kf5/start_kdeinit
│     ├─1032 kdeinit5: Running...
│     ├─1041 /usr/lib/x86_64-linux-gnu/libexec/kf5/klauncher --fd=9
│     ├─1065 /usr/bin/kded5
│     ├─1076 /usr/bin/kwin_x11
│     ├─1091 /usr/bin/ksmserver
│     ├─1103 /usr/bin/plasmashell
│     ├─1107 /usr/bin/xsettingsd
│     ├─1109 /usr/lib/x86_64-linux-gnu/libexec/polkit-kde-authentication-agent-1
│     ├─1115 /usr/lib/x86_64-linux-gnu/libexec/org_kde_powerdevil
│     ├─1125 /usr/lib/x86_64-linux-gnu/libexec/baloo_file
│     ├─1132 /usr/bin/xembedsniproxy
│     ├─1134 /usr/bin/kaccess
│     ├─1138 /usr/bin/gmenudbusmenuproxy
│     ├─1144 /usr/lib/x86_64-linux-gnu/libexec/DiscoverNotifier
│     ├─1155 /usr/lib/x86_64-linux-gnu/libexec/kdeconnectd
│     └─1201 /usr/libexec/geoclue-2.0/demos/agent
├─init.scope
│ └─1 /sbin/init splash
└─system.slice
  ├─irqbalance.service
  │ └─534 /usr/sbin/irqbalance --foreground
  ├─systemd-udevd.service
  │ └─351 /lib/systemd/systemd-udevd
  ├─cron.service
  │ └─520 /usr/sbin/cron -f
  ├─polkit.service
  │ └─546 /usr/lib/policykit-1/polkitd --no-debug
  ├─networkd-dispatcher.service
  │ └─545 /usr/bin/python3 /usr/bin/networkd-dispatcher --run-startup-triggers
  ├─rtkit-daemon.service
  │ └─836 /usr/libexec/rtkit-daemon
  ├─accounts-daemon.service
  │ └─515 /usr/lib/accountsservice/accounts-daemon
  ├─wpa_supplicant.service
  │ └─557 /sbin/wpa_supplicant -u -s -O /run/wpa_supplicant
  ├─ModemManager.service
  │ └─614 /usr/sbin/ModemManager
  ├─systemd-journald.service
  │ └─315 /lib/systemd/systemd-journald
  ├─NetworkManager.service
  │ └─523 /usr/sbin/NetworkManager --no-daemon
  ├─rsyslog.service
  │ └─548 /usr/sbin/rsyslogd -n -iNONE
  ├─cups-browsed.service
  │ └─603 /usr/sbin/cups-browsed
  ├─smartmontools.service
  │ └─549 /usr/sbin/smartd -n
  ├─cups.service
  │ └─591 /usr/sbin/cupsd -l
  ├─upower.service
  │ └─785 /usr/lib/upower/upowerd
  ├─sddm.service
  │ ├─611 /usr/bin/sddm
  │ └─718 /usr/lib/xorg/Xorg -nolisten tcp -background none -seat seat0 vt1 -auth /var/run/sddm/45a16781-8781-4b22-b6f5-9e6>
  ├─systemd-resolved.service
  │ └─463 /lib/systemd/systemd-resolved
  ├─udisks2.service
  │ └─556 /usr/lib/udisks2/udisksd
  ├─acpid.service
  │ └─516 /usr/sbin/acpid
  ├─dbus.service
  │ └─522 /usr/bin/dbus-daemon --system --address=systemd: --nofork --nopidfile --systemd-activation --syslog-only
  ├─systemd-timesyncd.service
  │ └─464 /lib/systemd/systemd-timesyncd
  ├─avahi-daemon.service
  │ ├─519 avahi-daemon: running [uos-neon.local]
  │ └─562 avahi-daemon: chroot helper
  └─systemd-logind.service
    └─555 /lib/systemd/systemd-logind
```

kinit

桌面初始核心服务，启动加速、内存优化。

> Using kdeinit to launch KDE applications makes starting a typical KDE applications 2.5 times faster (100ms instead of 250ms on a P-III 500) It reduces memory consumption by approx. 350Kb per application.

原理：kinit链接所有标准KDE应用需要的库，通过先fork，然后以动态库方式加载KDE应用的方式，节省了kde应用去链接库这个步骤，以此达到启动优化目的。

1， kinit主进程先fork再exec

```
static pid_t launch(int argc, const char *_name, const char *args...
{
    // ...
    // 用pipe和子进程通信
    if (0 > pipe(d.fd)) {
        // ...
        return d.fork;
    }

    d.fork = fork();
    switch (d.fork) {
    case -1:
        // ...
        break;
    case 0: {
        /** Child **/
        close(d.fd[0]);
        close_fds();
        if (!executable.isEmpty()) {
            execvp(executable.constData(), d.argv);
        }
        write(d.fd[1], &d.result, 1);
        close(d.fd[1]);
        exit(255);
        break;
    }
    default:
        /** Parent **/
        close(d.fd[1]);
        // ...
        close(d.fd[0]);
    }
    return d.fork;
}
```

2，插件的外部申明

```
// 插件用kdemain替换main
extern "C" int kdemain(int argc, char* argv[]);
// kdeinitmain：插件以动态库的方式启动
extern "C" int kdeinitmain(int argc, char* argv[]) { return kdemain(argc,argv); }
// main：插件以子进程的方式启动
int main(int argc, char* argv[]) { return kdemain(argc,argv); }
```

C/C++共享库的启动速度和分析

模拟kinit原理，分别验证加载动态库运行和子进程运行对内存和启动速度的影响。

demo源码：https://gitlabwh.uniontech.com/ut003444/cpp\_plugin\_demo

1，测试变量：链接的很多不被使用的库${LIBS1}、${LIBS2}

|                                          | 虚拟内存(kb) | CODE(kb) | 常驻内存(kb) | 共享内存(kb) | 启动耗时(ms) |
| ---------------------------------------- | -------- | -------- | -------- | -------- | -------- |
| 一个只有main的进程，且不额外链接库                      | 7928     | 8        | 1992     | 1748     | 2        |
| 一个只有main的进程，但会额外链接${LIBS1}、${LIBS2}共几十个库 | 328884   | 8        | 61224    | 49832    | 85       |

分析：

* 链接过多会影响启动速度
* 只链接动态库不用，大部分只是算在虚拟内存不会占用实际内存。而占用实际内存的大部分是占用的共享内存。

2，插件测试

测试1：插件和主进程一样的链接库

| 测试变量                | 进程和插件           | 虚拟内存(kb) | 常驻内存(kb) | 共享内存(kb) | 启动耗时(ms) |
| ------------------- | --------------- | -------- | -------- | -------- | -------- |
| 不额外链接库              | 主进程             | 7928     | 1992     | 1748     | 2        |
| 不额外链接库              | 插件以子进程方式运行      | 5528     | 1656     | 1492     | 1        |
| 不额外链接库              | 插件以动态库方式运行(-l)  | 7928     | 304      | 0        | 1        |
| 链接${LIBS1}、${LIBS2} | 主进程             | 328908   | 60712    | 49260    | 95       |
| 链接${LIBS1}、${LIBS2} | 插件以子进程方式运行      | 328841   | 61588    | 50208    | 72       |
| 链接${LIBS1}、${LIBS2} | 插件以动态库方式运行(-l)  | 328908   | 14316    | 2800     | 3        |
| 链接${LIBS1}、${LIBS2} | 插件独立运行（不由主进程拉起） | 328904   | 61396    | 49996    | 75       |

分析：

* 无论插件是独立运行，还是由主进程拉起，只要是进程的方式，启动耗时都会很长，而以动态库方式运行则启动很快（共享了主进程的资源）
* 无论插件是独立运行，还是由主进程拉起，只要和主进程链接的相同的库，那么会链接的库占用的共同的共享内存（动态库的机制，验证了系统内存只消耗了RSS-SHR的大小）
* 插件以动态库方式运行，常驻内存很低，同样是因为共享了主进程资源。
* 插件以子进程方式运行虽然和主进程共用了共享内存，但是都需要进行链接，都维护虚拟内存到共享内存的映射，但是插件以动态库方式运行时，插件无需额外处理链接库的事情，全部由主进程完成了。

测试2：插件链接更多的库

| 测试变量                | 进程和插件      | 虚拟内存(kb) | 常驻内存(kb) | 共享内存(kb) | 启动耗时(ms) |
| ------------------- | ---------- | -------- | -------- | -------- | -------- |
| 链接${LIBS1}          | 主进程        | 294980   | 52872    | 43532    | 79       |
| 链接${LIBS1}、${LIBS2} | 插件以子进程方式运行 | 328904   | 61652    | 50268    | 76       |

分析：

* 结论预期同测试1

测试3：插件链接更多的库

| 测试变量                | 进程和插件          | 虚拟内存(kb) | 常驻内存(kb) | 共享内存(kb) | 启动耗时(ms) |
| ------------------- | -------------- | -------- | -------- | -------- | -------- |
| 链接${LIBS1}          | 主进程            | 328904   | 61692    | 50304    | 88       |
| 链接${LIBS1}、${LIBS2} | 插件以动态库方式运行(-l) | 328904   | 13968    | 2452     | 1        |

分析：

* 结论预期同测试1，主进程会把链接的事情都做了，结合测试2，主进程内存占用增加到链接${LIBS1}、${LIBS2}应有的期望。

测试4：对比测试3，以dlopen的方式加载动态库

| 测试变量                | 进程和插件              | 虚拟内存(kb) | 常驻内存(kb) | 共享内存(kb) | 启动耗时(ms) |
| ------------------- | ------------------ | -------- | -------- | -------- | -------- |
| 链接${LIBS1}          | 主进程                | 294980   | 54116    | 44592    | 80       |
| 链接${LIBS1}、${LIBS2} | 插件以动态库方式运行(dlopen) | 328832   | 31720    | 20208    | 50       |

分析：

* 测试4，结论预期符合测试2和测试3的结合，dlopen是运行态加载插件的动态库，因此主进程只处理${LIBS1}的链接，同时插件不再处理${LIBS1}，交给了主进程，在运行过程中加载插件动态库时再去处理${LIBS2}的链接

3，结论

* 如果插件以子进程方式运行，那么在内存和启动速度角度，跟插件独立运行基本没啥区别。
* 如果插件以动态库方式运行，由于共享内存机制，对于节约内存实际也没多大作用，但是对启动速度确实有很大的提升。
* 如果插件以动态库方式运行，只能用类似dlopen方式运行态加载动态库，否则会导致主进程甚至把暂时不会用到的插件的链接库也加载了，造成严重浪费。

kinit续

kinit加载动态库的方式虽然有一些好处，但是会导致插件的进程名变成kinit，因此导致如无法用killall 插件名来杀掉插件进程，kde实现了kdekillall来解决这个问题。但是从目前kde环境来看，类似klauncher等插件进程，都是直接以子进程的方式启动的，并不是用的动态库的方式。

```
static void start_klauncher()
{
    // ...
    d.launcher_pid = launch(2, KDE_INSTALL_FULL_LIBEXECDIR_KF5 "/klauncher", args);
    // ...
}
```

kded

kded插件化加载dbus服务原理

* 核心两个因素

> 1，插件是一个动态库，kded通过QPluginLoader加载动态库（类似dlopen）
>
> 2，通过修改qtdbus源码，增加kded的回调hook，来实现按需启动

* kded官方不建议随意增加module，会降低稳定性

> A KDED module is loaded when a call is made to it. KDED modules should not be added if it is avoidable because (especially when new) they endanger the stability of KDED and its other modules which provide important services. There are other ways to achieve what a KDED module can do in many cases. KDED modules should be useful during the whole session and manage information that, for some reason, cannot be kept in any other process.
>
> by https://invent.kde.org/frameworks/kded/-/blob/master/docs/HOWTO

*   缺点

    TODO
* Module配置文件（最新neon系统的kde环境并没用到该配置）

```shell
# A KDED module should install a .desktop file with
ServicesTypes=KDEDModule
# A KDED module will be loaded on KDE startup if it has a line
X-KDE-Kded-autoload=true
# The exact way autoloading works is controlled by
X-KDE-Kded-phase=0, 1 or 2
# Normally KDED modules are loaded whenever they are accessed, so you don't need autoloading enabled. if not:
X-KDE-Kded-load-on-demand=false
# Which means that kded_foo.so is the name of the library that contains the module
X-KDE-Library=foo
# The .desktop file should be installed to ${SERVICES_INSTALL_DIR}/kded
```

* kded怎么按需启动？

1，qtbase在分发dbus请求前，增加hook处理

qtbase提供注册方法：

```
// qtbase/src/dbus/qdbusintegrator.cpp
extern Q_DBUS_EXPORT void qDBusAddSpyHook(QDBusSpyCallEvent::Hook);
void qDBusAddSpyHook(QDBusSpyCallEvent::Hook hook)
{
    qDBusSpyHookList()->append(hook);
}
```

qtbase根据注册的hook，在dbus分发时预处理：

```
// qtbase/src/dbus/qdbusintegrator.cpp
bool QDBusConnectionPrivate::handleMessage(const QDBusMessage &amsg)
{
    const QDBusSpyHookList *list = qDBusSpyHookList();
    for (int i = 0; i < list->size(); ++i) {
        qDBusDebug() << "calling the message spy hook";
        (*(*list)[i])(amsg);
    }
    switch (amsg.type()) {
    case QDBusMessage::SignalMessage:
        handleSignal(amsg);
        return true;
        break;
    case QDBusMessage::MethodCallMessage:
        handleObjectCall(amsg);
        return true;
    case QDBusMessage::ReplyMessage:
    case QDBusMessage::ErrorMessage:
        return false;           // we don't handle those here
    case QDBusMessage::InvalidMessage:
        Q_ASSERT_X(false, "QDBusConnection", "Invalid message found when processing");
        break;
    }
    return false;
}
```

2，kded注册hook，按需启动的Module被调用时，即时loadModule，为该module加载dbus服务（registerObject）

```
// kded/src/kded.cpp
qDBusAddSpyHook(messageFilter);

void Kded::messageFilter(const QDBusMessage &message)
{
    // This happens when kded goes down and some modules try to clean up.
    if (!self()) {
        return;
    }

    QString obj = KDEDModule::moduleForMessage(message);
    if (obj.isEmpty() || obj == QLatin1String("ksycoca")) {
        return;
    }

    if (self()->m_dontLoad.value(obj, nullptr)) {
        return;
    }

    self()->loadModule(obj, true);
}
```

```
void KDEDModule::setModuleName(const QString &name)
{
    d->moduleName = name;
    QDBusObjectPath realPath(QLatin1String("/modules/") + d->moduleName);

    if (realPath.path().isEmpty()) {
        qCWarning(KDBUSADDONS_LOG) << "The kded module name" << name << "is invalid!";
        return;
    }

    QDBusConnection::RegisterOptions regOptions;

    if (this->metaObject()->indexOfClassInfo("D-Bus Interface") != -1) {
        // 1. There are kded modules that don't have a D-Bus interface.
        // 2. qt 4.4.3 crashes when trying to emit signals on class without
        //    Q_CLASSINFO("D-Bus Interface", "<your interface>") but
        //    ExportSignal set.
        // We try to solve that for now with just registering Properties and
        // Adaptors. But we should investigate where the sense is in registering
        // the module at all. Just for autoload? Is there a better solution?
        regOptions = QDBusConnection::ExportScriptableContents | QDBusConnection::ExportAdaptors;
    } else {
        // Full functional module. Register everything.
        regOptions = QDBusConnection::ExportScriptableSlots //
            | QDBusConnection::ExportScriptableProperties //
            | QDBusConnection::ExportAdaptors;
        qCDebug(KDBUSADDONS_LOG) << "Registration of kded module" << d->moduleName << "without D-Bus interface.";
    }

    if (!QDBusConnection::sessionBus().registerObject(realPath.path(), this, regOptions)) {
        // Happens for khotkeys but the module works. Need some time to investigate.
        qCDebug(KDBUSADDONS_LOG) << "registerObject() returned false for" << d->moduleName;
    } else {
        // qCDebug(KDBUSADDONS_LOG) << "registerObject() successful for" << d->moduleName;
        // Fix deadlock with Qt 5.6: this has to be delayed until the dbus thread is unlocked
        QMetaObject::invokeMethod(this, "moduleRegistered", Qt::QueuedConnection, Q_ARG(QDBusObjectPath, realPath));
    }
}
```

* kded的Module插件怎么实现？

1，dbus封装。

module会继承kdeframeworks中的KDBusAddons，KDBusAddons处理dbus事务，module只用关心业务实现。

2，插件核心

基于QPluginLoader的派生KPlugin来实现。

module注册插件，

```
// 类似Q_PLUGIN_METADATA
K_PLUGIN_FACTORY_WITH_JSON(KWritedFactory, "ModuleName.json", registerPlugin<KWritedModule>();)
```

kded会用到kdeframeworks中的KCoreAddons，KCoreAddons通过QPluginLoader搜索及加载module插件，根据插件组册的json中"X-KDE-Kded-load-on-demand"属性，判断是否按需启动。

kframework

kded总结

gnome

```shell
Control group /:
-.slice
├─user.slice 
│ └─user-1000.slice 
│   ├─user@1000.service 
│   │ ├─session.slice 
│   │ │ ├─org.gnome.SettingsDaemon.MediaKeys.service 
│   │ │ │ └─1805 /usr/libexec/gsd-media-keys
│   │ │ ├─org.gnome.SettingsDaemon.Smartcard.service 
│   │ │ │ └─1811 /usr/libexec/gsd-smartcard
│   │ │ ├─org.gnome.SettingsDaemon.Datetime.service 
│   │ │ │ └─1801 /usr/libexec/gsd-datetime
│   │ │ ├─xdg-document-portal.service 
│   │ │ │ ├─1457 /usr/libexec/xdg-document-portal
│   │ │ │ └─1466 fusermount3 -o rw,nosuid,nodev,fsname=portal,auto_unmount,subtype=portal -- /run/user/1000/doc
│   │ │ ├─org.gnome.SettingsDaemon.Housekeeping.service 
│   │ │ │ └─1802 /usr/libexec/gsd-housekeeping
│   │ │ ├─xdg-desktop-portal.service 
│   │ │ │ └─2094 /usr/libexec/xdg-desktop-portal
│   │ │ ├─org.freedesktop.IBus.session.GNOME.service 
│   │ │ │ ├─1795 sh -c /usr/bin/ibus-daemon --panel disable $([ "$XDG_SESSION_TYPE" = "x11" ] && echo "--xim")
│   │ │ │ ├─1798 /usr/bin/ibus-daemon --panel disable
│   │ │ │ ├─1963 /usr/libexec/ibus-dconf
│   │ │ │ ├─1969 /usr/libexec/ibus-extension-gtk3
│   │ │ │ ├─1997 /usr/libexec/ibus-engine-simple
│   │ │ │ └─2400 /usr/libexec/ibus-engine-libpinyin --ibus
│   │ │ ├─org.gnome.SettingsDaemon.Keyboard.service 
│   │ │ │ └─1804 /usr/libexec/gsd-keyboard
│   │ │ ├─pipewire-media-session.service 
│   │ │ │ └─1411 /usr/bin/pipewire-media-session
│   │ │ ├─org.gnome.SettingsDaemon.A11ySettings.service 
│   │ │ │ └─1796 /usr/libexec/gsd-a11y-settings
│   │ │ ├─pulseaudio.service 
│   │ │ │ └─1412 /usr/bin/pulseaudio --daemonize=no --log-target=journal
│   │ │ ├─org.gnome.SettingsDaemon.Wacom.service 
│   │ │ │ └─1819 /usr/libexec/gsd-wacom
│   │ │ ├─org.gnome.SettingsDaemon.Sharing.service 
│   │ │ │ └─1810 /usr/libexec/gsd-sharing
│   │ │ ├─org.gnome.SettingsDaemon.Color.service 
│   │ │ │ └─1799 /usr/libexec/gsd-color
│   │ │ ├─org.gnome.SettingsDaemon.ScreensaverProxy.service 
│   │ │ │ └─1809 /usr/libexec/gsd-screensaver-proxy
│   │ │ ├─org.gnome.SettingsDaemon.PrintNotifications.service 
│   │ │ │ ├─1807 /usr/libexec/gsd-print-notifications
│   │ │ │ └─1913 /usr/libexec/gsd-printer
│   │ │ ├─org.gnome.SettingsDaemon.Power.service 
│   │ │ │ └─1806 /usr/libexec/gsd-power
│   │ │ ├─org.gnome.Shell@wayland.service 
│   │ │ │ └─4556 gnome-control-center display
│   │ │ ├─org.gnome.SettingsDaemon.Sound.service 
│   │ │ │ └─1812 /usr/libexec/gsd-sound
│   │ │ ├─pipewire.service 
│   │ │ │ └─1410 /usr/bin/pipewire
│   │ │ └─org.gnome.SettingsDaemon.Rfkill.service 
│   │ │   └─1808 /usr/libexec/gsd-rfkill
│   │ ├─background.slice 
│   │ │ └─tracker-miner-fs-3.service 
│   │ │   └─1489 /usr/libexec/tracker-miner-fs-3
│   │ ├─app.slice 
│   │ │ ├─gvfs-goa-volume-monitor.service 
│   │ │ │ └─1580 /usr/libexec/gvfs-goa-volume-monitor
│   │ │ ├─xdg-permission-store.service 
│   │ │ │ └─1460 /usr/libexec/xdg-permission-store
│   │ │ ├─snap.snap-store.ubuntu-software.cbc8ee01-7e29-4bd4-9268-58214e6bf2b3.scope 
│   │ │ │ └─2687 /snap/snap-store/575/usr/bin/snap-store
│   │ │ ├─gnome-remote-desktop.service 
│   │ │ │ └─1549 /usr/libexec/gnome-remote-desktop-daemon
│   │ │ ├─evolution-calendar-factory.service 
│   │ │ │ └─1880 /usr/libexec/evolution-calendar-factory
│   │ │ ├─xdg-desktop-portal-gnome.service 
│   │ │ │ └─2117 /usr/libexec/xdg-desktop-portal-gnome
│   │ │ ├─dconf.service 
│   │ │ │ └─1720 /usr/libexec/dconf-service
│   │ │ ├─app-gnome-org.gnome.Evolution\x2dalarm\x2dnotify-1886.scope 
│   │ │ │ └─1886 /usr/libexec/evolution-data-server/evolution-alarm-notify
│   │ │ ├─app-gnome\x2dsession\x2dmanager.slice 
│   │ │ │ └─gnome-session-manager@ubuntu.service 
│   │ │ │   └─1620 /usr/libexec/gnome-session-binary --systemd-service --session=ubuntu
│   │ │ ├─gvfs-daemon.service 
│   │ │ │ ├─1426 /usr/libexec/gvfsd
│   │ │ │ ├─1437 /usr/libexec/gvfsd-fuse /run/user/1000/gvfs -f
│   │ │ │ └─1773 /usr/libexec/gvfsd-trash --spawner :1.2 /org/gtk/gvfs/exec_spaw/0
│   │ │ ├─app-gnome-org.gnome.SettingsDaemon.DiskUtilityNotify-1879.scope 
│   │ │ │ └─1879 /usr/libexec/gsd-disk-utility-notify
│   │ │ ├─evolution-source-registry.service 
│   │ │ │ └─1766 /usr/libexec/evolution-source-registry
│   │ │ ├─gvfs-udisks2-volume-monitor.service 
│   │ │ │ └─1552 /usr/libexec/gvfs-udisks2-volume-monitor
│   │ │ ├─snap.snapd-desktop-integration.snapd-desktop-integration.service 
│   │ │ │ └─5817 /snap/snapd-desktop-integration/14/bin/snapd-desktop-integration
│   │ │ ├─app-gnome-x\x2dterminal\x2demulator-4607.scope 
│   │ │ │ ├─4607 /usr/bin/python3 /usr/bin/gnome-terminal --wait
│   │ │ │ └─4610 /usr/bin/gnome-terminal.real --wait
│   │ │ ├─app-gnome-update\x2dnotifier-2447.scope 
│   │ │ │ └─2447 update-notifier
│   │ │ ├─app-org.gnome.Terminal.slice 
│   │ │ │ ├─vte-spawn-3e726fca-47a0-49df-8db0-cf3b2207f898.scope 
│   │ │ │ │ └─4780 bash
│   │ │ │ ├─gnome-terminal-server.service 
│   │ │ │ │ └─4615 /usr/libexec/gnome-terminal-server
│   │ │ │ └─vte-spawn-b6cbe9bf-5ae0-4915-861f-60195d3afc37.scope 
│   │ │ │   ├─ 4641 bash
│   │ │ │   ├─31802 systemd-cgls
│   │ │ │   └─31803 pager
│   │ │ ├─gvfs-gphoto2-volume-monitor.service 
│   │ │ │ └─1604 /usr/libexec/gvfs-gphoto2-volume-monitor
│   │ │ ├─app-gnome-at\x2dspi\x2ddbus\x2dbus-1654.scope 
│   │ │ │ ├─1654 /usr/libexec/at-spi-bus-launcher --launch-immediately
│   │ │ │ ├─1666 /usr/bin/dbus-daemon --config-file=/usr/share/defaults/at-spi2/accessibility.conf --nofork --print-address 11 --address=unix:path=/run/user/1000/at-sp>
│   │ │ │ └─1784 /usr/libexec/at-spi2-registryd --use-gnome-session
│   │ │ ├─gnome-session-monitor.service 
│   │ │ │ └─1551 /usr/libexec/gnome-session-ctl --monitor
│   │ │ ├─xdg-desktop-portal-gtk.service 
│   │ │ │ └─2143 /usr/libexec/xdg-desktop-portal-gtk
│   │ │ ├─app-gnome-org.gnome.Nautilus-0.scope 
│   │ │ │ ├─ 1648 /usr/bin/gnome-shell
│   │ │ │ └─31757 gjs /usr/share/gnome-shell/extensions/ding@rastersoft.com/ding.js -E -P /usr/share/gnome-shell/extensions/ding@rastersoft.com -M 0 -D 0:0:1600:1200:1>
│   │ │ ├─gvfs-metadata.service 
│   │ │ │ └─2043 /usr/libexec/gvfsd-metadata
│   │ │ ├─dbus.service 
│   │ │ │ ├─1666 /usr/bin/dbus-daemon --config-file=/usr/share/defaults/at-spi2/accessibility.conf --nofork --print-address 11 --address=unix:path=/run/user/1000/at-sp>
│   │ │ │ └─1784 /usr/libexec/at-spi2-registryd --use-gnome-session
│   │ │ ├─gnome-session-monitor.service 
│   │ │ │ └─1551 /usr/libexec/gnome-session-ctl --monitor
│   │ │ ├─xdg-desktop-portal-gtk.service 
│   │ │ │ └─2143 /usr/libexec/xdg-desktop-portal-gtk
│   │ │ ├─app-gnome-org.gnome.Nautilus-0.scope 
│   │ │ │ ├─ 1648 /usr/bin/gnome-shell
│   │ │ │ └─31757 gjs /usr/share/gnome-shell/extensions/ding@rastersoft.com/ding.js -E -P /usr/share/gnome-shell/extensions/ding@rastersoft.com -M 0 -D 0:0:1600:1200:1>
│   │ │ ├─gvfs-metadata.service 
│   │ │ │ └─2043 /usr/libexec/gvfsd-metadata
│   │ │ ├─dbus.service 
│   │ │ │ ├─1423 /usr/bin/dbus-daemon --session --address=systemd: --nofork --nopidfile --systemd-activation --syslog-only
│   │ │ │ ├─1584 /usr/libexec/goa-daemon
│   │ │ │ ├─1595 /usr/libexec/goa-identity-service
│   │ │ │ ├─1755 /usr/libexec/gnome-shell-calendar-server
│   │ │ │ ├─1782 /usr/bin/gjs /usr/share/gnome-shell/org.gnome.Shell.Notifications
│   │ │ │ ├─1985 /usr/libexec/ibus-portal
│   │ │ │ └─2053 /usr/bin/gjs /usr/share/gnome-shell/org.gnome.ScreenSaver
│   │ │ ├─evolution-addressbook-factory.service 
│   │ │ │ └─2040 /usr/libexec/evolution-addressbook-factory
│   │ │ ├─gvfs-mtp-volume-monitor.service 
│   │ │ │ └─1597 /usr/libexec/gvfs-mtp-volume-monitor
│   │ │ └─gvfs-afc-volume-monitor.service 
│   │ │   └─1575 /usr/libexec/gvfs-afc-volume-monitor
│   │ └─init.scope 
│   │   ├─1403 /lib/systemd/systemd --user
│   │   └─1404 (sd-pam)
│   └─session-2.scope 
│     ├─1388 gdm-session-worker [pam/gdm-password]
│     ├─1454 /usr/bin/gnome-keyring-daemon --daemonize --login
│     ├─1488 /usr/libexec/gdm-wayland-session env GNOME_SHELL_SESSION_MODE=ubuntu /usr/bin/gnome-session --session=ubuntu
│     └─1500 /usr/libexec/gnome-session-binary --session=ubuntu

```

gnome没有一个通用的服务框架，或者说服务框架就是systemd，每一个服务基本都是独立的进程，以service的方式运行。

gnome没有处理session作用域的问题，session.scope外的进程，不通过pid获取当前session

gnome-setting-daemon

通过了一个仅用于setting的插件框架，原理也只是一个简单通用事务的封装

```c
// datetime plugin
// main.c
#define NEW gsd_datetime_manager_new // plugin的回调
#define START gsd_datetime_manager_start // plugin的回调
#define STOP gsd_datetime_manager_stop // plugin的回调
#define MANAGER GsdDatetimeManager // plugin的回调
#include "gsd-datetime-manager.h"

#include "daemon-skeleton.h" // 通用封装，会调用NEW、START、STOP等
```

***

dlclose调研

动态库方式运行时，如果有循环之类的没释放，调用dlclose会崩溃'

double dlclose会崩 - 判断?

正在运行 dlclose会崩 ，

正确释放资源的方法？ -- 子进程加载，子进程退出

正确退出的方法？

kded：同线程加载module，卸载没有处理

接口兼容性考虑

* 双重init -- oom\_protect
* dlopen -- launcher qplugeloader

关闭方式

AM重启

dlclose描述

https://pubs.opengroup.org/onlinepubs/9699919799/functions/dlclose.html

https://www.icode9.com/content-4-489342.html

子进程崩溃

***

*   二级模块按需启动：不同sdk的情况

    不同sdk使用同一个连接？不能

    不同连接使用同一个服务？不行，只能替换

    因此，同servicename的插件，只允许用同一个sdk。不止在服务框架内，对于servicename，目前所有服务命名都没有约束，也没有验重机制，都是人为避免这种情况。服务框架可以提供在安装时校验是否合法？
*   插件类型识别及对应处理

    1级不需要识别，2级也不需要识别依靠sdk关联
*   dlclose问题（崩溃、释放内存）

    ？？？貌似kded没unload
* 1

dlclose问题（崩溃、释放内存）

​ ？？？貌似kded没unload

​

system和session

1，dbus的按需启动

service - 只能支持服务为索引的按需启动

qtbase/sdbus - 支持自定义的按需启动

2，dbus的封装

kded

servicename：kded统一指定，modoule也可以额外指定

path：根据modoule自动生成

interface：qt宏在modoule项目中指定

method：qtdbus封装，按照qtdbus规则实现继承kdemodule

sdbus：

servicename：可以统一指定

path：可以自动，也可以指定

interface：可以自动，也可以指定

method：

&&&&&&&多语言封装

3，dbus的servicename唯一问题

每一个连接有一个uniqueid，qtdbus使用了连接缓存，实现同进程可以使用同一个连接；

同一个servicename只能同时被一个连接拥有；

1，结合systemd

2，按需启动（只针对dbus？依赖？）

*   参考

    dde-daemon：依赖

    kinit：无按需

    kded：qtbase

    gnome-settings-daemon：
*   启动：

    dbus可支持
* 退出

***

dbus service

***

没有按需启动、Info、ExitCB、dbusService前置

***

system和session、按需加载、插件生命周期（IDLE接口）、会话（加密和权限）、权限管理等也是插件

国密、接口权限（签名）
