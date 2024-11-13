#!/bin/bash
ENV_FILE=".env"
# 检查 .env 文件是否存在
if [ -f "$ENV_FILE" ]; then
    echo "$ENV_FILE 文件已存在。"
else
    # 生成MYSQL随机密码
    MYSQL_PASSWORD=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 18)
    echo "MYSQL_PASSWORD=$MYSQL_PASSWORD" >> "$ENV_FILE"
    echo "MYSQL随机密码已生成并写入 $ENV_FILE 文件。"
    # 生成REDIS随机密码
    REDIS_PASSWORD=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 12)
    # 将密码写入 .env 文件
    echo "REDIS_PASSWORD=$REDIS_PASSWORD" >> "$ENV_FILE"
    echo "REDIS随机密码已生成并写入 $ENV_FILE 文件。"
    echo "初始化密码创建成功"
fi

rm -rf ./logs/log/*
docker-compose down
docker-compose --profile production up -d
echo "欢迎使用 ShopAround"
echo "登录地址：http://ip:8080"
echo "如访问不到，请检查防火墙配置"
