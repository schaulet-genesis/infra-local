# This is a minimal set of ANSI/VT100 color codes
_END=$'\x1b[0m'
_BOLD=$'\x1b[1m'
_UNDER=$'\x1b[4m'
_REV=$'\x1b[7m'

# Colors
_GREY=$'\x1b[30m'
_RED=$'\x1b[31m'
_GREEN=$'\x1b[32m'
_YELLOW=$'\x1b[33m'
_BLUE=$'\x1b[34m'
_PURPLE=$'\x1b[35m'
_CYAN=$'\x1b[36m'
_WHITE=$'\x1b[37m'

# Inverted, i.e. colored backgrounds
_IGREY=$'\x1b[40m'
_IRED=$'\x1b[41m'
_IGREEN=$'\x1b[42m'
_IYELLOW=$'\x1b[43m'
_IBLUE=$'\x1b[44m'
_IPURPLE=$'\x1b[45m'
_ICYAN=$'\x1b[46m'
_IWHITE=$'\x1b[47m'

log_success = (echo -e "${_GREEN}>> $1${_END}")
log_error = (>&2 echo -e "\x1B[31m>> $1\x1B[39m" && exit 1)

_APP_FOLDER=$(strip $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST)))))


.PHONY: help install serve deploy clean create-traefik-network-once up down edit dev
.ONESHELL:
.DEFAULT_GOAL := help

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; { \
		goal=$$1; \
		split($$2,lines,"@@@");for (i in lines){  \
			printf "\033[36m%-30s\033[0m %s\n", goal, lines[i]; \
			goal=""; \
		} \
		}'

net: |  ## Construit l'image docker en local
	docker network create web

build: |  ## Construit l'image docker en local
	docker compose build

start: | ## Demarre l'infra necessaire
	docker compose up -d 

stop: | ## Arrete l'infra necessaire
	docker compose stop

dev: | stop build start ## Demarre la stack et affiche les logs
	docker compose logs -f

rebuild-dns: | ## rebuild, restart and show dns logs
	docker compose stop dns
	docker compose build dns
	docker compose up -d 
	docker compose logs -f dns 