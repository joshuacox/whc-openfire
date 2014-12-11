FROM joshuacox/docker-openfire
MAINTAINER Josh Cox "josh at webhosting coop"

ADD start /start
RUN chmod 755 /start

EXPOSE 3478
EXPOSE 3479
EXPOSE 5222
EXPOSE 5223
EXPOSE 5229
EXPOSE 7070
EXPOSE 7443
EXPOSE 7777
EXPOSE 9090
EXPOSE 9091

# Octo host magic variables
# NO_HTTP_PROXY
# MOUNT_FROM_HOST /exports/whc-openfire/etc/openfire /etc/openfire
# MOUNT_FROM_HOST /exports/whc-openfire/lib/openfire /var/lib/openfire
# PORTS_FROM_HOST 3478 3478
# PORTS_FROM_HOST 3479 3479
# PORTS_FROM_HOST 5222 5222
# PORTS_FROM_HOST 5223 5223
# PORTS_FROM_HOST 5229 5229
# PORTS_FROM_HOST 7070 7070
# PORTS_FROM_HOST 7443 7443
# PORTS_FROM_HOST 7777 7777
# PORTS_FROM_HOST 9090 9090
# PORTS_FROM_HOST 9091 9091
# PORTS_FROM_HOST 9999 9999
# End Octo magic variables

VOLUME ["/etc/openfire"]
VOLUME ["/var/lib/openfire"]
CMD ["/start"]
