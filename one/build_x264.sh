NDK=/Users/shutup/Library/Android/sdk/ndk-bundle
SRC_PATH=/Users/shutup/Documents/player/player_libs/source/x264-snapshot-20170809-2245
PLATFORM=$NDK/platforms/android-9/arch-arm/
PREBUILT=$NDK/toolchains/arm-linux-androideabi-4.9/prebuilt/darwin-x86_64
CROSS_PREFIX=$PREBUILT/bin/arm-linux-androideabi-
CPU=arm
PREFIX=/Users/shutup/Documents/player/player_libs/build/android/$CPU
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
