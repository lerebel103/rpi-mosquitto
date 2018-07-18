# rpi-mosquitto

Raspberry Pi3 compatible Docker Image based on `resin/armv7hf-debian:stretch` with mosquitto MQTT broker.
Based upon [rpi-mosquitto](https://github.com/pascaldevink/rpi-mosquitto), all credit to @pascaldevink.

## How to run

```
docker run -tip 1883:1883 -p 9001:9001 lerebel103/rpi-mosquitto
```

Exposes Port 1883 (MQTT) 9001 (Websocket MQTT)

Alternatively you can use volumes to make the changes persistent and change the configuration. A start script is provided as `bin/mosquitto.sh` to do just that a faciliated testing.

## How to create this image

Run all the commands from within the project root directory.

### Docker version requirements
Please make sure you have a rececent version of docker.io installed:
```
curl -sSL https://get.docker.com | sh
```

### Build the Docker Image
```bash
make build
```

#### Push the Docker Image to the Docker Hub
* First use a `docker login` with username, password and email address
* Second push the Docker Image to the official Docker Hub

### Testing
You can easily test that the broker works correctly by starting it and using two test clients as publisher and subscriber respectively.

In a first terminal:
```
# Start the broker
./bin/mosquitto.sh
```

In a second Terminal:
```
# Start a subscriber client on "test" topic
docker run -it --rm lerebel103/rpi-mosquitto mosquitto_sub -h <host ip> -t test
```
In a third Terminal:
```
# Start a publish client on "test" topic, sending "Hello There!"
docker run -it --rm lerebel103/rpi-mosquitto mosquitto_pub -h <host ip> -t test -m "Hello There!"
```

All going well, your subscriber receive the published message.


```bash
make push
```

## License

The MIT License (MIT)

Copyright (c) 2015 Pascal de Vink

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
