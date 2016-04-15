FROM debian:8

MAINTAINER Yannick Pereira-Reis <yannick.pereira.reis@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
ENV TUNNEL_ADDR :4443
ENV HTTP_ADDR :8080
ENV HTTPS_ADDR :4433

RUN apt-get update && apt-get install -y --force-yes --no-install-recommends \
	build-essential \
	ca-certificates \
    nano \
	git \
	mercurial \
	golang \
	ssh \
	openssl \
	&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


RUN git clone https://github.com/inconshreveable/ngrok.git /root/ngrok

RUN mkdir /root/ngrok/certs

ADD ./startup.sh /root/startup.sh
RUN chmod +x /root/startup.sh

WORKDIR /root/ngrok

VOLUME /root/ngrok/certs

CMD ["/root/startup.sh"]

EXPOSE 8080
EXPOSE 4443
EXPOSE 4433