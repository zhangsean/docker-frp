FROM alpine

LABEL MAINTAINER "ZhangSean <zxf2342@qq.com>"

ENV FRP_VERSION=v0.35.1

ADD entrypoint.sh /entrypoint.sh

RUN addgroup -S frp \
 && adduser -D -S -h /var/frp -s /sbin/nologin -G frp frp \
 && apk add --no-cache curl \
 && curl -fSL https://github.com/fatedier/frp/releases/download/${FRP_VERSION}/frp_${FRP_VERSION:1}_linux_amd64.tar.gz -o frp.tar.gz \
 && tar -zxv -f frp.tar.gz \
 && mv frp_${FRP_VERSION}_linux_amd64 /frp \
 && chown -R frp:frp /frp \
 && mv /entrypoint.sh /frp/

USER frp

WORKDIR /frp

EXPOSE 6000 7000

CMD ["/frp/entrypoint.sh"]
