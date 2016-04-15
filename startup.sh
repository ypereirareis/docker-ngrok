#!/usr/bin/env bash

SEPARATOR="--------------------------------------------------------------------------------------"

if [ ! -f bin/ngrokd ]; then
    echo "$SEPARATOR"
    echo "Generating certificate"
    echo "$SEPARATOR"

    cd /root/ngrok/certs
    openssl genrsa -out rootCA.key 2048
    openssl req -x509 -new -nodes -key rootCA.key -subj "/CN=$NGROK_DOMAIN" -days 5000 -out rootCA.pem
    openssl genrsa -out device.key 2048
    openssl req -new -key device.key -subj "/CN=$NGROK_DOMAIN" -out device.csr
    openssl x509 -req -in device.csr -CA rootCA.pem -CAkey rootCA.key -CAcreateserial -out device.crt -days 5000
    cd /root/ngrok

    cp certs/rootCA.pem assets/client/tls/ngrokroot.crt

    echo "$SEPARATOR"
    echo "Building server and client"
    echo "$SEPARATOR"

    make release-server release-client

    chmod +x bin/ngrokd
    chmod +x bin/ngrok

fi

echo "$SEPARATOR"
echo "Starting server"
echo "$SEPARATOR"

cp certs/rootCA.pem assets/client/tls/ngrokroot.crt
bin/ngrokd -tlsKey=certs/device.key -tlsCrt=certs/device.crt -domain="${NGROK_DOMAIN}" -httpAddr=${HTTP_ADDR} -httpsAddr=${HTTPS_ADDR} -tunnelAddr=${TUNNEL_ADDR}


