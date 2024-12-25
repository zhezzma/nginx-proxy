# 使用官方nginx镜像作为基础镜像
FROM nginx:alpine

# 安装基本工具
RUN apk add --no-cache curl

# 移除默认的nginx配置
RUN rm /etc/nginx/conf.d/default.conf

# 复制自定义的nginx配置
COPY nginx.conf /etc/nginx/conf.d/

# 复制网站文件
COPY ./app /usr/share/nginx/html

# 暴露80端口
EXPOSE 7860

# 启动nginx
CMD ["nginx", "-g", "daemon off;"]