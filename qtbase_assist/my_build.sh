#!/bin/bash

# 检查是否传入了构建路径参数
if [ $# -ne 1 ]; then
    echo "请传入一个构建路径作为参数！"
    exit 1
fi

# 获取传入的构建路径参数
path="$1"

# 检查路径是否存在
if [ ! -d "$path" ]; then
    echo "指定的路径不存在！"
    exit 1
fi

rm -rf "$path"/*

cd ..
# 检测目录下是否有名为build的文件夹
if [ -d "build" ]; then
    echo "build文件夹已存在，清空文件夹内容..."
    rm -r build/*    # 清空build文件夹内容
else
    echo "build文件夹不存在，创建文件夹..."
    mkdir build    # 新建build文件夹
fi

# 将上一级目录中的autoconfig.sh复制到build文件夹下
cp qtbase_assist/autoconfig.sh build/

cd build

sh autoconfig.sh "$path/qtbase"

make -j4 && make install

# 进入指定的路径
cd "$path" || exit 1

echo "已进入目录：$(pwd)"
mkdir qtcore
cd qtcore 
mkdir lib
mkdir include
cd ..

# 指定目标文件夹A和B的路径
folder_A="$path/qtcore/include"
folder_B="$path/qtcore/lib"

# 进入include文件夹，复制QtCore文件夹到文件夹A
cd qtbase
if [ -d "include" ]; then
    echo "复制include/QtCore到文件夹A..."
    cp -r include/QtCore "$folder_A"
else
    echo "include文件夹不存在！"
fi

# 进入lib文件夹，复制指定文件到文件夹B
if [ -d "lib" ]; then
    echo "复制lib/cmake、lib/pkgconfig和libQt5Core.*到文件夹B..."
    cp -r lib/cmake "$folder_B"
    cp -r lib/pkgconfig "$folder_B"
    cp lib/libQt5Core.* "$folder_B"
else
    echo "lib文件夹不存在！"
fi

cd ..

rm -rf qtbase

echo "操作完成！"








