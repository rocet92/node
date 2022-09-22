





## source.list详解

仓库配置格式：

```shell
Type [option] URI Codename Components
```

- Type

  deb：二进制包仓库

  deb-src： 二进制包的源码库

- option：选项，可选的，多个选项用空格分隔

  [trusted=yes]  信任该仓库，无需验证包的签名

  [arch=amd64]  限定架构

- URI：库所在的地址，可以是网络地址，也可以是本地的镜像地

- Codename：用于指定子仓库，一般代表版本，可以多层结构，用/分割，类似目录结构

- Components：用于指定子仓库，一般代表包性质的分类，可存在多个，用空格分隔

```shell
# eg1
# type：deb，option：无，Codename：eagle/1032（两层结构），Components：main、contrib、non-free共3个
deb http://pools.uniontech.com/desktop-professional eagle/1032 main contrib non-free
# eg2
# option：trusted和arch，Codename：unstable， Components：main
deb  [trusted=yes arch=amd64] http://aptly.uniontech.com/pkg/eagle-1032/release-candidate/MjAyMTA3MDEtMTAzMi03OTA3MjIwMjEtMDctMDEgMTY6NDE6MDk  unstable main
```



### 常见Components

（UOS参考debian）

debian组件(Components)一般包括：main、contrib、non-free、non-us

- main: 遵循DFSG（Debian自由软件准则）的所有自由软件
- non-free: 非自由软件。不免费。Debian项目认为这non-free不是Debian的一部分，仅是为用户提供方便。
- contrib: 遵循DFSG的软件，软件本身免费，但依赖的软件包不免费。一般取决于中的软件包non-free。它也不被视为Debian的一部分。
- non-us: 非美国地区，可能有加密、专利等

ubuntu的组件与之不同：main, restricted, universe, multiverse

- main： 完全自由软件（免费），ubuntu官方提供支持

- restricted： 不完全自由软件（授权问题），ubuntu官方提供支持

- universe：完全自由软件（免费），ubuntu官方不提供支持，一般由社区支持

- multiverse：不完全自由软件（授权问题），ubuntu官方不提供支持





### Codename/Components规则

参考“deb http://pools.uniontech.com/desktop-professional eagle/1032 main contrib non-free”，

浏览器打开URI如下，包含两个目录：

```html
> http://pools.uniontech.com/desktop-professional/

Index of /desktop-professional/
--------------
../
dists/                                             04-Feb-2021 16:53                   -
pool/                                              05-Aug-2021 14:24                   -
```

pool：包所在的实际目录，单独把文件放在pool文件夹里是为了防止文件的重复

dists：包的索引目录，Codename和Components就是通过索引来指定子仓库的。弄明白dists的结构，只能知道Codename和Components怎么设置了



```html
> http://pools.uniontech.com/desktop-professional/dists/

Index of /desktop-professional/dists/
--------------
../
eagle/                                             13-Dec-2021 13:35                   -
eagle-sp2/                                         24-Nov-2021 16:29                   -
```

eagle和eagle-sp2就都是1个Codename，如Codename填eagle，就是用eagle下的索引。



```html
> http://pools.uniontech.com/desktop-professional/dists/eagle/

Index of /desktop-professional/dists/eagle/
--------------
../
1031/                                              24-Nov-2021 16:29                   -
1032/                                              24-Nov-2021 16:29                   -
1040/                                              24-Nov-2021 16:28                   -
1041/                                              24-Nov-2021 16:28                   -
1042/                                              24-Nov-2021 16:26                   -
1043/                                              13-Dec-2021 11:17                   -
1050/                                              27-Aug-2021 10:33                   -
contrib/                                           27-Oct-2021 11:15                   -
main/                                              13-Dec-2021 13:35                   -
non-free/                                          12-Nov-2021 13:26                   -
sp1/                                               24-Nov-2021 16:30                   -
sp2/                                               24-Nov-2021 16:29                   -
sp3/                                               24-Nov-2021 16:29                   -
InRelease                                          13-Dec-2021 13:35               28629
Release                                            13-Dec-2021 13:35               28092
Release.gpg                                        13-Dec-2021 13:35                 488
```

