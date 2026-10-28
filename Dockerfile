FROM nginxinc/nginx-unprivileged:alpine
ARG APP_VERSION=v1
ARG THEME=blue
COPY site/ /usr/share/nginx/html/
USER 0
RUN sed -i "s/__VERSION__/${APP_VERSION}/g; s/__THEME__/${THEME}/g" /usr/share/nginx/html/*.html
USER 101
EXPOSE 8080
