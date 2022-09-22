# dpkg命令
### 用法
```bash
# dpkg是个较底层的工具，自己不能解决软件包的依赖问题，apt命令更适合解决依赖问题，apt会用到dpkg
dpkg [<选项> ...] <命令>
# dpkg命令比较简单，这里记录常用命令或者对某些命令的理解。其他命令直接dpkg --help查看就行
```
### 命令
```bash
# 举例说明下面提到的包文件和包名的区别。包文件：startdde_3.14.6.5_sw_64.deb，包名：startdde，“dpkg 包名”操作对象是已安装后的包

# 查询
-l|--list - 查询系统已安装所有deb包的信息
-c 包文件 - 列出指定deb包中的所有文件
-L|--listfiles 包名 - 列出指定包在系统已安装的的文件位置

-I 包文件 - 列出指定deb包的信息，信息和apt show的内容一致
-s|--status 包名 - 列出指定已安装包的信息，信息和apt show的内容一致
-S|--search 文件名 - 列出指定文件属于哪个已安装的包
-V|--verify 包名 - 检查包的完整性

# 安装
-i|--install 包文件 - 直接安装指定deb包，不自动处理依赖，如果依赖不满足可能会失败，也可能成功再用apt -f install补依赖。
--unpack 包文件 - 解开deb包的内容
# 卸载
-r|--remove 包名 - 卸载软件包，该命令不卸载配置文件，且不能自动解决依赖性问题，但会给出相应的提示。
-P|--purge 包名 - 完全卸载，同样不会解决依赖性，但会删除配置文件。
dpkg-reconfigure 包名 - 重新配置软件包,就可显示出第一次安装该包时出现的配置对话框了。
```
### 选项
```bash
-D|--debug=<八进制数>      开启调试(参见 -Dhelp 或者 --debug=help)。
--status-fd <n>            发送状态更新到文件描述符<n>。
--log=<文件名>             将状态更新和操作信息到 <文件名>
--force-...                忽视遇到的问题(参见 --force-help)，如--force-all
--ignore-depends=<软件包>,...            忽略关于 <软件包> 的所有依赖关系。
```
mkdir tmp

dpkg-deb -R original.deb tmp

\# edit DEBIAN/postinst

dpkg-deb -b tmp fixed.deb



---
参考

https://blog.csdn.net/aip1080/article/details/7731625

https://blog.51cto.com/jianjian/395468