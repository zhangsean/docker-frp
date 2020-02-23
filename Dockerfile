FROM alpine

MAINTAINER ZhangSean <zxf2342@qq.com>

RUN addgroup -S frp \
 && adduser -D -S -h /var/frp -s /sbin/nologin -G frp frp \
 && apk add --no-cache curl \
 && export FRP_VERSION=$(curl -sSI https://github.com/fatedier/frp/releases/latest | grep -i location | awk -F/ '{print $8}') \
 && curl -fSL https://github.com/fatedier/frp/releases/download/v${FRP_VERSION}/frp_${FRP_VERSION}_linux_amd64.tar.gz -o frp.tar.gz \
 && tar -zxv -f frp.tar.gz \
 && mv frp_${FRP_VERSION}_linux_amd64 /frp

ADD entrypoint.sh /frp/entrypoint.sh

RUN chown -R frp:frp /frp \
 && chmod +x /frp/entrypoint.sh

USER frp

WORKDIR /frp

EXPOSE 6000 7000

ENTRYPOINT ["/frp/entrypoint.sh"]
