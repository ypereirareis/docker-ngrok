# Docker Ngrok

Docker image to run ngrok server and generate client

## Server side

### Build

```
make build
```

### Start

```
NGROK_DOMAIN=your.domain.com make start
```

`NGROK_DOMAIN` must be set to the value of your ngrok server domain name.

### Remove/restart

The volumes are properly configured to allow you to stop/remove the container
and start it again... it will work with previously set certificates.

## Client side

### Configuration

```json
$ cat ~/.ngrok 
server_addr: your.domain.com:4443
trust_host_root_certs: false
```

### Client binary

On the server, after run `make start` for the first time, you will find a file called `ngrok` in `bin/` in the cloned project. Just deploy this binary on all your clients.
