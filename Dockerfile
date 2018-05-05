FROM alpine

MAINTAINER ZhangSean <zxf2342@qq.com>

ENV FRP_VERSION 0.18.0

RUN addgroup -S frp \
	&& adduser -D -S -h /var/frp -s /sbin/nologin -G frp frp \
	&& echo "http://mirrors.aliyun.com/alpine/v3.7/main/" > /etc/apk/repositories \
	&& apk add --no-cache curl \
        && curl -fSL https://github.com/fatedier/frp/releases/download/v${FRP_VERSION}/frp_${FRP_VERSION}_linux_amd64.tar.gz -o frp.tar.gz \
	&& tar -zxv -f frp.tar.gz \
	&& mv frp_${FRP_VERSION}_linux_amd64 /frp

ADD entrypoint.sh /frp/entrypoint.sh

RUN chown -R frp:frp /frp

USER frp

WORKDIR /frp

EXPOSE 6000 7000 8000 9000

ENTRYPOINT ["/frp/entrypoint.sh"]
