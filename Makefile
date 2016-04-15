.PHONY: build build-no-cache up start stop restart state remove bash log


# VARIABLES
# --------------------------------------------------------
compose=docker-compose
version=latest
image=ypereirareis/ngrok

# TARGETS
# --------------------------------------------------------
build:
	docker build -t $(image):$(version) .

build-no-cache:
	docker build -t $(image):$(version) --no-cache .

up:
	@echo "== START =="
	$(compose) up -d ngrok

start: up

stop:
	@echo "== STOP =="
	@$(compose) stop

restart: start

state:
	@echo "== STATE =="
	@$(compose) ps

remove: stop
	@echo "== REMOVE =="
	@$(compose) rm --force

bash:
	@echo "== BASH =="
	@$(compose) run --rm ngrok bash

log:
	@$(compose) logs ngrok