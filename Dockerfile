# Pull base image
FROM resin/raspberry-pi-debian:latest

# Pull down mosquitto for this distro via wget
RUN apt-get update && apt-get install -y wget
RUN apt-get install -y --force-yes build-essential cmake libwrap0-dev uuid-dev libc-ares-dev

# Compile openssl
RUN wget https://github.com/openssl/openssl/archive/OpenSSL_1_1_1.tar.gz
RUN tar xvzf OpenSSL_1_1_1.tar.gz
RUN cd openssl-* && ./config && make install

# libwebsockets
RUN cd /tmp && wget https://github.com/warmcat/libwebsockets/archive/v3.0.1.tar.gz && tar xvzf v3.0.1.tar.gz
RUN cd /tmp/libwebsockets-3.0.1 && mkdir build && cd build && cmake .. && make install

# Now for mosquitto
RUN cd /tmp && wget https://mosquitto.org/files/source/mosquitto-1.5.3.tar.gz && tar xvxf mosquitto-1.5.3.tar.gz
RUN cd mosquitto-1.5.3 && make WITH_WEBSOCKETS=yes && make install

RUN adduser --system --disabled-password --disabled-login mosquitto
RUN adduser mosquitto daemon

COPY config /mqtt/config
VOLUME ["/mqtt/config", "/mqtt/data", "/mqtt/log"]

EXPOSE 1883 9001
CMD /usr/sbin/mosquitto -c /mqtt/config/mosquitto.conf
