#!/bin/bash
# 
# script to locally test launching this image

HOST_MQTT_DIR=/srv/mqtt

if [ ! -e $HOST_MQTT_DIR ]; then
    sudo mkdir -p $HOST_MQTT_DIR/config/conf.d
    sudo mkdir $HOST_MQTT_DIR/log
    sudo mkdir $HOST_MQTT_DIR/data
    sudo mkdir $HOST_MQTT_DIR/config
    sudo chown -R $USER $HOST_MQTT_DIR
    sudo chgrp -R daemon $HOST_MQTT_DIR
    sudo chmod -R g+rw $HOST_MQTT_DIR
fi

# Update conf
cp config/mosquitto.conf $HOST_MQTT_DIR/config/

docker run -p 1883:1883 -p 9001:9001 \
  -v $HOST_MQTT_DIR/config:/mqtt/config:ro \
  -v $HOST_MQTT_DIR/log:/mqtt/log \
  -v $HOST_MQTT_DIR/data/:/mqtt/data/ \
  --name mqtt-broker \
  --rm \
  lerebel103/rpi-mosquitto:latest

