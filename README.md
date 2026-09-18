# CMSware Plus

> 2003–2006 年代国内主流内容管理系统（CMS）之一的完整源码归档。
> **状态：历史归档（Archived）** —— 作为 AI 重构新版的参照基线发布。

## 历史背景

- **CMSware（思维内容管理系统）** 由 [雷志锋](https://github.com/flyhawking) 于 2003–2006 年开发，PHP + MySQL 架构。
- 巅峰期位列国内 CMS TOP3（与动易 PowerEasy、PHPCMS 同期竞争）。
- 本仓库为 **CMSware Plus（2.7）** 版本的完整源码，快照日期 2007-01-07，含采集、投稿、评论、发布引擎、内容模型等完整功能。
- 软件著作权登记号 2005SR02994，登记于原作者个人名下。

## 环境要求（历史环境）

| 组件 | 版本 |
|---|---|
| PHP | 4.x / 5.x（含 PHP5 兼容层，`*.php5.php`） |
| MySQL | 4.x / 5.x |
| Web 服务器 | Apache（需支持 .htaccess） |

> ⚠️ 这是 2006 年的代码：依赖 `register_globals` 时代的写法、GBK 字符集、IE-only 后台编辑器（DevEdit）。**请勿直接部署到公网**，安全标准已不符合现代要求。

## 目录结构

```
├── admin/        后台管理
├── publish/      发布引擎（前台入口）
├── include/      核心函数库、kDB 数据库层、kTemplate 模板引擎
├── classes/      CMS 核心模型（ContentModel / Node / DataSource / DataGateway）
├── install/      安装程序与数据库脚本（core.sql、内容模型定义、demo 站）
├── templates/    内容模板
├── skin/         后台皮肤
├── plugins/      插件（评论、全文检索、论坛接口、OAS 通行证）
├── setting/      系统设置与自定义函数
├── sysdata/      运行时数据目录（缓存/session，运行时生成）
├── resource/     上传资源目录（运行时生成）
├── converter/    旧版数据转换工具
├── doc/          文档
└── changelog.txt 更新日志
```

## 关于本归档版本

- 源码已从原始 **GBK/GB2312 批量转换为 UTF-8**（686 个文件），中文注释可直接阅读。
- `config.php` 已用 `config.sample.php` 模板替代，运行时文件（日志、缓存、session、已发布页面）已清理。
- 安装：配置 `config.php` 后访问 `install.php`，数据库脚本见 `install/`。

## 后续计划

本仓库作为「历史归档先行」的基线，后续将进行 **AI 重构**：继承内容模型 / 结点设计，补齐 API-first + MCP Server 接口层，让人和 AI Agent 都能读写内容。

## License

[MIT](LICENSE) © 2003-2026 雷志锋 (Lei Zhifeng)
