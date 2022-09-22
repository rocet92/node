

keyring



uos安装keyring ui：

sudo apt-get install seahorse 安装



keyring介绍

https://zhuanlan.zhihu.com/p/128133025

keyring不涉及linux操作系统的用户密码管理和认证，一般是用于第三方应用的密码的认证，如浏览器、ftp等，效果上就是浏览器某些网页登录并保存密码后，下次打开该网页可以自动登录。（浏览器不一定会用keyring来做密码管理，也可能浏览器自己实现一个密码管理来实现保存网页密码自动登录）

keyring本身有一个密码，只有验证了keyring的密码，第三方应用才能使用保存的密码完成自动登录。

如果keyring的密码和用户密码一样，用户用密码登录时，会用用户的密码去自动解锁keyring。

关闭keyring的方法是，取消keyring的密码。



79650: feat: 生物认证登陆解锁keyring | https://gerrit.uniontech.com/c/deepin-authentication/+/79650



