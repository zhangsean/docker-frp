FROM alpine

LABEL MAINTAINER "ZhangSean <zxf2342@qq.com>"

ENV FRP_VERSION=v0.44.0 \
    WEBPROC_VERSION=0.4.0

ADD entrypoint.sh /entrypoint.sh

RUN addgroup -S frp \
 && adduser -D -S -h /var/frp -s /sbin/nologin -G frp frp \
	&& apk add --no-cache --virtual .build-deps curl \
 && curl -fSL -o frp.tar.gz https://github.com/fatedier/frp/releases/download/${FRP_VERSION}/frp_${FRP_VERSION:1}_linux_amd64.tar.gz \
 && tar -zxv -f frp.tar.gz \
 && rm -rf frp.tar.gz \
 && mv frp_*_linux_amd64 /frp \
 && chown -R frp:frp /frp \
 && mv /entrypoint.sh /frp/ \
	&& curl -sL https://github.com/jpillora/webproc/releases/download/v${WEBPROC_VERSION}/webproc_${WEBPROC_VERSION}_linux_amd64.gz | gzip -d - > /usr/local/bin/webproc \
	&& chmod +x /usr/local/bin/webproc \
	&& apk del .build-deps

USER frp

WORKDIR /frp

EXPOSE 6000 7000 8080

CMD ["/frp/entrypoint.sh"]
