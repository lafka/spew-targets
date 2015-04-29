#!/bin/bash

set -ex

env

RIAK_VSN=2.0.5-1
RIAK_MAJOR=2.0
RIAK_MINOR=2.0.5
RIAK_ARCH=amd64
RIAK_FILE=riak_${RIAK_VSN}_${RIAK_ARCH}.deb

# "import" debian
if [ ! -d "$BUILDROOT/debian/jessie" ]; then
	echo "error: debian/jessie is not buildt..."
fi
if [ ! -f "$BUILDROOT/debian/jessie/buildt" ]; then
	echo "error: debian/jessie was not successfully buildt"
fi

# "include" debian
$SRCDIR/../../debian/jessie/build.sh --include sudo,openjdk-7-jre-headless

tmpdir=$(mktemp -d)
curl -o "$tmpdir/$RIAK_FILE" http://s3.amazonaws.com/downloads.basho.com/riak/${RIAK_MAJOR}/${RIAK_MINOR}/debian/7/$RIAK_FILE
cp "$SRCDIR/files.sha" $tmpdir
cd $tmpdir
/usr/bin/core_perl/shasum -c < files.sha

cp $tmpdir/riak_2.0.5-1_amd64.deb $BUILDDIR/
rm -rf $tmpdir
sudo chroot $BUILDDIR dpkg -i $RIAK_FILE
sudo chroot $BUILDDIR apt-get clean
sudo rm $BUILDDIR/$RIAK_FILE

sudo chroot /tmp/builds/riak/2.0.5 /bin/bash -c "echo root:rootsgrowintheground | chpasswd"
sudo chroot $BUILDDIR systemctl enable riak

rsync -avh $SRCDIR/files/ $BUILDDIR