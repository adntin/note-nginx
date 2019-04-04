#!/bin/bash

# echo `date -d yesterday +%Y%m%d`
# 20190405

# 定义变量, 赋值等号(=)左右不能有空格
YYYY_MM=$(date -d yesterday +%Y%m) # 201904
BAK_DIR=/var/log/nginx/test.daxiaodiao.com/$YYYY_MM
# 1. 每天生成不同的文件, 用于生产环境!!!!!!
# DD=$(date -d yesterday +%d) # 04
# BAK_PATH=$BAK_DIR/$DD.access.log
# 2. 每分钟生成不同的文件, 用于测试, 测试完需要换成按天生成, 更重要的是一定去修改定时任务!!!!!!
DD_HH_MM=$(date -d yesterday +%d%H%M) # 051635 或者 050000
BAK_PATH=$BAK_DIR/$DD_HH_MM.access.log
LOG_PATH=/root/nginx/logs/access.log

# echo $BAK_PATH
# /var/nginx/logs/test.daxiaodiao.com/201904/05.access.log
# /var/nginx/logs/test.daxiaodiao.com/201904/051635.access.log

# 创建日志目录, -p表示父级没有就创建, 按年月创建文件夹, 比如201904
mkdir -p $BAK_DIR
# 重要提示: 这一步必须要, 否则移动文件会报错

# 移动日志文件(备份)
mv $LOG_PATH $BAK_PATH
# 重要提示: 移动文件之后, 此时访问网站, 访问记录放在 /var/log/nginx/test.daxiaodiao.com/xxx.log 中, 因为 linux 实际是根据 inode 指向磁盘文件

# 重新生成 access.log 文件, 实际是 nginx 重新生成 inode 指向
kill -USR1 `cat /root/nginx/logs/nginx.pid`
# 重要提示: 重截日志之后, 此时访问网站, 访问记录放在 access.log 中

# 测试 ------------------------------
# vim /root/nginx/linbin/log.sh
# http://test.daxiaodiao.com/
# ll /root/nginx/logs/
# ll /var/log/nginx/test.daxiaodiao.com/201904/