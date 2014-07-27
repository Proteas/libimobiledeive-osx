#!/bin/bash
set -e

# Begin: check depends
brew install autoconf
brew install automake
brew install libtool
brew install pkg-config
#----------------------------------------------------------------------------------------#

# Begin: define vars
CURRENT_DIR=`pwd`
DIST_DIR_NAME="_dist-v1.1.6"
DEVELOPER_DIR=`"xcode-select" --print-path`
OSX_SDK_VER="10.8"
SYS_ROOT=$DEVELOPER_DIR/Platforms/MacOSX.platform/Developer/SDKs/MacOSX$OSX_SDK_VER.sdk
#----------------------------------------------------------------------------------------#

# Begin: libxml2
echo "Processing libxml2..."
wget "http://xmlsoft.org/sources/libxml2-2.9.1.tar.gz"
tar xzvf libxml2-2.9.1.tar.gz
cd libxml2-2.9.1
./configure --disable-dependency-tracking --prefix=$CURRENT_DIR/$DIST_DIR_NAME --without-python
make install
cd $CURRENT_DIR
#----------------------------------------------------------------------------------------#

# Begin: libtasn1
echo "Processing libtasn1..."
wget "http://ftpmirror.gnu.org/libtasn1/libtasn1-3.4.tar.gz"
tar xzvf libtasn1-3.4.tar.gz
cd libtasn1-3.4
./configure --disable-dependency-tracking --prefix=$CURRENT_DIR/$DIST_DIR_NAME
make install
cd $CURRENT_DIR
#----------------------------------------------------------------------------------------#

# Begin: config pkg search path
export PKG_CONFIG_PATH=$CURRENT_DIR/$DIST_DIR_NAME/lib/pkgconfig
#----------------------------------------------------------------------------------------#

# Begin: libplist
echo "Processing libplist..."
wget "http://www.libimobiledevice.org/downloads/libplist-1.11.tar.bz2"
tar xzvf libplist-1.11.tar.bz2
cd libplist-1.11
./configure --disable-dependency-tracking --disable-silent-rules --prefix=$CURRENT_DIR/$DIST_DIR_NAME
make install
cd $CURRENT_DIR
#----------------------------------------------------------------------------------------#

# Begin: libusb
echo "Processing libusb..."
wget "https://downloads.sourceforge.net/project/libusb/libusb-1.0/libusb-1.0.19/libusb-1.0.19.tar.bz2"
tar xzvf libusb-1.0.19.tar.bz2
cd libusb-1.0.19
export CC=clang
./configure --disable-dependency-tracking --prefix=$CURRENT_DIR/$DIST_DIR_NAME --with-sysroot=$SYS_ROOT
make install
unset CC
cd $CURRENT_DIR
#----------------------------------------------------------------------------------------#

# Begin: libusbmuxd
echo "Processing usbmuxd..."
wget "http://www.libimobiledevice.org/downloads/libusbmuxd-1.0.9.tar.bz2"
tar xzvf libusbmuxd-1.0.9.tar.bz2
cd libusbmuxd-1.0.9
./configure --disable-dependency-tracking --disable-silent-rules --prefix=$CURRENT_DIR/$DIST_DIR_NAME
make install
cd $CURRENT_DIR
#----------------------------------------------------------------------------------------#

# Begin: openssl
echo "Processing openssl..."
wget "https://www.openssl.org/source/openssl-1.0.1h.tar.gz"
tar xzvf openssl-1.0.1h.tar.gz
cd openssl-1.0.1h
./Configure --prefix=$CURRENT_DIR/$DIST_DIR_NAME --openssldir=$CURRENT_DIR/$DIST_DIR_NAME/openssl zlib-dynamic shared enable-cms darwin64-x86_64-cc enable-ec_nistp-64_gcc_128
make depend
make install
cd $CURRENT_DIR
#----------------------------------------------------------------------------------------#

# Begin: libimobiledevice
echo "Processing libimobiledevice..."
wget "http://www.libimobiledevice.org/downloads/libimobiledevice-1.1.6.tar.bz2"
tar xzvf libimobiledevice-1.1.6.tar.bz2
cd libimobiledevice-1.1.6
./configure --disable-dependency-tracking --disable-silent-rules --prefix=$CURRENT_DIR/$DIST_DIR_NAME --without-cython
make install
cd $CURRENT_DIR
#----------------------------------------------------------------------------------------#

# Begin: libzip
echo "Processing libzip..."
wget "http://www.nih.at/libzip/libzip-0.11.2.tar.gz"
tar xzvf libzip-0.11.2.tar.gz
cd libzip-0.11.2
./configure --prefix=$CURRENT_DIR/$DIST_DIR_NAME --mandir=$CURRENT_DIR/$DIST_DIR_NAME/share/man
make install
cd $CURRENT_DIR
#----------------------------------------------------------------------------------------#

# Begin: ideviceinstaller
echo "Processing ideviceinstaller..."
wget "http://www.libimobiledevice.org/downloads/ideviceinstaller-1.0.1.tar.bz2"
tar xzvf ideviceinstaller-1.0.1.tar.bz2
cd ideviceinstaller-1.0.1
export CFLAGS="-Wno-error"
export CPPFLAGS="-Wno-error"
./configure --disable-dependency-tracking --prefix=$CURRENT_DIR/$DIST_DIR_NAME
make install
unset CFLAGS
unset CPPFLAGS
cd $CURRENT_DIR
#----------------------------------------------------------------------------------------#

# Begin: libirecovery
echo "Processing libirecovery..."
git clone https://github.com/libimobiledevice/libirecovery.git
cd libirecovery
./autogen.sh
./configure --disable-dependency-tracking --prefix=$CURRENT_DIR/$DIST_DIR_NAME
make install
cd $CURRENT_DIR
#----------------------------------------------------------------------------------------#

# Begin: idevicerestore
echo "Processing idevicerestore..."
git clone https://github.com/libimobiledevice/idevicerestore.git
cd idevicerestore
./autogen.sh
./configure --disable-dependency-tracking --prefix=$CURRENT_DIR/$DIST_DIR_NAME
make install
cd $CURRENT_DIR
#----------------------------------------------------------------------------------------#

echo ""
echo "-------->Success<--------"
echo ""
