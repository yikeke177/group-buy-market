# 公开副本说明

本副本基于原项目 master 提交 `5ddf350246725b01c216ffc5b07c690e380bd0d8`（2025-08-24）。
原仓库：git@gitcode.net:KnowledgePlanet/group-buy-market.git

保留原项目的代码、作者标注和文档。公开仓库从新提交开始，避免旧历史中遗留的凭据被公开。

## 启动前配置

- Spring 配置的数据库和 RabbitMQ 密码通过 `SPRING_DATASOURCE_PASSWORD`、`SPRING_RABBITMQ_PASSWORD` 提供。
- Docker Compose 中的密码、Grafana API key、微信密钥通过对应名称的环境变量提供。
- NATAPP token 留空，请在本地填入自己的值，不要提交。
- Grafana 数据库 SQL 保留结构、移除导出的数据行；需要重新配置用户、数据源和仪表盘。

不要把实际凭据提交到公开仓库。
