FROM joshuacox/docker-openfire
MAINTAINER Josh Cox "josh at webhosting coop"

# ADD openfire_3.9.3_all.deb /tmp/
#RUN cd /; wget -c http://www.igniterealtime.org/downloadServlet?filename=openfire/openfire_3.9.3_all.deb -O openfire_3.9.3_all.deb
#RUN dpkg -i /openfire_3.9.3_all.deb
#RUN chown -R openfire:openfire /etc/openfire /var/lib/openfire

ADD docker.conf /etc/supervisor/conf.d/
ADD start /start
#ADD etc /etc/openfire
RUN chmod 755 /start
# NO_HTTP_PROXY
# MOUNT_FROM_HOST /exports/whc-openfire/etc /etc/openfire
# MOUNT_FROM_HOST /exports/whc-openfire/lib /var/lib/openfire
# dontMOUNT_FROM_HOST /home/git/src/docker-openfire.git/lib /var/lib/openfire
# PORTS_FROM_HOST 7777 7777
# PORTS_FROM_HOST 5222 5222
# PORTS_FROM_HOST 5223 5223
# PORTS_FROM_HOST 9091 9091
# PORTS_FROM_HOST 9090 9090
# PORTS_FROM_HOST 5269 5269
# PORTS_FROM_HOST 9999 9999
VOLUME ["/etc/openfire"]
VOLUME ["/var/lib/openfire"]

EXPOSE 9090 9091 5222 5223 5269 9999

#CMD ["/bin/bash"]
ENTRYPOINT ["/bin/bash", "/start"]
