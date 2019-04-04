### linux 查看日期

- date -d yesterday // Wed Apr 3 15:04:00 CST 2019
- date -d yesterday +%Y%m%d // 20190410

### linux 设置日期

- date -s '2019-04-10 18:00:00'

### 创建 bash 脚本

- mkdir /root/nginx/linbin
- cd /root/nginx/linbin
- vim log.sh

### 运行 bash 脚本

- sh log.sh

### 定时任务, 每分钟执行一次

- crontab -e
- `*/1 * * * * sh /root/nginx/linbin/log.sh`
  - `格式: 分 时 日 月 周 命令`
  - `每五分钟执行 */5 * * * *`
  - `每小时执行 0 * * * *`
  - `每天执行 0 0 * * *`
  - `每周执行 0 0 * * 0`
  - `每月执行 0 0 1 * *`
  - `每年执行 0 0 1 1 *`
