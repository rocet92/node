#!/bin/bash
echo "-------node push--------"
echo "generate SUMMARY"
book sm

# book bug，文件名有空格只会转义第一个
#     * [(转)容器和权限2：Cgroups 与 Systemd](linux/Liunx理论基础/(转)容器和权限2：Cgroups%20与 Systemd.md)
ErrorFile=()
while read -r line
do
    # echo "$line"
    file=$(echo "$line" | sed -r "s/.*\[.*\]\((.*)\)$/\1/g")
    if [[ "$file" != *".md"* ]]; then
        continue
    fi
    if [ "$file" != "${file/ /a}" ]; then
        ErrorFile[${#ErrorFile[*]}]=$file
    fi
done < SUMMARY.md
for file in "${ErrorFile[@]}"
do
    echo "SUMMARY fix, FROM:""$file"
    newfile=$(echo "$file" | sed -r "s/ /%20/g")
    echo "SUMMARY fix, TO:""$newfile"
    sed -i "s?$file?$newfile?g" SUMMARY.md
done

git add -A
git commit -m "update"
git push
echo "---------------------"