# apt命令
apt命令  



### 命令组成
```bash
apt [选项] 命令 命令参数
apt [选项] install|remove pkg1 [pkg2 …] 
apt [选项] source pkg1 [pkg2 …]
```
### 命令
```bash
# 继承apt-get
grade - 进行更新 
install - 安装新的软件包 
remove - 移除软件包 

autoremove - 自动卸载“没有被依赖”的包。
    比如apt下载某应用，会自动下载其依赖，该应用卸载时，没有自动卸载依赖，autoremove就可以卸载掉这些依赖。
    某些依赖可能被多个应用用到，应该会有一个被依赖计数，为0才会被autoremove卸载掉，某些操作如apt --force会可能导致计数出错，从而autoremove也会出问题。
purge - 移除软件包和配置文件 
source - 下载源码档案 
build-dep - 为源码包配置编译依赖。
    apt show可以查看源仓库中指定包的依赖信息， build-dep去安装这个依赖。也就是说build-dep安装的依赖环境实际是源仓库该包的依赖环境。
    如果安装某个应用，直接install会自动安装依赖，不需要单独用build-dep。用build-dep一般是在通过源码去编译某个包的时候，不期望安装此包但需要此包的环境。
    因此，问题也很明显了，源仓库该包的依赖环境很可能和待编译的源码的项目要求的环境不一致，build-dep后，编译时依赖环境还是会有问题，此时用mk-build-deps来解决。
    另外，在编译打包完成后，可能不需要此包的依赖环境了，而build-dep安装的依赖环境并不好清除掉，此时也用mk-build-deps来解决。

upgrade - 升级，在以下几种情况，某个待升级的软件包不会被升级：
    1 新软件包和系统的某个软件包有冲突
    2 新软件包有新的依赖，但系统不满足依赖
    3 安装新软件包时，要求先移除旧的软件包
dist-upgrade - 发行版升级, 参见 apt-get(8) ，dist-upgrade 包含upgrade，同时增添了以下功能：
    1 可以智能处理新软件包的依赖
    2 智能冲突解决系统
    3 安装新软件包时，可以移除旧软件包，但不是所有软件都可以。
    #例如软件包 a 原先依赖 b c d，但是在源里面可能已经升级了，现在是 a 依赖 b c e。这种情况下，dist-upgrade 会删除 d 安装 e，并把 a 软件包升级，而 upgrade 会认为依赖关系改变而拒绝升级 a 软件包。

dselect-upgrade - 依照 dselect 的选择更新 
clean - 清除下载的归档文件 
autoclean - 清除旧的的已下载的归档文件（deb）。对比clean，autoclean 清理不再使用且没用的下载
check - 检验是否有损坏的依赖
changelog - 展示包的更新日志

# 继承apt-cache
show - 查询包详情，包含版本、依赖、大小、介绍、本地deb位置等。
search - 搜索包
```
### 选项
```bash
-h 本帮助文件。 
-u 同时显示更新软件包的列表  (哪个子命令的没找到)

# 继承apt-get参数，apt-get(8)
-y|--yes - 假定对所有的询问选是，不提示 
-d|--download-only - 仅下载，不安装或解压归档文件 
-f|--fix-broken - 尝试修正系统依赖损坏处 
-s|--simulate - 不实际安装。模拟执行命令
-m 如果归档无法定位，尝试继续 
-b 获取源码包后编译 
-v 显示详细的版本号 
-q 输出到日志 - 无进展指示 
-qq 不输出信息，错误除外 
--allow-downgrades
这是一个危险的选项，当apt在执行降级时，会没有提示的运行下去。除非在非常特殊的情况下，否则不应使用。
使用它可能会破坏您的系统！对应配置项为APT::Get::allow-downgrades。在APT1.1中介绍。(by apt-get(8))
--allow-change-held-packages 
Force yes; 这是一个危险的选项，如果apt正在更改保留的包（it is changing held packages），会没有提示的运行下去。除非在非常特殊的情况下，否则不应使用。
使用它可能会破坏您的系统！对应配置项为APT::Get::allow-change-held-packages。在APT1.1中介绍。(by apt-get(8))

# 继承apt-config参数，apt.conf(5)
-c=?|--config-file - 读取指定配置文件的配置项。同时，apt默认也会且优先读取/etc/apt/apt.conf.d/下多个配置文件。如配置文件增加行Debug::NoLocking true;
-o=?|--option - 直接指定配置项，如 -o Debug::NoLocking=1 ，可以发现和配置文件的格式可以不一样。
```
### 配置项（待补充）
```bash
# DEBUG OPTIONS
Debug::NoLocking
禁用所有文件锁定。例如，这将允许两个“apt get update”实例同时运行。
Debug::RunScripts
显示由apt hooks调用的外部命令。这包括比如配置选项，DPkg::{Pre，Post}-Invoke或APT::Update::{Pre，Post}-Invoke。

# FILES OPTIONS
Dir::Etc::Main
指定apt主配置文件，默认是/etc/apt/apt.conf
Dir::Etc::Parts
指定apt配置文件目录，默认是/etc/apt/apt.conf.d/
Dir::Etc::SourceList
指定主源文件，默认是/etc/apt/sources.list
Dir::Etc::SourceParts
指定源文件目录，默认是/var/lib/lastore/sources.list.d
Dir::State::lists
指定源仓库包信息目录，默认是/var/lib/apt/lists/，在该目录下每个源仓库对应一个文件，文件里包含源仓库包含的包信息。

# Cache OPTIONS
# apt update生成包缓存，包含pkgcache.bin、srcpkgcache.bin、及deb，大多数情况可删除（可解决部分apt环境出错问题）
Dir::Cache
指定包缓存目录，默认是/var/cache/apt/，pkgcache.bin、srcpkgcache.bin在此目录，deb在此目录的子目录archives下。
# 通过将pkgcache或srcpkgcache设置为“”，可以关闭缓存的生成。这会减慢启动速度，但会节省磁盘空间。最好关闭pkgcache而不是srcpkgcache（by apt(8)）
Dir::Cache::pkgcache Dir::Cache::srcpkgcache Dir::Cache::archives
指定缓存相关目录，不单独指定就在Dir::Cache的目录下。

# Acquire OPTIONS
# Acquire选项组控制包的下载以及负责下载本身的各种“Acquire方法”
Acquire::Languages
要强制APT不使用翻译文件，请使用设置Acquire:：Languages=none,翻译文件仍会下载，如果系统环境指定了LC语言，则优先使用指定的语言的翻译文件。
Languages即apt命令的语言设置，包含apt help、执行信息、包信息等。export LANGUAGE="en" && apt --help，会显示apt英文帮助文档。
Acquire::Retries
要执行的重试次数。如果该值为非零，则APT将重试给定次数的失败文件。

# Dpkg OPTIONS

# APT OPTIONS
APT::Status-Fd
（该项存疑）dpkg选项？发送状态更新到指定文件描述符，即apt日志保存到指定文件。stdin，stdout和stderr为0,1和2。而3一般是syslog。
APT::Status-Fd=3即把apt命令执行日志保存到syslog
```
---
### 常用命令
```bash
apt-cache search packagename 搜索包
apt-cache show packagename 获取包的相关信息，如说明、大小、版本等
apt-get install packagename 安装包
apt-get install packagename - - reinstall 重新安装包
apt-get -f install 修复安装"-f = --fix-missing"
apt-get remove packagename 删除包
apt-get remove packagename - - purge 删除包，包括删除配置文件等
apt-get update 更新源
apt-get upgrade 更新已安装的包
apt-get dist-upgrade 升级系统
apt-get dselect-upgrade 使用 dselect 升级
apt-cache depends packagename 了解使用依赖
apt-cache rdepends packagename 是查看该包被哪些包依赖
apt-get build-dep packagename 安装相关的编译环境
apt-get source packagename 下载该包的源代码
apt-get clean 清理无用的包
apt-get autoclean 清理无用的包
apt-get check 检查是否有损坏的依赖
apt-mark hold/unhold <package> 升级时，忽略/不忽略指定包
```
### 实例及QA
1，apt、apt-get、aptitude的区别？

