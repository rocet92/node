# devscripts - debuild
（待补充，用到啥补充啥）  

### 
介绍

```bash
# devscripts是debian开发工具的集合，其中包含debuild、dch，安装devscripts：
sudo apt install devscripts

# debuild：创建一个debian的包
# dch:用于在源程序包中维护debian/changelog文件的工具
```
debuild

```bash
# 它首先运行dpkg-buildpackage，然后在创建的.changes文件上运行lintian（假设安装了lintian），最后根据需要对.changes和/或.dsc文件进行签名（使用debsign(1)来执行此操作而不是dpkg -buildpackage(1) 本身；传递所有相关的密钥签名选项）。
# ebuild需要以超级用户身份运行才能正常运行。有三种根本不同的方法可以做到这一点。第一种也是更可取的方法是使用一些获得根的命令。最好使用的可能是 fakeroot(1)，因为它不涉及授予任何真正的特权。 super(1)和sudo (1) 也是可能的。如果没有给出-r（或 --rootcmd）选项（并且回想一下dpkg-buildpackage 也接受-r选项）并且以下方法都没有使用，那么-rfakeroot将被静默假设。
# 经典用法：
debuild -us -uc 
# debuild 可以直接指定dpkg-buildpackage的参数，如-us -uc ，debuild的参数放前面，dpkg-buildpackage的参数的参数放后面
# debuild不带任何参数即可开始打包，默认是fakeroot方式，一般只需带dpkg-buildpackage的参数
```
dpkg-buildpackage选项

```bash
# 详见man dpkg-buildpackage
--build=type - 指定编译类型，如all、source、any、binary、full
-b - 即--build=binary
-S -  即--build=source
-us|--unsigned-source  - 不要在源代码包上签名
-uc|--unsigned-changes - 不要对.buildinfo和.changes文件进行签名
-nc|--no-pre-clean     - do not pre clean source tree (implies -b).
```
debuild官方示例

```bash
debuild -i -us -uc -b # -i为debuild 参数，-us -uc -b为dpkg-buildpackage的参数
```
dch 选项

```bash
-b|--force-bad-version - 
-v|--newversion - 


dch -bv $(git describe --tags|awk -F- '{ print $1 "+r" $2 "+" $3}') u
# -bv生成entry，但是distribution信息为UNRELEASED，相当于标记为未完成，下次继续-bv不会生成新的entry，而是在最近一个entry补充，然后通过dch -r，把UNRELEASED转换为unstable
# 可以用-D unstable直接生成一个新的distribution信息为unstable的entry
# -m表示生成的entry不会用新的维护者信息，而是用上一个entry的维护者信息
dch -m -D unstable -bv "1.6.0" "commit msg"
```
s