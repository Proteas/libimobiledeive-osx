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
TEMP_DIR=${CURRENT_DIR}/Temp-x64
DIST_DIR_NAME="_dist-v1.2.0-x64"
DIST_DIR_PATH=${CURRENT_DIR}/${DIST_DIR_NAME}
OSX_SDK_VER="10.9"
SYS_ROOT=`xcodebuild -version -sdk macosx Path`
#----------------------------------------------------------------------------------------#

export CC=clang
export CXX=clang++
export CFLAGS='-Wno-error -fno-omit-frame-pointer'
export CPPFLAGS="-Wno-error -fno-omit-frame-pointer"
export CXXFLAGS="-Wno-error -fno-omit-frame-pointer"
#----------------------------------------------------------------------------------------#

rm -rf ${TEMP_DIR}
mkdir ${TEMP_DIR}
#----------------------------------------------------------------------------------------#

# Begin: libxml2
echo "----------->Processing libxml2..."
cd ${TEMP_DIR}
wget "http://xmlsoft.org/sources/libxml2-2.9.1.tar.gz"
tar xzvf libxml2-2.9.1.tar.gz
cd libxml2-2.9.1
./configure --disable-dependency-tracking --prefix=${DIST_DIR_PATH} --without-python
make install
cd $CURRENT_DIR
#----------------------------------------------------------------------------------------#

# Begin: libtasn1
echo "----------->Processing libtasn1..."
cd ${TEMP_DIR}
wget "http://ftpmirror.gnu.org/libtasn1/libtasn1-3.4.tar.gz"
tar xzvf libtasn1-3.4.tar.gz
cd libtasn1-3.4
./configure --disable-dependency-tracking --prefix=${DIST_DIR_PATH}
make install
cd $CURRENT_DIR
#----------------------------------------------------------------------------------------#

# Begin: config pkg search path
export PKG_CONFIG_PATH=${DIST_DIR_PATH}/lib/pkgconfig:$PKG_CONFIG_PATH
#----------------------------------------------------------------------------------------#

# Begin: libplist
echo "----------->Processing libplist..."
cd ${TEMP_DIR}
wget "http://www.libimobiledevice.org/downloads/libplist-1.12.tar.bz2"
tar xzvf libplist-1.12.tar.bz2
cd libplist-1.12
./configure --disable-dependency-tracking --disable-silent-rules --prefix=${DIST_DIR_PATH}
make install
cd $CURRENT_DIR
#----------------------------------------------------------------------------------------#

# Begin: libusb
echo "----------->Processing libusb..."
cd ${TEMP_DIR}
wget "https://downloads.sourceforge.net/project/libusb/libusb-1.0/libusb-1.0.19/libusb-1.0.19.tar.bz2"
tar xzvf libusb-1.0.19.tar.bz2
cd libusb-1.0.19
export CC=clang
./configure --disable-dependency-tracking --prefix=${DIST_DIR_PATH} --with-sysroot=${SYS_ROOT}
make install
unset CC
cd $CURRENT_DIR
#----------------------------------------------------------------------------------------#

# Begin: libusbmuxd
echo "----------->Processing usbmuxd..."
cd ${TEMP_DIR}
wget "http://www.libimobiledevice.org/downloads/libusbmuxd-1.0.10.tar.bz2"
tar xzvf libusbmuxd-1.0.10.tar.bz2
cd libusbmuxd-1.0.10
./configure --disable-dependency-tracking --disable-silent-rules --prefix=${DIST_DIR_PATH}
make install
cd $CURRENT_DIR
#----------------------------------------------------------------------------------------#

# Begin: openssl
echo "----------->Processing openssl..."
cd ${TEMP_DIR}
wget "https://www.openssl.org/source/openssl-1.0.1h.tar.gz"
tar xzvf openssl-1.0.1h.tar.gz
cd openssl-1.0.1h
./Configure --prefix=${DIST_DIR_PATH} --openssldir=${DIST_DIR_PATH}/openssl zlib-dynamic shared enable-cms darwin64-x86_64-cc enable-ec_nistp-64_gcc_128
make depend
make install
cd $CURRENT_DIR
#----------------------------------------------------------------------------------------#