先结论：这三者可以用来进行包管理，功能有很大的重叠但又不完全一样。推荐用apt就行了，个别情况可以考虑apt-get、aptitude。

简单来说就是：apt = apt-get、apt-cache 和 apt-config 中最常用命令选项的集合。

apt 命令的引入就是为了解决命令过于分散的问题，同时也有新特性，比如进度条。但部分 apt-get、apt-cache 和 apt-config更细化的命令apt没有。

aptitude系统默认没安装，与 apt-get 一样，是 Debian 及其衍生系统中功能极其强大的包管理工具。与 apt-get 不同的是，aptitude 在处理依赖问题上更佳一些。举例来说，aptitude 在删除一个包时，会同时删除本身所依赖的包。因此可以发现aptitude是没有autoremove命令的。



2，Dir::Etc::SourceList替换源文件位置的作用？

默认apt通过/etc/apt/sources.list和/var/lib/lastore/sources.list.d的源仓库寻找包，但如果某次更新只想apt使用指定的部分源仓库怎么办？

可以把/etc/apt/sources.list和/var/lib/lastore/sources.list.d指定的部分源仓库文件软链接到另一个新的目录，然后apt指定选项Dir::Etc::SourceList和Dir::Etc::SourceParts，这两个选项指向新的目录，这样apt实际只会使用进行了软链接的部分源仓库文件。

