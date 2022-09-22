# debhelper






dh\_shlibdeps是一个debhelper程序，负责计算包的共享库依赖项。

这个程序只是dpkg shlibdeps（1）的包装器，它为control中列出的每个包调用一次，并向其传递一个ELF可执行文件列表和找到的共享库。



假设源程序包生成libfoo1、libfoo-dev和libfoo-bin二进制程序包。libfoo-bin链接到libfoo1，应该依赖它。在规则文件中，首先运行dh\_makeshlibs，然后运行dh\_shlibdeps.

这将自动为libfoo1生成一个shlibs文件，并使用该文件和debian/libfoo1/usr/lib目录中的libfoo1库来计算共享库依赖信息。

如果还生成了 libbar1 包，即 libfoo 的替代构建，并安装到 /usr/lib/bar/，则可以使 libfoo-bin 依赖于 libbar1，如下所示：

```Plain Text
dh_shlibdeps -Llibbar1 -l/usr/lib/bar
```


关于debian的control中依赖规范：

1，在rules中添加

```cpp
%:
	dh $@

#override_dh_shlibdeps:
#	dh_shlibdeps -- --ignore-missing-info
```
2，control中Depends选项添加：

```cpp
Depends:
  ${shlibs:Depends},
  ${misc:Depends},
```
3，\${shlibs:Depends}说明

\${shlibs:Depends}会根据最终deb中二进制，获取其链接的库列表，然后自动补充这些库的依赖包到Depends。

也就是说非链接库形式的依赖，不会被自动补充依赖，需要手动添加，如dde-api。

确认方法：先去掉Depends中依赖包，只添加\${shlibs:Depends}，然后debuild本地打包，查看debian下生成.substvars文件的shlibs:Depends指定的包有哪些，shlibs:Depends只不包含但需要的依赖手动添加到Depends。



4，shlibdeps原理及参数

【shlibdeps】

dpkg-shlibdeps 计算在其参数中命名的可执行文件的共享库依赖关系。添加到替换变量文件 debian/substvars 中。

dpkg-shlibdeps 有两种可能的信息来源来生成依赖信息。 符号文件或 shlibs 文件。

 对于 dpkg-shlibdeps 分析的每个二进制文件，它会找出与其链接的库列表。 

然后，对于每个库，它会查找符号文件或 shlibs 文件。 这两个文件都应该由库包提供，因此应该以 /var/lib/dpkg/info/package.symbols 或var/lib/dpkg/info/package.shlibs 的形式提供 . 包名分两步确定：在系统上查找库文件（查找 ld.so 将使用的相同目录），然后使用 dpkg -S library-file 查找提供库的包。



参数列表：

* \--ignore-missing-info

如果找不到共享库的依赖信息（从 dpkg 1.14.8 起），请不要失败。 不鼓励使用此选项，所有库都应提供依赖信息（使用 shlibs 文件或使用符号文件），即使它们尚未被其他包使用。

* \--dpkg-shlibdeps-params=params

这是将参数传递给 dpkg-shlibdeps(1) 的另一种方法。 它已弃用； 使用 -- 代替。



【Priority】[https://www.debian.org/doc/debian-policy/ch-archive.html#s-priorities](https://www.debian.org/doc/debian-policy/ch-archive.html#s-priorities)

* **Required**(必须) 该级别软件包是保证系统正常运行必须的。

包含所有必要的系统修补工具。不要删除这些软件包，否则整个系统将受到损坏，甚至无法使用`dpkg`恢复。只安装 Required 级软件包的系统不可能满足所有的用途，但它可以启动起来，让系统管理员安装想要的软件。

* **Important**(重要) 在任何类 Unix 系统上均安装有该级别软件包。

系统若缺少这类软件，会运行困难或不能使用。该级别软件包并**不**包括 Emacs 或 X11 或 TeX 或其它大型应用程序。它们只是一些实现系统底层功能的程序。

* **Standard**(基本) 该级别软件包是任何 Linux 系统的标准件，它们组成一个小而精的字符模式的系统。

系统的默认安装就包括了它们。“Standard”级软件包不包括许多大型应用程序，但它包括Emacs(它比其它应用程序更底层)和 Tex 及 LaTeX 的精巧版(不支持 X)。

* **Optional**(推荐) 该级别软件包包括那些你可能想安装的软件，即使对它们并不熟悉,但对它们没有特殊的要求。

它们包括 X11，TeX 完整发布版和许多应用程序。

* **Extra**(额外) 该级别软件包可能与其它高级别软件包冲突，仅当你知道其用途时才会使用它们，或者有运行它们有专门要求，这些都使它们不适合定为“Optional”级。



【Sections】[https://www.debian.org/doc/debian-policy/ch-archive.html#s-subsections](https://www.debian.org/doc/debian-policy/ch-archive.html#s-subsections)

归档区域main、contrib和non-free中的包被进一步分组为多个\_部分\_以简化处理。

每个包的存档区域和部分应在包的`Section`控制记录中指定。但是，Debian 存档的维护者可能会覆盖此选择以确保 Debian 发行版的一致性。

Debian 档案维护者提供了权威的章节列表。目前有：admin, cli-mono, comm, database, debug, devel, doc, editors, education, electronics, embedded, fonts, games, gnome, gnu-r, gnustep, graphics, hamradio, haskell, httpd, interpreters, introspection, java, javascript, kde, kernel, libdevel, libs, lisp, localization, mail, math, metapackages, misc, net, news, ocaml, oldlibs, otherosfs, perl, php, python, ruby, rust, science, shells, sound, tasks, tex, text, utils, vcs, video, web, x11, xfce, zope。附加部分debian-installer包含安装程序使用的特殊软件包，不用于普通 Debian 软件包。





