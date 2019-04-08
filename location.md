https://www.cnblogs.com/lidabo/p/4169396.html

### 匹配模式

- `location PATTERN {}` [普通匹配]
- `location = PATTERN {}` [精确匹配]
- `location ~ PATTERN {}` [区分大小写正则匹配]
- `location ~* PATTERN {}` [不区分大小写的正则匹配]
- `location ^~ PATTERN {}` [普通 location 一旦匹配上，则不需要继续正则匹配]

### location 分类

- 普通 location: location using literal strings

- 正则 location: location using regular expressions

### 匹配规则

To summarize, the order in which directives are checked is as follows:

1. Directives with the “=” prefix that match the query exactly. If found, searching stops.
2. All remaining directives with conventional strings. If this match used the “^~” prefix, searching stops.
3. Regular expressions, in the order they are defined in the configuration file.
4. If #3 yielded a match, that result is used. Otherwise, the match from #2 is used.

另外: 如是普通匹配(literal strings)是完全匹配(exact match), 则会停止搜索正则匹配(regular expressions).

总结: 正则 location 匹配让步普通 location 的严格精确匹配结果；但是会覆盖普通 location 的最大前缀匹配结果.