这里有3类文件：

（1）Release和InRelease

这两个文件属于Codename，每一个Codename对应目录下都有这两文件。文件内容为对下级Components的索引内容，包含Components列表。

InRelease文件是内部自认证的，而Release文件需要伴随Release.gpg文件出现。

InRelease部分内容如下：

```shell
-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Origin: Linux Deepin
Label: Deepin
Codename: eagle
Version: 2019
Date: Mon, 13 Dec 2021 05:35:23 UTC
Architectures: i386 amd64 arm64 mips64el sw_64 loongarch64  # 架构
Components: main contrib non-free                           # Components列表
Description: Deepin debian packages
MD5Sum:
 4949d04a51d6a1cf82816ed657471482 68454880 main/binary-i386/Packages
 19de4e249cf382dca94e8a85eb7be116 18108510 main/binary-i386/Packages.gz     # Components索引路径
 da3490bafa667a48b8b93bb9b9348d8f 120 main/binary-i386/Release
 d41d8cd98f00b204e9800998ecf8427e 0 main/debian-installer/binary-i386/Packages
 7029066c27ac6f5ef18d660d5741979a 20 main/debian-installer/binary-i386/Packages.gz
 38e017f9b24495e4cab2ca5a9c9c14b7 69100127 main/binary-amd64/Packages
 97bafe91d09311f769e1044c3de46c54 18254805 main/binary-amd64/Packages.gz
 f1fa76ace33b3f97f57f3e61742699d5 336898 contrib/binary-i386/Packages
 149dab7121369f03621ca7bfd1d3c5a1 94663 contrib/binary-i386/Packages.gz
 28032f76ad6cec53ea646a6815e08ef1 123 contrib/binary-i386/Release
 90679be83b012f10a28001b3aa475c9a 366339 contrib/binary-amd64/Packages
 146e3b42e1abf2f82e2593203d65f1c2 102082 contrib/binary-amd64/Packages.gz
 0f39e21d3f8b7f8fcde1c750d761ea39 124 contrib/binary-amd64/Release
 2b490c61bca6fbc6839c35a9db1cf04f 277663 contrib/binary-arm64/Packages
 a94824e502815e3ca227715a8a9c1dfe 80822 contrib/binary-arm64/Packages.gz
SHA1:
```

（2）1031、1032、sp1、sp2等目录

这几个目录是第2层Codename，第一层是eagle。可以直接使用第2层Codename，如eagle/1031，其下也有Release文件。根据Release的不同，eagle和eagle/1031实际是不同的索引。

（3）contrib、main、non-free

这几个目录是eagle的几个Components，参考debian的Components，这几个Components根据软件性质给包分类了。



```html
> http://pools.uniontech.com/desktop-professional/dists/eagle/main/

Index of /desktop-professional/dists/eagle/main/
--------------
../
binary-amd64/                                      13-Dec-2021 13:35                   -
binary-arm64/                                      13-Dec-2021 13:35                   -
binary-i386/                                       13-Dec-2021 13:35                   -
binary-loongarch64/                                06-Dec-2021 17:33                   -
binary-mips64el/                                   13-Dec-2021 13:35                   -
binary-sw_64/                                      29-Jul-2021 14:35                   -
debian-installer/                                  27-Oct-2021 11:09                   -
source/                                            13-Dec-2021 13:35                   -
Contents-amd64.bz2                                 13-Dec-2021 13:32            28314041
Contents-arm64.bz2                                 13-Dec-2021 13:33            28188105
Contents-i386.bz2                                  13-Dec-2021 13:30            27615170
Contents-loongarch64.bz2                           06-Dec-2021 17:33              177724
Contents-mips64el.bz2                              13-Dec-2021 13:35            27632421
Contents-sw_64.bz2                                 29-Jul-2021 14:35               23873

> http://pools.uniontech.com/desktop-professional/dists/eagle/main/binary-amd64/

Index of /desktop-professional/dists/eagle/main/binary-amd64/
--------------

../
Packages                                           13-Dec-2021 13:28            69100127
Packages.gz                                        13-Dec-2021 13:28            18254805
Release                                            07-Dec-2020 10:46                 121
```

