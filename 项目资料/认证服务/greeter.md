



libframeworkdbus-2.0 访问DA的客户端接口



app/lightdm-deepin-greeter：

```c++
// main
SessionBaseModel *model = new SessionBaseModel(SessionBaseModel::AuthType::LightdmType)
new GreeterWorkek(model)
new LoginWindow(model)  // 每个屏幕一个
```

libdde-auth/：

```c++
// deepinauthfamework封装了两个类，访问PAM-MOUDLE和访问的DA-DBUS
```



dde-lock/



session-widgets/

session-widgets/SessionBaseModel

```c++
// 认证基础信息模块，维护用户列表、用户状态、认证状态、认证类型等
// 用户列表，当前用户
connect(m_model, &SessionBaseModel::authStatusChanged, m_userLoginWidget, &UserLoginWidget::updateAuthResult);
```

session-widgets/AuthenticationModule

```c++
// 认证用户行为模块，包含认证相关UI行为、开启认证、认证结果等
```

session-widgets/UserLoginWidget

```c++
// 用户登录UI模块

```

session-widgets/UserLoginInfo

```c++
// UserLoginWidget、UserFrameList的后端，托管它们需要用的数据
// 只发送必要的信号（当有多个不同的信号过来，但是会触发显示同一个界面，这里做过滤），改变子控件的布局
// initConnect
connect(m_userLoginWidget, &UserLoginWidget::requestStartAuthentication, this, &UserLoginInfo::requestStartAuthentication);
// setUser
m_currentUserConnects << connect(user.get(), &User::lockChanged, this, &UserLoginInfo::userLockChanged);
```

session-widgets/LockContent

```c++
// 维护锁屏界面组件，如时间、logo、关机、虚拟键盘、背景组件，包含布局和事件处理
connect(m_userLoginInfo, &UserLoginInfo::requestStartAuthentication, this, &LockContent::requestStartAuthentication);
```

lightdm-deepin-greeter/LoginWindow

```c++
// greeter相关UI控制
// 下级GreeterWorkek，
connect(m_loginContent, &LockContent::requestStartAuthentication, this, &LoginWindow::requestStartAuthentication
```

lightdm-deepin-greeter/下级GreeterWorkek

```c++
// greeter相关认证处理
// 直接调用libdde-auth、lightdm-greeter、"com.deepin.dde.LockService"等
```

lightdm-deepin-greeter/GreeterWorkek

```c++
// 认证接口行为模块,也包含电源等操作
```



start认证信号路线

```c++
GreeterWorkek::startAuthentication
loginFrame=LoginWindow::requestStartAuthentication
LockContent::requestStartAuthentication
UserLoginInfo::requestStartAuthentication
UserLoginWidget::requestStartAuthentication
AuthenticationModule::activateAuthentication
```



greeter登录流程





一键登录



完成认证







监控应用程序开启/关闭
------一种识别进程所属应用的设计
一种加快elf格式二进制程序二次启动速度的方式
##防止进程单例模式下卡死导致无法启动问题

能否使用一个镜像文件修复系统



归类所有应用程序的文件

一种实时wiki编辑方法/

一种内网云协作开发的方式



一种检测文件列表多白区域的方式

文件管理增加收藏夹窗口分割

系统自带的音效均模器

