FROM caddy:2.5.1-builder-alpine AS builder
RUN xcaddy build \
	--with github.com/caddy-dns/gandi \
#	--with github.com/greenpau/caddy-auth-jwt \
#	--with github.com/greenpau/caddy-auth-portal \
#	--with github.com/greenpau/caddy-trace \
	--with github.com/lucaslorentz/caddy-docker-proxy/plugin/v2
	# \
	# --with github.com/pyed/ipfilter

FROM alpine:3.11
#EXPOSE 80 443 2019
ENV XDG_CONFIG_HOME /config
ENV XDG_DATA_HOME /data
ARG USER_ID
ARG GROUP_ID
##Exemple pour changer les droits de dossier existant dans le container...
RUN if [ ${USER_ID:-0} -ne 0 ] && [ ${GROUP_ID:-0} -ne 0 ]; then \
	echo "$USER_ID:$GROUP_ID" \
	chemin=/data && [ -d "$chemin" ] && chown -R ${USER_ID}:${GROUP_ID} $chemin || echo "" \
	chemin=/config && [ -d "$chemin" ] && chown -R ${USER_ID}:${GROUP_ID} $chemin || echo "" \
#     userdel -f www-data &&\
#     if getent group www-data ; then groupdel www-data; fi &&\
#     groupadd -g ${GROUP_ID} www-data &&\
#     useradd -l -u ${USER_ID} -g www-data www-data &&\
#     install -d -m 0755 -o www-data -g www-data /home/www-data &&\
#     chown --changes --silent --no-dereference --recursive \
#           --from=33:33 ${USER_ID}:${GROUP_ID} \
#         /home/www-data \
#         /.composer \
#         /var/run/php-fpm \
#         /var/lib/php/sessions \
;fi
RUN apk add --no-cache ca-certificates nss nss-tools
COPY --from=builder /usr/bin/caddy /bin/caddy
ENTRYPOINT [ "/bin/caddy" ]
CMD [ "docker-proxy" ]
