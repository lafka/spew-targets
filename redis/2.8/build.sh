#!/bin/bash

# "import" debian
$SRCDIR/../../debian/jessie/build.sh --include redis-server

rsync -avh $SRCDIR/files/ $BUILDDIR
