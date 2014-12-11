DOCKER_TAG=openfire
CONTAINER=openfire
# Uncomment this to background the container
DAEMON=-d
# File sharing proxy port
PORTS=-p 0.0.0.0:7777:7777 -p 0.0.0.0:5222:5222 -p 0.0.0.0:9090:9090 -p 0.0.0.0:9091:9091 -p 0.0.0.0:5269:5269 -p 0.0.0.0:9999:9999
PORTS := -p 0.0.0.0:3478:3478 $(PORTS)
PORTS := -p 0.0.0.0:3479:3479 $(PORTS)
PORTS := -p 0.0.0.0:5223:5223 $(PORTS)
PORTS := -p 0.0.0.0:5229:5229 $(PORTS)
PORTS := -p 0.0.0.0:7070:7070 $(PORTS)
PORTS := -p 0.0.0.0:7443:7443 $(PORTS)
PWD = $(shell pwd)

all: help

echo:
	echo $(PORTS)

help:
	@echo ""
	@echo "-- Help Menu"
	@echo ""
	@echo "   1. make build       - build the postgresql image"
	@echo "   2. make clean  - cleanup"

build: build-docker

oltorf: build-docker beep

#clean: cleanvendor cleanbuilds
clean: cleanbuilds

build-docker:
	@echo "build-docker"
	/usr/bin/time -v docker build -t $(DOCKER_TAG) .

rund:
	docker run $(DAEMON) $(PORTS) --name openfire -v $(PWD)/lib:/var/lib/openfire -v $(PWD)/etc:/etc/openfire --cidfile="cid" $(CONTAINER)

run:
	docker run $(PORTS) --name openfire -v $(PWD)/lib:/var/lib/openfire -v $(PWD)/etc:/etc/openfire --cidfile="cid" $(CONTAINER)

runti:
	docker run $(PORTS) -t -i --name openfire -v $(PWD)/lib:/var/lib/openfire -v $(PWD)/etc:/etc/openfire --cidfile="cid" $(CONTAINER)

runv:
	docker run $(PORTS) --name openfire -v $(PWD)/lib:/var/lib/openfire --cidfile="cid" $(CONTAINER)

enter:
	 docker exec -i -t `cat cid` /bin/bash

kill:
	 docker kill `cat cid`

rm:
	 docker kill `cat cid`
	 docker rm `cat cid`
	 rm cid

vendor: openfire_3.9.3_all.deb

openfire_3.9.3_all.deb:
	wget -c http://www.igniterealtime.org/downloadServlet?filename=openfire/openfire_3.9.3_all.deb -O openfire_3.9.3_all.deb

cleanbuilds:
	@echo "cleaning Builds"
	docker rm `docker ps -a -q`
	docker rmi -f `docker images -q`

beep:
	@echo "beep"
	@aplay /usr/share/sounds/alsa/Front_Center.wav
# @ogg123 /usr/share/sounds/KDE-Im-Irc-Event.ogg

cleanvendor:
	@echo "cleanvendor"
	rm -r vendor
	rm Berksfile.lock

vendor-cookbooks:
	@echo "vendor"
	berks vendor vendor/cookbooks
