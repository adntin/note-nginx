
### 负载均衡

```
http {
  upstream imgserver{
    server 127.0.0.1:82 weight=1 max_fails=2 fail_timeout=3;
    server 127.0.0.1:81 weight=1 max_fails=2 fail_timeout=3;
  }
  server {
    listen       81;
    server_name  localhost;
    root html;
    # access_log logs/81-access.log
  }
  server {
    listen       82;
    server_name  localhost;
    root html;
    # access_log logs/82-access.log
  }
  server {
    listen       80;
    server_name  localhost;
    location / {
      root   html;
      index  index.html index.htm;
    }
    location \.(jpg|gif|bmp|jpeg) {
      proxy_pass http://imgserver; # 实现负载均衡
      proxy_set_header X-Forwarded-For $remote_addr; # 把浏览器IP传递给node服务器
    }
  }
}
```