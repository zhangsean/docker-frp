# frp

A fast reverse proxy to help you expose a local server behind a NAT or firewall to the internet.

Docker image for [fatedier/frp](https://github.com/fatedier/frp).

[![DockerHub Badge](http://dockeri.co/image/zhangsean/frp)](https://hub.docker.com/r/zhangsean/frp/)

## Example Usage

### frp Server

Start a frp server with connection port `7000` and reverse proxy port `6000`, expose `6000` and `7000` ports in your internet firewall or load balancer which resole `frp.example.com` to.

```sh
docker run -itd --name frps -p 7000:7000 -p 6000:6000 zhangsean/frp
```

#### frp Client

Start a frp client, expose local port `22` of server `192.168.1.20` to remote port `6000` of server `frp.example.com`.

```sh
docker run -itd --name frpc -e MODE=client -e SERVER_ADDR=frp.example.com -e SERVER_PORT=7000 -e PROTO=tcp -e LOCAL_IP=192.168.1.20 -e LOCAL_PORT=22 -e REMOTE_PORT=6000 zhangsean/frp
```

Then you can ssh to `frp.example.com:6000` from internet, just like directly ssh to your server `192.168.1.20:22` from internal.

```sh
ssh -p 6000 root@frp.example.com
```

## Environment variables

Name | Type | Default | Description
-|-|-|-
MODE | server or client | server | running model
BIND_PORT | Port | 7000 | server bind port
PROXY_NAME | String | ssh | proxy name, unique name is required in same server.
SERVER_PORT | Port | 7000 | remote server port
PROTO | tcp / udp / http / https / stcp / xtcp | tcp | local proto
LOCAL_IP | IP | 127.0.0.1 | local server IP
LOCAL_PORT | Port | 22 | local service port
REMOTE_PORT | Port | 6000 | remote reverse port

## Find more

Please visit [fatedier/frp](https://github.com/fatedier/frp) for more.
