# Task01 Project Hunt 学习笔记

## 任务目标
从 `.project/metadata` 文件提取 `PROJECT_ID`，并获取该文件的相对路径，分别写入 output 目录下两个文本文件。
- `output/01_project_id.txt`：保存项目ID
- `output/01_relative_path.txt`：保存metadata文件相对路径

## 使用命令
在文件中搜索关键字
grep -r "PROJECT_ID" ./.project/metadata

将内容重定向写入文件，> 代表覆盖写入
echo "LSR‑2026‑0831" > output/01_project_id.txt
echo "../../.project/metadata" > output/01_relative_path.txt(..代表父目录)

# Task02 学习笔记
## 1. 文件执行权限
命令：`chmod +x ./tools/recruit‑info`
作用：赋予文件可执行权限，无需sudo，不修改文件内容。
>注意路径写法 `./tools`，不可省略斜杠。

## 2. PATH环境变量
PATH存放一组目录。只输入命令名时，Shell只会在PATH的目录里查找可执行程序。
- `./tools/recruit‑info`：指定相对路径执行，**不依赖PATH**。
- 直接输入`recruit‑info`：tools不在PATH中，提示`command not found`。
- `ls`执行：Shell按顺序遍历PATH，找到ls程序运行。

##3. 临时修改PATH
export PATH=$PATH:./tools


# Task03 文件内容搜索学习笔记

## 任务需求
递归扫描 `workspace/project/` 目录，找出内容包含 `TODO` 或者 `FIXME` 的普通文件。

输出约束：
1. 同一个文件路径只出现一次，即使文件内多处匹配标记
2. 文件路径按照字典序升序排列
3. 每行一条文件路径
4. 结果保存到：`output/03_code_search.txt`

## 完整命令
grep -r -l -E 'TODO|FIXME' workspace/project/ | sort | uniq > output/03_code_search.txt
（-r :递归搜索，遍历目录下所有子文件）
（-l :只输出匹配成功的文件路径，不输出文件内部文本）
（-E :启用扩展正则表达式， | 表示逻辑或，匹配TODO或者FIXME）
（sort:对输出的文件路径执行字典序排列）
（uniq:去除连续重复行）

# Task04 日志统计学习笔记

## 任务需求
处理日志文件 `logs/server.log`，完成3项统计：
1. 统计ERROR日志总行数，保存到 `output/04_error_count.txt`
2. 提取出现ERROR的用户名，去重、字典序排序，保存到 `output/04_error_users.txt`
3. 找出出现次数最多的错误类型，保存到 `output/04_top_error.txt`

日志样例：
`2025‑10‑01 10:20:30 ERROR user=alice connection_timeout`

## 完整命令
 1.统计ERROR行数
grep -c "ERROR" logs/server.log >output/04_error_count.txt

 2.提取用户名
 grep "ERROR" logs/server.log | cut -d' ' -f4 |cut -d'=' -f2 |sort |uniq > output/04_error_users.txt

 3.找出最多的错误类型
grep "ERROR" logs/server.log | cut -d' ' -f5 |cut -d'=' -f2 |sort |uniq -c| sort -nr| head -1 | awk '{print $2}' > output/04_top_code.txt
（cut -d'?' -f? :以？为分隔符,取第？字段）
（uniq -c:统计每一行重复出现多少次）
（sort -nr :数字降序，次数达的放前面）
（head -1:只取第一行）
（awk '{print $2}': 取出第二列，丢掉左边计数字数）
（wc-l:统计行数）
