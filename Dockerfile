# Pull base image
#FROM resin/armv6-debian:jessie
FROM resin/raspberry-pi-debian:latest

# Pull down mosquitto for this distro via wget
RUN apt-get update && apt-get install -y wget
RUN wget -q -O - http://repo.mosquitto.org/debian/mosquitto-repo.gpg.key | apt-key add -
RUN wget -q -O /etc/apt/sources.list.d/mosquitto-jessie.list http://repo.mosquitto.org/debian/mosquitto-jessie.list
RUN apt-get install -y --force-yes apt-transport-https 
RUN apt-get update && apt-get install -y --force-yes mosquitto mosquitto-clients

RUN adduser --system --disabled-password --disabled-login mosquitto
RUN adduser mosquitto daemon

COPY config /mqtt/config
VOLUME ["/mqtt/config", "/mqtt/data", "/mqtt/log"]

EXPOSE 1883 9001
CMD /usr/sbin/mosquitto -c /mqtt/config/mosquitto.conf
