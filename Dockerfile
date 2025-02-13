FROM debian:10.6-slim

LABEL maintainer "cdchris12, cdchris12@gmail.com" 

ARG UID=${UID:-1001}
ARG GID=${GID:-1001}

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
                    nginx \
                    nginx-extras \
                    libnginx-mod-http-fancyindex \
                    apache2-utils && \
                    rm -rf /var/lib/apt/lists

RUN usermod -u $UID www-data && groupmod -g $GID www-data

VOLUME /media
EXPOSE 80

COPY webdav.conf /etc/nginx/conf.d/default.conf
RUN rm /etc/nginx/sites-enabled/*

COPY entrypoint.sh /
RUN chmod +x entrypoint.sh

CMD /entrypoint.sh && nginx -g "daemon off;"