main是其中一个Components， 下面会可能存在多种架构的子分类，最终会找到Packages.gz ，里面就是包的最终索引，包含包的信息和在pool目录中的路径等。source即源码的索引，和包索引类似。

Packages.gz 内容如下，由很多个Package描述组成，这是其中一个：

```shell
Package: librust-object-dev
Source: rust-object
Version: 0.11.0-1
Installed-Size: 115
Maintainer: Debian Rust Maintainers <pkg-rust-maintainers@alioth-lists.debian.net>
Architecture: amd64
Provides: librust-object-0-dev (= 0.11.0-1), librust-object-0.11-dev (= 0.11.0-1), librust-object-0.11.0-dev (= 0.11.0-1)
Depends: librust-goblin-0.0.19+archive-dev, librust-goblin-0.0.19+elf32-dev, librust-goblin-0.0.19+elf64-dev, librust-goblin-0.0.19+endian-fd-dev, librust-goblin-0.0.19+mach32-dev, librust-goblin-0.0.19+mach64-dev, librust-goblin-0.0.19+pe32-dev, librust-goblin-0.0.19+pe64-dev, librust-scroll-0.9-dev, librust-uuid-0.7-dev
Recommends: librust-object+default-dev (= 0.11.0-1)
Suggests: librust-object+compression-dev (= 0.11.0-1), librust-object+flate2-dev (= 0.11.0-1), librust-object+parity-wasm-dev (= 0.11.0-1), librust-object+std-dev (= 0.11.0-1), librust-object+wasm-dev (= 0.11.0-1)
Size: 20112
SHA256: 291ebc858f7e1510c179cdd618f159cbcc0a247f837f83884d1d2ca52032ad44
SHA1: 2345f926d1d5f0634618e58beb8f25bc59b2e767
MD5sum: a6ec51fd85130e2abd7f621f98c34006
Description: Unified interface for parsing object file formats - Rust source code
 This package contains the source for the Rust object crate, packaged by
 debcargo for use with cargo and dh-cargo.
Multi-Arch: same
Section: rust
Priority: optional
Filename: pool/main/r/rust-object/librust-object-dev_0.11.0-1_amd64.deb       # 包的实际索引

Package: ...
```





## UOS仓库

