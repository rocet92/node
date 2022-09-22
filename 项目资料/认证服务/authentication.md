



### QA

1 多路认证?

2 为什么说PAM对多因子支持困难？

PAM为串行

3 人脸信息绑定密钥为什么不行？



### 生物识别

依赖libopencv-dev





### DA

- 【完成】单因和多因

  [5]

  - 单因

  PAM-MODULE通过config获取appid，dbus通过DA获取默认认证方式（密码/指纹/UKEY）

  <font color=#A52A2A>checkTx=默认认证方式，checkAvailableTx过滤没有设备的方式=availableFlags</font>

  根据availableFlags启动txs

  listenResultCh监听txs有Status，发送信号到PAM-MODULE

  PAM-MODULE回调APP通知Status

  <font color=#A52A2A>PAM-MODULE通过sd_bus_process等待DA认证结果，成功则结束并发送end</font>

  - 多因？？？？同时都通过？

  PAM-MODULE通过config获取appid，dbus通过DA获取默认认证方式（密码/指纹/UKEY）

  <font color=#A52A2A>checkTx=mfa.d配置文件指定APP的认证方式，得到availableFlags，checkAvailableTx检测availableFlags中没有设备走单因</font>

  根据availableFlags启动txs

  listenResultCh监听txs有Status，发送信号到PAM-MODULE

  PAM-MODULE回调APP通知Status

  <font color=#A52A2A>PAM-MODULE通过sd_bus_process等待DA认证结果，每次开启一个认证，成功后发送end且start下一个，直接所有结束，结束判断bug？</font>

  - 判断

  通过dbus去DAsession获取isMFA，DA通过是否存在多因配置文件判断是否多因

  

- 【完成？】lightdm+greeter，启动流程

  [5]

  greeter跳过PAM-MOUDLE直接找DA完成认证，且暂时不关闭sessionA

  PAM-MOUDLE完成认证会关闭session（End()接口）

  lightdm通过PAM-MOUDLE开启认证，开启sessionB，需要密码的时候，找greeter获取sessionA，把sessionA的PATH当密码发给PAM-MOUDLE，PAM-MOUDLE找sessionA验证，然后完成认证，关闭sessionB，也就是sessionB没有做实际的认证

  PAM-MOUDLE有个特殊处理，在输入密码环节，token可以是密码或者path，先通过path验证，不成功再通过密码认证

- 【完成？】pam.d配置

  [4]

  [value1=action1 value2=action2 ...]

  自动更新防覆盖

  pam-auth-update脚本，base/pam，perl，libpam-runtime v1.3.1-5+dde

- 【完成】一键登录，PAM流程

  [3]

  空的？

- 【完成】deepin-pw-check

  [3]

  用于校验密码，提供动态库调用和PAM库（pam_deepin_pw_check.so）两种方式

  pam.d的common-password用pam_unix修改密码，会提前用pw_check的pam库校验

  

- session-shell

  [3]

  libframeworkdbus-2.0 访问DA的客户端接口

  libdde-auth的deepinauthfamework封装了两个类，访问PAM-MOUDLE和访问的DA-DBUS

  - login

    多种方式触发开启认证createAuthentication，如DBusLockService::UserChanged信号

    

  - lock