Dir::Etc::SourceList一般就是用于应用指定源仓库。  



3，基于-s模拟安装的安全安装方法

```go
// 将待运行的apt命令先加上-s运行，如果成功才实际运行，在模拟运行失败不会破坏当前环境
func safeStart(c *aptCommand) error {
    args := c.apt.Args  // aptCommand封装了实际要执行的命令语句及*exec.Cmd，c.Start()会用*exec.Cmd执行命令
    // add -s option
    args = append([]string{"-s"}, args[1:]...)
    cmd := exec.Command("apt-get", args...)
    var stdout bytes.Buffer
    var stderr bytes.Buffer
    cmd.Stdout = &stdout
    cmd.Stderr = &stderr
    // perform apt-get action simulate
    err := cmd.Start()
    if err != nil {
        return err
    }
    go func() {
        err := cmd.Wait()
        if err != nil {
            return
        }
        // cmd run ok， check rm dde?
        if bytes.Contains(stdout.Bytes(), []byte("Remv dde ")) {
            return
        }
        // really perform apt-get action
        err = c.Start()
        if err != nil {
        }
    }()
    return nil
}
```
4，简单的包环境检测和修复方法。

如果apt命令或者dpkg命令出错（针对部分错误情况）可先简单排查.

```bash
# 出错的apt如果指定了配置文件，注意配置文件是否修改了apt相关的默认路径，如果修改了，下面命令都带上这个配置文件
# 1 - 检查
sudo apt check
# 2 - 修复
dpkg --force-confold --configure -a; sudo apt -f install;

# 3 - 1出错2不能成功修复（可能死机），就运行3，如果3正常，可能是锁被异常占用
sudo apt-get check -o Debug::NoLocking=1
# 4 - 3的问题的修复，执行完了再执行2
sudo rm /var/lib/dpkg/lock
# 5 - 如果4的方法没有修复，可以执行5,执行完了5再执行2
ps -ef | grep "deepin-anything" | grep -v grep | awk '{ print $2 }' | sudo xargs -I {} kill -9 {} | sudo rmmod vfs_monitor

# 6 - 病急乱投医法
sudo rm /var/cache/apt/* -rf; sudo apt update;
```
5，apt install安装包时提示，“xxxx : 依赖: xxxxx (= 2:7.3.154+hg\~74503f6ee649-2ubuntu3) 但无法安装它”

顾名思义，就是无法安装依赖包，具体解决该问题时，注意查看依赖包是否存在及仓库的版本是多少，依赖期望的版本是多少，根据问题来找对应解决办法。

（1）如果依赖包已安装版本低于期望版本，且源仓库有期望版本
其实这种情况apt不会报错，apt会自动升级依赖包版本

（2）如果依赖包已安装版本低于期望版本，且源仓库没有期望版本

可以通过换源解决  

（3）如果依赖包已安装版本高于期望版本

如果已安装版本如果能兼容期望版本就不会报错，如果报错可以考虑降版本，先尝试apt remove，如果提示同时会卸载别的包，就别用apt remove，手动找到该包的更低版本，然后用dpkg -i xx.deb（--force-all）的方式降版本





















---
参考：

1，apt man，http://www.tin.org/bin/man.cgi?section=8&topic=apt

2，https://www.dazhuanlan.com/2019/12/14/5df4115013d61/

3，https://blog.csdn.net/wangyezi19930928/article/details/54928201