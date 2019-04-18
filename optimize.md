### 查看nginx错误日志

tail /root/nginx/logs/error.log

错误: Too many open files
原因: 打开太多文件, 一个进程只允许打开1024个文件

### 查看系统核心日志

dmesg | tail

错误: possible SYN flooding on port 80. Sending cookies.
原因: 80端口访问太多, 是不是有洪水攻击, 每次请太cookie过去, 防止洪水攻击

---

### 高并发思路

##### socket
- nginx
  - 子进程允许打开的连接数
    - vim /root/nginx/conf/nginx.conf // 1024
    - events.worker_connections: 10000;
- system
  - 设置socket最大连接数
    - cat /proc/sys/net/core/somaxconn // 128
    - echo 50000 > /proc/sys/net/core/somaxconn
  - 加快tcp连接的回收
    - cat /proc/sys/net/ipv4/tcp_tw_recycle // 0
    - echo 1 > /proc/sys/net/ipv4/tcp_tw_recycle 
  - 空的tcp连接允许回收利用
    - cat /proc/sys/net/ipv4/tcp_tw_reuse // 0
    - echo 1 > /proc/sys/net/ipv4/tcp_tw_reuse 
  - 设置成不做洪水抵御
    - cat /proc/sys/net/ipv4/tcp_syncookies // 1
    - echo 0 > /proc/sys/net/ipv4/tcp_syncookies

##### file
  - nginx
    - 子进程允许打开的文件数
      - vim /root/nginx/conf/nginx.conf
      - worker_limit_nofile: 10000; // 最外层
  - system
    - 设置同一时间最多可开启的文件数
      - ulimit -n // 查看, 结果: 1024 或者 100001
      - ulimit -n 50000 // 设置