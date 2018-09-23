#!/usr/bin/env bash
ssh -p 10048 -F ssh.conf -L 6443:localhost:6443 kube@149.156.11.4