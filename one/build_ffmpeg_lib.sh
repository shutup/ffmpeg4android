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
    --extra-cflags="-I$NEED_LIBS_PATH/include -O3  -pie -fPIE  $OPTIMIZE_CFLAGS " \
    --extra-ldflags="-pie -fPIE -L$NEED_LIBS_PATH/lib" \
    --disable-shared \
    --enable-static \
	--enable-pic \
    --disable-doc \
	--disable-programs \
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
$PREBUILT/bin/arm-linux-androideabi-ar d $SRC_PATH/libavcodec/libavcodec.a inverse.o
$PREBUILT/bin/arm-linux-androideabi-ld -rpath-link=$PLATFORM/usr/lib -L$PLATFORM/usr/lib -L$NEED_LIBS_PATH/lib -I$NEED_LIBS_PATH/include -soname libffmpeg.so -shared -nostdlib  -z noexecstack -Bsymbolic --whole-archive --no-undefined -o $PREFIX/lib/libffmpeg.so $SRC_PATH/libavcodec/libavcodec.a $SRC_PATH/libavformat/libavformat.a $SRC_PATH/libavutil/libavutil.a $SRC_PATH/libswscale/libswscale.a $SRC_PATH/libswresample/libswresample.a -lc -lm -lz -ldl -llog   --dynamic-linker=/system/bin/linker $PREBUILT/lib/gcc/arm-linux-androideabi/4.9.x/libgcc.a
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
cd $SRC_PATH
build_one
