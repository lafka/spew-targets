#!/bin/bash

set -ex

chown riak:riak /var/{lib,log}/riak

# Java fucktards needs r/w access to unpack it's jar, put it in tmpfs
cp -r /usr/lib/riak/lib /tmp/riaklib
ln -sf /tmp/riaklib /usr/lib/riak/lib

exec su riak -c '/usr/sbin/riak console'
