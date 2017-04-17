#!/bin/bash
    # 本脚本运行由cat650制作，有问题联系cat650@163.com
    # 脚本适用于xubuntu环境，请提前安装ecryptfs-utils   
    # 脚本另存为topsc.sh 存放于/bin
    count=0 ##初始值
  dir="/tmp/mnt/ecryptfs$count" ##初始挂载点
  echo "已挂载加密目录有："
  while df|grep -q $dir 2>/dev/null  ##挂载点 是否使用了
  do
echo $dir
let count=$count+1 ##一定要是/bin/bash如是/bin/sh这里就会出错
dir="/tmp/mnt/ecryptfs$count"  ###新挂载点
done
echo "新增挂载目录："$dir
echo "等待超级用授权"
if [ ! -d $dir ];then ##判断目录是否存在
sudo mkdir -p $dir ###建立新挂载点目录,选项p，可以创建连续文件夹
fi
    echo "授权完成，开始加密……"
    echo "请输入加密密码，选择加密方式："
    sudo mount -t ecryptfs $(pwd) $dir  ### $( )为引用命令结果
    echo "显示加密文件夹"
    thunar $dir   ## 请改为你当前环境下文件编辑器，当前为xubuntu
    echo $dir"已处于加密状态"
    read -p "是否自动卸载加密文件夹(yes?)" yn
    if [ "$yn" != "yes" ]; then
    echo "请记得手动解除加密"
    echo "命令为：sudo umount /tmp/mnt/ecryptfs*"
    read -p "回车退出" no
    exit 0
    fi
    echo "去加密……"
    sudo umount $dir
    sudo rmdir $dir
    ## 下面删除缓存图片，这个大家自己设置。我把整个文件夹链到了/tmp.普通用户位置是：~/.thumbnails/
    ## rm -r /tmp/large/
    ## rm -r /tmp/normal/
    echo "处于加密状态的文件夹有："
    df|grep "tmp/mnt"
    read -p "请验证是否已解除加密,回车退出" no
