NDK=/Users/shutup/Documents/cocos2dx/android-ndk-r10e
SRC_PATH=/Users/shutup/Documents/player/3rd_libs/libass-master
PLATFORM=$NDK/platforms/android-8/arch-arm/
PREBUILT=$NDK/toolchains/arm-linux-androideabi-4.9/prebuilt/darwin-x86_64
CROSS_PREFIX=$PREBUILT/bin/arm-linux-androideabi-
CPU=arm
PREFIX=/Users/shutup/Documents/player/3rd_libs/build/android/$CPU
OPTIMIZE_CFLAGS=""
NEED_LIBS_PATH=/Users/shutup/Documents/player/3rd_libs/build/android/arm
export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:$NEED_LIBS_PATH/lib/pkgconfig
cd $SRC_PATH
make uninsatll 
make clean
./configure --prefix=$PREFIX \
    --with-pic \
	--host=arm-linux \
	--build=i686 \
	--with-sysroot=$PLATFORM \
	--disable-require-system-font-provider \
	--disable-shared \
	--enable-static \
    CC="${CROSS_PREFIX}gcc --sysroot=$PLATFORM" \
    CXX="${CROSS_PREFIX}g++ --sysroot=$PLATFORM" \
    RANLIB="${CROSS_PREFIX}ranlib" \
    AR="${CROSS_PREFIX}ar" \
    STRIP="${CROSS_PREFIX}strip" \
    NM="${CROSS_PREFIX}nm" \
    CFLAGS="-O3 $OPTIMIZE_CFLAGS --sysroot=$PLATFORM" \
    CXXFLAGS="-O3 $OPTIMIZE_CFLAGS --sysroot=$PLATFORM"

make -j 4&& make install
