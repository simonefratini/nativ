#!/bin/bash
NATIV_PATH=nativ.sh
NATIV_PATH=$(which $NATIV_PATH)
if [ -z "$NATIV_PATH" ]; then
    echo "Missing $NATIV_PATH"
    exit 1;
fi
#
PACKAGE_NAME=nativ
VERSION="1.0.0"
# debian skeleton 
CONTROL_SKELETON=control.skeleton
CONTROL_BUILD=$(mktemp)
sed -e "s/^\(Version: \)\(.*\)/\1$VERSION/g" $CONTROL_SKELETON  > $CONTROL_BUILD 
mkdir -vp $PACKAGE_NAME/DEBIAN
cp $CONTROL_BUILD $PACKAGE_NAME/DEBIAN/control
# binary relative path 
cp -v --parents $NATIV_PATH $PACKAGE_NAME
dpkg-deb --build $PACKAGE_NAME
# remove if package is done
if [ -f $PACKAGE_NAME.deb ]; then
    rm -vrf $PACKAGE_NAME
fi
# mostra info del pacchetto
dpkg-deb --info $PACKAGE_NAME.deb 

