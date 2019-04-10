
### 反向代理

browser --> ginx --> node

```
http {
  server {
    listen       80;
    server_name  localhost;
    location / {
      root   html;
      index  index.html index.htm;
    }
    location \.js$ {
      proxy_pass http://127.0.0.1:3000; # 反向代理
      proxy_set_header X-Forwarded-For $remote_addr; # 把浏览器IP传递给node服务器
    }
  }
}
```