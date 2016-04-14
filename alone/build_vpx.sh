NDK=/Users/shutup/Documents/cocos2dx/android-ndk-r10e
SRC_PATH=/Users/shutup/Documents/player/3rd_libs/libvpx
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
	--target=armv7-android-gcc \
	--sdk-path=$NDK \
	--disable-docs \
	--disable-examples \
	--disable-unit-tests \
	--disable-runtime-cpu-detect \
	--extra-cflags="-mfloat-abi=softfp -mfpu=neon $OPTIMIZE_CFLAGS" \
	--disable-debug \
	--disable-debug-libs \
	--disable-shared \
	--enable-static
make -j 4&& make install
