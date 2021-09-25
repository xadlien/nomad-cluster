#!/bin/bash

IP=$(ip addr | grep 192.168.50 | sed -n 's/.*\(192.168.50..\)\/.*/\1/p')

sed -i "s/#IP#/${IP}/g" /etc/profile.d/nomad.sh
sed -i "s/#IP#/${IP}/g" /etc/nomad.d/nomad.hcl
