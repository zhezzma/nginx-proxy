# 使用官方 nginx 镜像作为基础镜像
FROM nginx:alpine

# 安装基本工具
RUN apk add --no-cache curl

# 创建必要的目录并设置权限
RUN mkdir -p /var/cache/nginx/client_temp \
    && mkdir -p /var/cache/nginx/proxy_temp \
    && mkdir -p /var/cache/nginx/fastcgi_temp \
    && mkdir -p /var/cache/nginx/uwsgi_temp \
    && mkdir -p /var/cache/nginx/scgi_temp \
    && mkdir -p /var/run \
    && mkdir -p /var/log/nginx \
    && mkdir -p /usr/share/nginx/html \
    && touch /var/run/nginx.pid 

# 确保 nginx 用户有权限访问这些目录
RUN chown -R nginx:nginx /var/cache/nginx \
    && chown -R nginx:nginx /var/run \
    && chown -R nginx:nginx /var/log/nginx \
    && chown -R nginx:nginx /usr/share/nginx/html \
    && chown -R nginx:nginx /etc/nginx/conf.d \
    && chown -R nginx:nginx /etc/nginx/conf.d/default.conf \
    && chown -R nginx:nginx /var/run/nginx.pid

RUN chmod -R 755 /var/cache/nginx \
    && chmod -R 755 /var/run \
    && chmod -R 755 /var/log/nginx \
    && chmod -R 755 /usr/share/nginx/html \
    && chmod -R 777 /etc/nginx/conf.d \
    && chmod -R 777 /etc/nginx/conf.d/default.conf \
    && chmod -R 777 /var/run/nginx.pid

# 复制 nginx 配置文件
COPY nginx.conf /etc/nginx/nginx.conf

# 复制网站文件（假设你的网站文件在 app 目录下）
COPY app/ /usr/share/nginx/html/

# 修改配置文件权限
RUN chown -R nginx:nginx /etc/nginx/nginx.conf

# 切换到非 root 用户
USER nginx

# 暴露80端口
EXPOSE 7860

# 启动nginx
CMD ["nginx", "-g", "daemon off;"]