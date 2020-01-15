#!/bin/bash

ssh-keygen -N '' -f ~/.ssh/id_rsa <<< y
ssh-copy-id -i ~/.ssh/id_rsa.pub 192.168.0.1 #change the IP address to the remote-host IP address
