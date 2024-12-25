# 使用官方nginx镜像作为基础镜像
FROM nginx:alpine

# 安装基本工具
RUN apk add --no-cache curl

# 复制 nginx 配置文件
COPY nginx.conf /etc/nginx/nginx.conf

# 创建网站目录
RUN mkdir -p /usr/share/nginx/html

# 复制网站文件（假设你的网站文件在 src 目录下）
COPY app/ /usr/share/nginx/html/

# 暴露80端口
EXPOSE 7860

# 启动nginx
CMD ["nginx", "-g", "daemon off;"]