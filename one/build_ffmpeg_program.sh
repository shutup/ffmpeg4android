#!/bin/bash
######################################################
# Usage:
# put this script in top of FFmpeg source tree
# ./build_android
# It generates binary for following architectures:
# ARMv6 
# ARMv6+VFP 
# ARMv7+VFPv3-d16 (Tegra2) 
# ARMv7+Neon (Cortex-A8)
# Customizing:
# 1. Feel free to change ./configure parameters for more features
# 2. To adapt other ARM variants
# set $CPU and $OPTIMIZE_CFLAGS 
# call build_one
######################################################
NDK=/Users/shutup/Library/Android/sdk/ndk-bundle
PLATFORM=$NDK/platforms/android-9/arch-arm/
PREBUILT=$NDK/toolchains/arm-linux-androideabi-4.9/prebuilt/darwin-x86_64
SRC_PATH=/Users/shutup/Documents/player/player_libs/source/ffmpeg-3.3.3
NEED_LIBS_PATH=/Users/shutup/Documents/player/player_libs/build/android/arm
#export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:$NEED_LIBS_PATH/lib/pkgconfig

#if add PIE
OPEN_PIE=1

function build_one
{
./configure --target-os=linux \
    --prefix=$PREFIX \
    --enable-cross-compile \
    --arch=arm \
    --cc=$PREBUILT/bin/arm-linux-androideabi-gcc \
    --cross-prefix=$PREBUILT/bin/arm-linux-androideabi- \
    --nm=$PREBUILT/bin/arm-linux-androideabi-nm \
    --sysroot=$PLATFORM \
	--enable-gpl \
    --enable-version3 \
	--enable-nonfree \
    --extra-libs="-lgcc -lc -lm -ldl -llog " \
    --extra-cflags="-I$NEED_LIBS_PATH/include -O3  $EXTRA_PIE_FLAG  $OPTIMIZE_CFLAGS " \
    --extra-ldflags="$EXTRA_PIE_FLAG -L$NEED_LIBS_PATH/lib" \
    --disable-shared \
    --enable-static \
	--enable-pic \
    --disable-doc \
    --enable-decoders \
    --enable-encoders \
	--enable-muxers \
    --enable-demuxers \
    --enable-parsers \
    --enable-protocols \
    --enable-filters \
    --enable-avresample \
	--disable-devices \
    --enable-zlib \
    $ADDITIONAL_CONFIGURE_FLAG
make clean
make -j 4
make install
}

#arm v6
#CPU=armv6
#OPTIMIZE_CFLAGS="-marm -march=$CPU"
#PREFIX=./android/$CPU 
#ADDITIONAL_CONFIGURE_FLAG=
#build_one

#arm v7vfpv3
#CPU=armv7-a
#OPTIMIZE_CFLAGS="-mfloat-abi=softfp -mfpu=vfpv3-d16 -marm -march=$CPU "
#PREFIX=./android/$CPU
#ADDITIONAL_CONFIGURE_FLAG=
#build_one

#arm v7vfp
#CPU=armv7-a
#OPTIMIZE_CFLAGS="-mfloat-abi=softfp -mfpu=vfp -marm -march=$CPU "
#PREFIX=./android/$CPU-vfp
#ADDITIONAL_CONFIGURE_FLAG=
#build_one

#arm v7n
#CPU=armv7-a
#OPTIMIZE_CFLAGS="-mfloat-abi=softfp -mfpu=vfpv3-d16 -marm -march=armv7-a -mthumb -D__thumb__"
#PREFIX=/Users/shutup/Documents/player/3rd_libs/build/android/arm
#ADDITIONAL_CONFIGURE_FLAG=--enable-neon
#cd $SRC_PATH
#build_one

#arm v6+vfp
CPU=armv6
OPTIMIZE_CFLAGS="-DCMP_HAVE_VFP -mfloat-abi=softfp -mfpu=vfp -marm -march=$CPU"
#PREFIX=./android/${CPU}_vfp
PREFIX=/Users/shutup/Documents/player/player_libs/build/android/arm
ADDITIONAL_CONFIGURE_FLAG=
if [ $OPEN_PIE -eq 1 ] ; then
	EXTRA_PIE_FLAG="-pie -fPIE"
else
	EXTRA_PIE_FLAG=""
fi

cd $SRC_PATH
build_one
