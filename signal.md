### 官方文档

https://www.nginx.com/resources/wiki/start/topics/tutorials/commandline/

### 查看 nginx 进程 id

- ps -aux | grep nginx

### 不想查看 nginx 进程 id, 因为在/root/nginx/conf/nginx.conf 里面有配置 pid 的存放路径

- kill -HUP `cat /root/nginx/logs/nginx.pid` === kill -HUP 12345

### 主进程可以处理如下信号:

| SIGNAL    | Description                                     |
| :-------- | :---------------------------------------------- |
| TERM, INT | 快速关闭进程, 正在请求的连接会丢失, 不建议使用. |
| QUIT      | 优雅关闭进程, 等请求结束后再关闭, 建议使用.     |
| KILL      | 关闭一个顽固的进程                              |
| HUP       | 改变配置文件, 平滑的重读配置文件                |
| USR1      | 重读日志文件, 可在日志切割时使用                |
| USR2      | 平滑升级                                        |
| WINCH     | 优雅关闭旧的进程, 配合 USR2 来进行升级          |

#### 直接关闭

- kill -INT `cat /root/nginx/logs/nginx.pid` === cd /root/nginx && ./sbin/nginx -s stop

### 优雅关闭

- kill -QUIT `cat /root/nginx/logs/nginx.pid` === cd /root/nginx && ./sbin/nginx -s quit

#### 重载配置

- kill -HUP `cat /root/nginx/logs/nginx.pid` === cd /root/nginx && ./sbin/nginx -s reload

#### 重启

- kill -USR1 `cat /root/nginx/logs/nginx.pid` === cd /root/nginx && ./sbin/nginx -s reopen

#### 切割日志

- cd /root/nginx
- mv logs/access.log logs/access.bak.log // 重命名
- ll /root/nginx/logs // 查看文件大小, 此时访问网站, 访问记录放在 access.bak.log 中, 因为 linux 实际是根据 inode 指向磁盘文件
- kill -USR1 `cat /root/nginx/logs/nginx.pid` // 重新生成 access.log 文件, 实际是 nginx 重新生成 inode 指向
- ll /root/nginx/logs // 查看文件大小, 此时访问网站, 访问记录放在 access.log 中

### 版本升级

- kill -USR2 `cat /root/nginx/logs/nginx.pid`

### 子进程不需要控制它自己. 然而它也支持如下信号:

| SIGNAL    | Description          |
| :-------- | :------------------- |
| TERM, INT | Quick shutdown       |
| QUIT      | Graceful shutdown    |
| USR1      | Reopen the log files |
