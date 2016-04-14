NDK=/Users/shutup/Documents/cocos2dx/android-ndk-r10e
SRC_PATH=/Users/shutup/Documents/player/3rd_libs/x264-snapshot-20160409-2245
PLATFORM=$NDK/platforms/android-8/arch-arm/
PREBUILT=$NDK/toolchains/arm-linux-androideabi-4.9/prebuilt/darwin-x86_64
CROSS_PREFIX=$PREBUILT/bin/arm-linux-androideabi-
CPU=arm
PREFIX=/Users/shutup/Documents/player/3rd_libs/build/android/$CPU
OPTIMIZE_CFLAGS=""
cd $SRC_PATH
make uninstall
make clean
./configure --prefix=$PREFIX \
	--enable-static \
    --enable-pic \
    --disable-cli \
    --host=arm-linux \
    --cross-prefix=$CROSS_PREFIX \
    --sysroot=$PLATFORM \
	--extra-cflags="-O3 $OPTIMIZE_CFLAGS" \
	--extra-ldflags="-O3 $OPTIMIZE_CFLAGS"
make -j 4  && make install
