#!/bin/bash

set -ex

args=${@:---arch=amd64}

sudo env http_proxy=$http_proxy debootstrap $args jessie $BUILDDIR http://cdn.debian.net/debian
