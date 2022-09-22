# devscripts - mk-build-deps
### 
### 介绍
```bash
# devscripts是debian开发工具的集合，其中包含mk-build-deps，安装devscripts：
sudo apt install devscripts

# mk-build-deps：给定一个包名或控制文件，生成一个包含所有依赖的二进制包，并可选的可以直接安装

# 特点1：安装的依赖环境由控制文件给定，为待编译项目实际依赖环境，这点比apt build-deps好
# 热点2：mk-build-deps给待编译项目会先生成一个包，该包的依赖环境和待编译项目的依赖环境一致，这样便于管理依赖环境。
# 如hmmer2项目，依赖libpvm3、libsquild1等多个包，下载源码后mk-build-deps会生成hmmer2-build-deps_2.3.2+dfsg-6_all.deb包
# dpkg -I hmmer2-build-deps_2.3.2+dfsg-6_all.deb， 可以看到hmmer2-build-deps的依赖就是hmmer2的依赖
# hmmer2-build-deps_2.3.2+dfsg-6_all.deb不包含依赖包的本身，只记录依赖了哪些包
# 该依赖环境安装后，随时可以查看安装了哪些包，dpkg -s hmmer2-build-deps
# 该项目编译完成后卸载依赖，可以用apt remove hmmer2-build-deps,会卸载掉依赖的各个包
```
### 用法
```bash
mk-build-deps [options] control file | package name ...
```
### 选项
```bash
-i|--install - 生成包含所有依赖的二进制包的同时，去安装依赖环境，这个过程会自动调用apt
-t|--tool - When installing the generated package use the specified tool.
    (default: apt-get -o Debug::pkgProblemResolver=yes --no-install-recommends)
-r|--remove - Remove the package file after installing it. Ignored if used without the --install switch.
-s|--root-cmd - Use the specified tool to gain root privileges before installing.Ignored if used without the --install switch.

```
### 实例
```bash
# UOS Wiki
sudo mk-build-deps --install --tool='apt -o Debug::pkgProblemResolver=yes --no-install-recommends --yes' debian/control

# 网络文章
mk-build-deps PKGNAME --install --root-cmd sudo --remove
```