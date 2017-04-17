#!/bin/bash

touch /tmp/Recent.xyz

while true
do
    echo "Checking again..."
    wget -q https://apt.dockerproject.org/repo/dists/ubuntu-xenial/main/binary-amd64/Release -O /tmp/Release.xyz
    if test /tmp/Release.xyz -nt Recent.xyz; then
        mplayer /usr/share/sounds/ubuntu/stereo/phone-incoming-call.ogg
    fi
    sleep 5;

done
