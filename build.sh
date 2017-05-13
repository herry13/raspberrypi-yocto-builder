#!/bin/bash

TARGET=/mnt/build

mkdir -p $TARGET/conf
source /root/poky-morty/oe-init-build-env $TARGET

if [ -f /mnt/local.conf ]; then
  cp -f /mnt/local.conf $TARGET/conf/local.conf
else
  cp -f /root/rpi/meta-rpi/conf/local.conf.sample $TARGET/conf/local.conf
fi

if [ -f /mnt/bblayers.conf ]; then
  cp -f /mnt/bblayers.conf $TARGET/conf/bblayers.conf
else
  cp -f /root/rpi/meta-rpi/conf/bblayers.conf.sample $TARGET/conf/bblayers.conf
fi

touch $TARGET/conf/sanity.conf
cd $TARGET
bitbake console-image