# Begin: libimobiledevice
echo "----------->Processing libimobiledevice..."
cd ${TEMP_DIR}
wget "http://www.libimobiledevice.org/downloads/libimobiledevice-1.2.0.tar.bz2"
tar xzvf libimobiledevice-1.2.0.tar.bz2
cd libimobiledevice-1.2.0
./configure --disable-dependency-tracking --disable-silent-rules --prefix=${DIST_DIR_PATH} --without-cython
make install
cd $CURRENT_DIR
#----------------------------------------------------------------------------------------#

# Begin: libzip
echo "----------->Processing libzip..."
cd ${TEMP_DIR}
wget "http://www.nih.at/libzip/libzip-0.11.2.tar.gz"
tar xzvf libzip-0.11.2.tar.gz
cd libzip-0.11.2
./configure --prefix=${DIST_DIR_PATH} --mandir=${DIST_DIR_PATH}/share/man
make install
cd $CURRENT_DIR
#----------------------------------------------------------------------------------------#

# Begin: ideviceinstaller
echo "----------->Processing ideviceinstaller..."
cd ${TEMP_DIR}
wget "http://www.libimobiledevice.org/downloads/ideviceinstaller-1.1.0.tar.bz2"
tar xzvf ideviceinstaller-1.1.0.tar.bz2
cd ideviceinstaller-1.1.0
./configure --disable-dependency-tracking --prefix=${DIST_DIR_PATH}
make install
cd $CURRENT_DIR
#----------------------------------------------------------------------------------------#

# Begin: libideviceactivation
echo "----------->Processing libideviceactivation..."
cd ${TEMP_DIR}
wget "http://www.libimobiledevice.org/downloads/libideviceactivation-1.0.0.tar.bz2"
tar xzvf libideviceactivation-1.0.0.tar.bz2
cd libideviceactivation-1.0.0
./configure --disable-dependency-tracking --prefix=${DIST_DIR_PATH}
make install
cd $CURRENT_DIR
#----------------------------------------------------------------------------------------#

# # Begin: osxfuse
# echo "----------->Processing osxfuse..."
# cd ${TEMP_DIR}
# git clone --recursive https://github.com/osxfuse/osxfuse.git osxfuse-2.7.5
# cd osxfuse-2.7.5
# git checkout tags/osxfuse-2.7.5
# ./build.sh -t homebrew -f ${DIST_DIR_PATH}
# cd $CURRENT_DIR
# #----------------------------------------------------------------------------------------#
#
# # Begin: ifuse
# echo "----------->Processing ifuse..."
# cd ${TEMP_DIR}
# wget "http://www.libimobiledevice.org/downloads/ifuse-1.1.3.tar.bz2"
# tar xzvf ifuse-1.1.3.tar.bz2
# cd ifuse-1.1.3
# ./configure --disable-dependency-tracking --prefix=${DIST_DIR_PATH}
# make install
# unset CFLAGS
# unset CPPFLAGS
# cd $CURRENT_DIR
# #----------------------------------------------------------------------------------------#
#
# # Begin: libirecovery
# echo "----------->Processing libirecovery..."
# cd ${TEMP_DIR}
# git clone https://github.com/libimobiledevice/libirecovery.git
# cd libirecovery
# ./autogen.sh
# ./configure --disable-dependency-tracking --prefix=${DIST_DIR_PATH}
# make install
# cd $CURRENT_DIR
# #----------------------------------------------------------------------------------------#
#
# # Begin: idevicerestore
# echo "----------->Processing idevicerestore..."
# cd ${TEMP_DIR}
# git clone https://github.com/libimobiledevice/idevicerestore.git
# cd idevicerestore
# ./autogen.sh
# ./configure --disable-dependency-tracking --prefix=${DIST_DIR_PATH}
# make install
# cd $CURRENT_DIR
# #----------------------------------------------------------------------------------------#

echo ""
echo "-------->Success<--------"
echo ""
