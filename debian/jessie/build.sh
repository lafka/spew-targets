#!/bin/bash

set -ex

args=${@:---arch=amd64}

sudo http_proxy=http://172.20.0.1:8000 debootstrap $args jessie $BUILDDIR http://cdn.debian.net/debian