- 【完成？】keyring

  [3]

  - [dpa-ext-gnomekeyring](https://gerrit.uniontech.com/admin/repos/dpa-ext-gnomekeyring)

    DDE Polkit Agent extension to automatically do some thing with GNOME keyring.

    密钥环那个小窗口？

  - [gnome-keyring](https://gerrit.uniontech.com/admin/repos/base/gnome-keyring)

    （pam_gnome_keyring.so和DBUS：org.gnome.keyring.Daemon）

  - [libgnome-keyring](https://gerrit.uniontech.com/admin/repos/base/libgnome-keyring)

    ？？动态库

  - [deepin-keyring](https://gerrit.uniontech.com/admin/repos/base/deepin-keyring)

    ？？无代码

  

  common-password用pam_unix修改密码

  pam.d的common-password用pam_unix修改密码，成功后会用pam_gnome_keyring.so修改keyring密码



- dde-session-daemon？？？ 没有

  [2]



- policy

- fprint？

- ukey？

  [1]

- [lightdm-gtk-greeter](https://gerrit.uniontech.com/admin/repos/base/lightdm-gtk-greeter)   ？

- [base/lightdm](https://gerrit.uniontech.com/admin/repos/base/lightdm) ？

- 国际化

  [1]

  qt=ts+qm

  dbus？？？=ts？

  c++/GO？？？=po？？？

- account

  [1]









-----BEGIN PRIVATE KEY-----
MIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQDAnXx4lESQN2LS
sB/k3UWeKfatvqfrerl/DsyzTMG7cdiKG6QKHFg5IERbTZsAVubFGQcglJd4Ppt5
NHy94W5iuyXkUmCdS29SskoobVBdUIGn2oODZ0/eUxZA14J9jsjulK75KCTe+YKe
jUWskUfZhKxL4H/rAGcNrV/yMs+LcveLQ8SM3eCtCJ5G7F5vaeccLMZkREBPHF2x
0EnvkKEqZGd1aVK/3C8TxEF6LrmanQw2gy6ZC6sE0yE7ep1+YXDGgJNGypc5xGrH
btPRpZGyGXwRqIlFxEBZO7F85+ddfSKjV/eFx9j3l2MFGO0H5xEvOkTZtGlSBBsx
VEMfqmV1AgMBAAECggEAICWoso88aj10NunCSPZNOjqSuyjI6dpPv07/ByXWZ6x2
kYZPeIiGiPJDtmFbb1ERru+gauWh6iW42R/TefV38O5/Qn4lNdtzNwAetGSaNxjK
qvMjY/kIMXj4i9XsJ3x/OKKEGX2Duds227OEX2rX7QvhncBYWSZ2DKhVDR1B2moJ
QVVdVFpgycRM+dWp6qkItr97W5HkDZgaJXCGycwjYBSpn0eTWShxNr6voHCdOUUq
8V62dfxlxE5gYIthmBxx3a3LiUN00uyLce3AVDSrWXRRN5/dTdC+QElfloCPrS2h
Ezz0DbjZGoTWNjinD2S4fQqIHqw8KjsfnPgcsJZK+QKBgQD0vfTsYZcL9g1KEVK0
cexVR/li9QZx3VMbddGOLzv1+a2vzayXh1Wqdl1Wx0EM4asGDMytQg1ujdZa6vOe
Cm9df6k1JoT5WyLIL0KBzLayaSdNBHZ4BznxvyWxQlM4GXeFy8vqgssq4+sICRnD
q5rQwAdt+Y46ybH9d5JIoqGArwKBgQDJebEs2omZ30JSPX79EbCbPiAltxx8rkKY
L9sPNGVmJDb7V8JJdQIJ/litliKTup8SsfuZhhwnMmiPerVJ/DTfaL04O4nc0boP
miht3y5zGxSqoSJpTNDk1erAhjibSMQS3+zed6lXEr0MmdFCKxs+wTs85EKTTU+X
kWogG1IdGwKBgFT75SFz3cRcg07V5xcbfAo8/N8c4EkHpoUhi0vJIRQPx/0E+UqA
xwFzKoQomnEDp6RpK2V6Szm5bNaTQVb+np8j5ji7kG8Z82D58CksUcBv/SKkSxLw
x3Eng8oiks0nIrbGBp//HNde300iA91LKG4WUD4i6v2E7hZqv9QTDOunAoGAGXXx
d/OeE/3syavP0ndb1CKDuYBsby0uaUES89bxQXkuIZEzkkjhGxYzaqxgbj7VP22S
mBIkmKd8IzWkl1bx75Gy59pOT8OJOdOHbGsZ2Z4AfJekW55Df8ewxOexW55UePYn
Xu3MTp6lmWQO18fOx51vuQA3kZnhhwvvV2NceyUCgYBN3pEhtMnXlbTjaZuJ2As9
a+dEYHUrW896xgqoVxEV3LE9lvfYiGTEUJ2OSmxb8vQR+GXtUBVDAVeDC4mPPmUX
x2Dp3xYFkE0Lrbom03MOqxo/JhjWysu/lQn8+uFkgkJasJFpjo7NnVlNl1YeVt4J
uPwiYNQ/TZoPMd503fZ9yw==
-----END PRIVATE KEY-----



-----BEGIN PUBLIC KEY-----
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAwJ18eJREkDdi0rAf5N1F
nin2rb6n63q5fw7Ms0zBu3HYihukChxYOSBEW02bAFbmxRkHIJSXeD6beTR8veFu
Yrsl5FJgnUtvUrJKKG1QXVCBp9qDg2dP3lMWQNeCfY7I7pSu+Sgk3vmCno1FrJFH
2YSsS+B/6wBnDa1f8jLPi3L3i0PEjN3grQieRuxeb2nnHCzGZERATxxdsdBJ75Ch
KmRndWlSv9wvE8RBei65mp0MNoMumQurBNMhO3qdfmFwxoCTRsqXOcRqx27T0aWR
shl8EaiJRcRAWTuxfOfnXX0io1f3hcfY95djBRjtB+cRLzpE2bRpUgQbMVRDH6pl
dQIDAQAB
-----END PUBLIC KEY-----