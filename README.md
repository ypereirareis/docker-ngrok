# Docker Ngrok

Docker image to run ngrok server


## Build

```
docker build -t ypereirareis/ngrok .
```

## Start

```
docker run -it -d --name=ngrok \
    -p 4433:4433 -p 8080:8080 -p 4443:4443 \
    -e NGROK_DOMAIN=ngrok.domain.fr \
    -v `pwd`/bin:/root/ngrok/bin \
        ypereirareis/ngrok
```