（[UOS仓库说明](https://wikidev.uniontech.com/%E4%BB%93%E5%BA%93%E8%AF%B4%E6%98%8E#.E6.9C.8D.E5.8A.A1.E5.99.A8.E4.BC.81.E4.B8.9A.E7.89.88.E4.BB.93.E5.BA.93 )）

### 仓库分类
外网仓库、内网仓库、提交仓库



（以下部分内容根据仓库里的包版本推测的，没问到完整答案）

先放个项目的各类仓库版本参考：

```shell
uos@uos-PC:/etc/apt$ apt policy dde-daemon
dde-daemon:
  已安装：
  候选： 5.14.11-1
  版本列表：
     5.14.11-1 500 # 1050
     	# 目前在开发1050新功能
        500 http://pools.uniontech.com/ppa/dde-eagle eagle/1050/main main contrib non-free
        # ppa-unstable为新功能开发线，所以为1050版本的包
        500 http://pools.uniontech.com/ppa/dde-eagle unstable/main main contrib non-free
     5.13.99-1 500 # 1043
        500 http://pools.uniontech.com/ppa/dde-eagle eagle/1043/main main contrib non-free
     5.13.97-1 500 # 1042
     	# 外网eagle仓库，版本为目前发布的版本1042
        500 https://professional-packages.chinauos.com/desktop-professional eagle/main main contrib non-free
        # 内网eagle仓库，版本为目前发布的版本1042
        500 http://pools.uniontech.com/desktop-professional eagle/main main contrib non-free
        500 http://pools.uniontech.com/desktop-professional eagle/1042/main main contrib non-free
        500 http://pools.uniontech.com/ppa/dde-eagle eagle/1042/main main contrib non-free
     5.13.78-1 500 # 1041
        500 http://pools.uniontech.com/desktop-professional eagle/1041/main main contrib non-free
        500 http://pools.uniontech.com/ppa/dde-eagle eagle/1041/main main contrib non-free
        # ppa-stable为维护线，比发布版本早一点版本，发布版本为1042,所以维护版本为1041
        500 http://pools.uniontech.com/ppa/dde-eagle stable/main main contrib non-free
     5.13.41.2-1 500 # 1040
     	# eagle/1050 内网标准仓库比外网先有1050分支，这里应该该仓库正在建设中，还没更新，暂时是1040版本的包
        500 http://pools.uniontech.com/desktop-professional eagle/1050/main main contrib non-free
        500 http://pools.uniontech.com/desktop-professional eagle/1040/main main contrib non-frees
        500 http://pools.uniontech.com/ppa/dde-eagle eagle/1040/main main contrib non-free
     5.12.63-1 500  # 1032
        500 http://pools.uniontech.com/desktop-professional eagle/1032/main main contrib non-free
        500 http://pools.uniontech.com/ppa/dde-eagle eagle/1032/main main contrib non-free
     5.12.48-1 500	# 1031
        500 http://pools.uniontech.com/desktop-professional eagle/1031/main main contrib non-free
        500 http://pools.uniontech.com/ppa/dde-eagle eagle/1031/main main contrib non-free
     5.12.0.31.1-1 500 # sp3
     	# 这里开始，sp1、sp2、sp3是早期版本
        500 http://pools.uniontech.com/desktop-professional eagle/sp3/main main contrib non-free
        500 http://pools.uniontech.com/ppa/dde-eagle eagle/sp3/main main contrib non-free
     5.11.0.28-1 500 # sp1-sp2
        500 http://pools.uniontech.com/desktop-professional eagle/sp2/main main contrib non-free
        # ppa - sp2, 不知为何sp的版本，ppa线会比标准库晚一个版本
        500 http://pools.uniontech.com/ppa/dde-eagle eagle/sp2/main main contrib non-free           
        500 http://pools.uniontech.com/desktop-professional eagle/sp1/main main contrib non-free   
     5.10.0.1-1 500
     	# ppa - sp1
        500 http://pools.uniontech.com/ppa/dde-eagle eagle/sp1/main main contrib non-free            

uos@uos-PC:/etc/apt$ apt policy dde-control-center
dde-control-center:
  已安装：5.3.110+pingan2-1
  候选： 5.5.11-1
  版本列表：
     5.5.11-1 500
        500 http://pools.uniontech.com/ppa/dde-eagle eagle/1050/main amd64 Packages
        500 http://pools.uniontech.com/ppa/dde-eagle unstable/main amd64 Packages
     5.4.110-1 500
     	# 这个例子可见，ppa1043版本是可能高于desktop-professional1043的
        500 http://pools.uniontech.com/ppa/dde-eagle eagle/1043/main amd64 Packages
     5.4.109-1 500
        500 https://professional-packages.chinauos.com/desktop-professional eagle/main amd64 Packages
        500 http://pools.uniontech.com/desktop-professional eagle/main amd64 Packages
        500 http://pools.uniontech.com/desktop-professional eagle/1043/main amd64 Packages
        500 http://pools.uniontech.com/desktop-professional eagle/1042/main amd64 Packages
        500 http://pools.uniontech.com/ppa/dde-eagle eagle/1042/main amd64 Packages
```



#### 外网仓库

对外发布的仓库。

```shell
# 专业版
deb [by-hash=force] https://professional-packages.chinauos.com/desktop-professional eagle main contrib non-free #此域名为官方主仓库，需要通过授权管理工具激活，方可使用
```

#### 内网仓库

URI：http://pools.uniontech.com/

如果使用环境是外网，需vpn连接至公司内网



内网仓库的子仓库：

- 标准全量仓库

```shell
# 该仓库的包内容基本和外网一致，比外网先更新，也可理解为待发布仓库
# 专业版
deb http://pools.uniontech.com/desktop-professional/ eagle main contrib non-free

# 其他Codename列表
1031/                                              24-Nov-2021 16:29                   -
1032/                                              24-Nov-2021 16:29                   -
1040/                                              24-Nov-2021 16:28                   -
1041/                                              24-Nov-2021 16:28                   -
1042/                                              24-Nov-2021 16:26                   -
1043/                                              13-Dec-2021 11:17                   -
1050/                                              27-Aug-2021 10:33                   -
sp1/                                               24-Nov-2021 16:30                   -
sp2/                                               24-Nov-2021 16:29                   -
sp3/                                               24-Nov-2021 16:29                   -

# eg1：1032版本的全量标准仓库（用该仓库避免升级了超过1032的高版本软件包）
deb http://pools.uniontech.com/desktop-professional/ eagle/1032 main contrib non-free

# sp1、sp2、sp3 ： 1031前的版本号 （但看到crp的sp3仓库更新了1050的包，我很懵）
```

- 开发维护线ppa

```shell
# 增量仓库，包的版本可能基于标准全量仓库的版本上更新
# 专业版，eagle线。 ppa的eagle线的Codename列表和标准全量仓库差不多
deb http://pools.uniontech.com/ppa/dde-eagle  eagle  main contrib non-free  

# 稳定版本，维护线。摸索的大致规则：发布的版本的前一个版本，大版本跳过，如1041时发布1042, stable为1041； 1050时发布1051, stable为1043
deb http://pools.uniontech.com/ppa/dde-eagle  stable  main contrib non-free  

# 不稳定版本，当前新功能开发线，目前unstable为1050版本
deb http://pools.uniontech.com/ppa/dde-eagle  unstable  main contrib non-free  
```



#### 提交仓库

URI：http://aptly.uniontech.com/

提交仓库下面有两类子仓库:

(1) CRP打包会该地址下生成主题仓库

```shell
# eg：CRP的eagle-1032分支下的某个主题子仓库
deb [trusted=yes] http://aptly.uniontech.com/pkg/eagle-1032/release-candidate/5Z-f566hMTAzMuS-nei1luS7k-W6kzIwMjEtMDctMDIgMTA6NDY6MTA  unstable main
```



(2) gerrit配置通用的推送仓库

```shell
# gerrit-pipeline中配置PushTo，可以把当前分支中编译生成的包推送到该仓库
"PushTo": [
	"dev-commit"
]

# 提交仓库的dev-commit子仓库
deb [trusted=yes] http://aptly.uniontech.com/pkg/dev-commit/commit experimental main
```



### 版本分类

在上述仓库中可以看到有很多子仓库，前面用的eagle专业版举例，其中还有如下版本：

eagle：专业版

fou：服务/企业版

euler：欧拉版

uranus：教育版

community：社区版



### 仓库配置实战

eg1 平安1032分支编译依赖仓库

一般需要配置3个仓库，

```json
{
                "Name": "dev/pingan-1032",
                "Arches": [
                    "amd64",
                    "arm64"
                ],
                "Archives": [
                    # 1 - 先配置1032全量标准仓库（基础包的仓库，包含dde的包，基于发布版本）
                    "deb http://pools.uniontech.com/desktop-professional eagle/1032 main contrib non-free",
                    # 2 - 再配置ppa增量仓库（1032可能有一些内部更新了但没发布的包）
                    "deb http://pools.uniontech.com/ppa/dde-eagle eagle/1032 main contrib non-free",
                    # 3 - 最好配一个主题对应的提交仓库（通过提交就能解决依赖问题）
                    "deb  [trusted=yes] https://aptly.uniontech.com/pkg/eagle-1032/release-candidate/RERF5bmz5a6J5LqM5pyfMjAyMS0xMC0yMSAxMzoxNDowOA/  unstable main"
                    
                    # 错误例子1:eagle版本不是固定的，会跟随发布的版本变化，现在没问题，但后面就可能出问题
                    "deb http://pools.uniontech.com/desktop-professional eagle main contrib non-free",
                    # 错误例子2:类似这种通用的推送仓库，没用好里面的包版本很乱，很容易被别的项目推送了高版本包导致出错
                    "deb [trusted=yes] http://aptly.uniontech.com/pkg/uos-exprimental/commit unstable main",
                ]
},
```





## gerrit-pipeline配置

https://gerrit.uniontech.com/admin/repos/gerrit-pipeline

gerrit-project-settings.json

代码提交到gerrit时，每个项目会根据这个json文件来配置编译环境。可用*通配多个分支，按顺序读取，如下例子，"maintain/*"会应用于所以前缀是maintain的分支，但按顺序，maintain/5.3.1会用"maintain/5.3.1"配置, 而maintain/20_0102会先用"maintain/*"的配置，所以用*匹配的通用分支描述应该放在最后面。



Name：分支名

Arches：自动打包的架构

Archives：仓库

PushTo：打包成功后，把新包推送到开发仓库的指定子仓库（上文的http://aptly.uniontech.com/pkg/子仓库名）

```json
{
        "Name": "dde-daemon",
        "Comment": "dde-backend",
        "Branches": [
            {
                "Name": "maintain/5.3.1",
                "Arches": [
                    "amd64",
                    "arm64",
                    "mips64el"
                ],
                "Archives": [
                    "deb http://pools.uniontech.com/desktop-professional eagle main contrib non-free",
                    "deb http://pools.uniontech.com/ppa/dde-eagle unstable main contrib non-free",
                    "deb [trusted=yes] http://aptly.uniontech.com/pkg/dev-commit/commit experimental main",
                    "deb [trusted=yes] http://aptly.uniontech.com/pkg/eagle-1040/release-candidate/W0RERV3kuLvnur8xMDQw54mI5pys5YaF6YOo5rWL6K-VLTEyMjUyMDIwLTEyLTI1 unstable main"
                ],
                "PushTo": [
                    "dev-commit"
                ]
            },
            {
                "Name": "maintain/*",
                "Arches": [
                    "amd64"
                ],
                "Archives": [
                    "deb http://pools.uniontech.com/desktop-professional eagle main contrib non-free",
                    "deb http://pools.uniontech.com/ppa/dde-eagle unstable main contrib non-free",
                    "deb [trusted=yes] http://aptly.uniontech.com/pkg/uos-exprimental/commit experimental main",
                    "deb [trusted=yes] http://aptly.uniontech.com/pkg/eagle-1041/release-candidate/RERFIG1hc3RlciDliIbmlK8gZ2Vycml0LXBpcGVsaW5lMjAyMS0wOC0yOCAxMTowMzowMA unstable main"
                ],
                "PushTo": [
                    "uos-exprimental"
                ]
            },
            {
                "Name": "maintain/20_0102",
                "Arches": [
                    "arm64"
                ],
                "Archives": [
                    "deb [trusted=yes] http://pools.corp.deepin.com/uos eagle/sp1 main contrib non-free",
                    "deb [trusted=yes] http://aptly.uniontech.com/pkg/eagle/release-candidate/5Y2O5Li6S2VsdmluVSBJU0-pm4bmiJDkuJPnlKg1MDQ unstable main",
                    "deb [trusted=yes] http://aptly.uniontech.com/pkg/nonfree-eagle/release-candidate/5Y2O5Li6S2VsdmluVSBJU0-pm4bmiJDkuJPnlKg1MDQ unstable main"
                ]
            },
            {
                "Name": "wayland/dev",
                "Arches": [
                    "arm64"
                ],
                "Archives": [
                    "deb [trusted=yes] http://pools.corp.deepin.com/desktop-professional eagle/sp2 main contrib",
                    "deb [trusted=yes] http://zl.uniontech.com/klu/klu-crp eagle  main  non-free",
                    "deb [trusted=yes] http://zl.uniontech.com/aptly/wayland-master-dev unstable main non-free"
                ]
            }

        ]
    },
```



