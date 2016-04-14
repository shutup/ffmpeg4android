#set the src full path 
SRC_PATH_FDK_AAC=/Users/shutup/Documents/player/3rd_libs/mstorsjo-fdk-aac
SRC_PATH_X264=/Users/shutup/Documents/player/3rd_libs/x264-snapshot-20160409-2245
SRC_PATH_OGG=/Users/shutup/Documents/player/3rd_libs/libogg-1.3.2
SRC_PATH_VORBIS=/Users/shutup/Documents/player/3rd_libs/libvorbis-1.3.5
SRC_PATH_THEORA=/Users/shutup/Documents/player/3rd_libs/libtheora-1.1.1
SRC_PATH_OPUS=/Users/shutup/Documents/player/3rd_libs/opus-1.1.2
SRC_PATH_MP3_LAME=/Users/shutup/Documents/player/3rd_libs/lame-3.99.5
SRC_PATH_VPX=/Users/shutup/Documents/player/3rd_libs/libvpx
SRC_PATH_FFMPEG=/Users/shutup/Documents/player/ffmpeg-3.0

#check if you need the lib
ADD_FDK_AAC=1
ADD_X264=1
ADD_OGG=1
ADD_VORBIS=1
ADD_THEORA=1
ADD_OPUS=1
ADD_MP3_LAME=1
ADD_VPX=1
ADD_FFMPEG=1

#change to your own ndk path!!!
NDK=/Users/shutup/Documents/cocos2dx/android-ndk-r10e
PLATFORM=$NDK/platforms/android-8/arch-arm/
PREBUILT=$NDK/toolchains/arm-linux-androideabi-4.9/prebuilt/darwin-x86_64
CROSS_PREFIX=$PREBUILT/bin/arm-linux-androideabi-
CPU=arm
PREFIX=/Users/shutup/Documents/player/3rd_libs/build/android/$CPU
NEED_LIBS_PATH=/Users/shutup/Documents/player/3rd_libs/build/android/$CPU
export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:$NEED_LIBS_PATH/lib/pkgconfig
#OPTIMIZE_CFLAGS="-pie -fPIE"
OPTIMIZE_CFLAGS=""

#build_x264
function build_x264
{
cd $SRC_PATH_X264
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
}

#build_fdk_aac
function build_fdk_aac
{
cd $SRC_PATH_FDK_AAC
make uninstall
make clean
./configure --prefix=$PREFIX \
    --with-sysroot=$PLATFORM \
    --host=arm-linux \
	--disable-shared \
    --enable-static \
    --with-pic \
    CC="${CROSS_PREFIX}gcc --sysroot=$PLATFORM" \
    CXX="${CROSS_PREFIX}g++ --sysroot=$PLATFORM" \
    RANLIB="${CROSS_PREFIX}ranlib" \
    AR="${CROSS_PREFIX}ar" \
    STRIP="${CROSS_PREFIX}strip" \
    NM="${CROSS_PREFIX}nm" \
    CFLAGS="-O3 $OPTIMIZE_CFLAGS --sysroot=$PLATFORM" \
    CXXFLAGS="-O3 $OPTIMIZE_CFLAGS --sysroot=$PLATFORM"
make -j 4 &&make install
}

#build_ogg
function build_ogg
{
cd $SRC_PATH_OGG
make uninstall
make clean
./configure --prefix=$PREFIX \
    --host=arm-linux \
	--build=i686 \
	--disable-shared \
	--enable-static \
	--with-pic \
    CC="${CROSS_PREFIX}gcc --sysroot=$PLATFORM" \
    CXX="${CROSS_PREFIX}g++ --sysroot=$PLATFORM" \
    RANLIB="${CROSS_PREFIX}ranlib" \
    AR="${CROSS_PREFIX}ar" \
    STRIP="${CROSS_PREFIX}strip" \
    NM="${CROSS_PREFIX}nm" \
    CFLAGS="-O3 $OPTIMIZE_CFLAGS --sysroot=$PLATFORM" \
    CXXFLAGS="-O3 $OPTIMIZE_CFLAGS --sysroot=$PLATFORM"
make -j 4 && make install
}

#build_vorbis
function build_vorbis
{
cd $SRC_PATH_VORBIS
make uninstall
make clean
./configure --prefix=$PREFIX \
	--with-pic \
    --host=arm-linux \
	--build=i686 \
	--with-sysroot=$PLATFORM \
	--with-ogg \
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
make -j 4 && make install
}

#build_opus
function build_opus
{
cd $SRC_PATH_OPUS
make uninstall
make clean
./configure --prefix=$PREFIX \
	--with-pic \
	--build=i686 \
    --host=arm-linux \
	--disable-doc \
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

make -j 4 && make install
}

#build_theora
function build_theora
{
cd $SRC_PATH_THEORA
make uninstall
make clean
./configure --prefix=$PREFIX \
	--with-pic \
    --host=arm-linux \
	--build=i686 \
	--disable-examples \
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
}

#build_mp3_lame
function build_mp3_lame
{
cd $SRC_PATH_MP3_LAME
make uninstall
 make clean
./configure --prefix=$PREFIX \
	--with-pic \
	--build=i686-apple-darwin \
    --host=arm-linux \
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

make && make install
}

#build_vpx
function build_vpx
{
cd $SRC_PATH_VPX
make uninstall
make clean
./configure --prefix=$PREFIX \
	--target=armv7-android-gcc \
	--sdk-path=$NDK \
	--disable-docs \
	--disable-examples \
	--disable-unit-tests \
	--disable-runtime-cpu-detect \
	--extra-cflags="-O3 -mfloat-abi=softfp -mfpu=neon $OPTIMIZE_CFLAGS " \
	--disable-debug \
	--disable-debug-libs \
	--disable-shared \
	--enable-static
make -j 4&& make install
}

#build ffmpeg
function build_ffmpeg
{
cd $SRC_PATH_FFMPEG
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
	--enable-libfdk-aac \
	--enable-nonfree \
	--enable-libvpx \
	--enable-libvorbis \
	--enable-libtheora \
	--enable-libmp3lame \
	--enable-libx264 \
    --extra-libs="-lgcc -lc -lm -ldl -llog -lopus" \
    --extra-cflags="-I$NEED_LIBS_PATH/include -O3  -pie -fPIE  $OPTIMIZE_CFLAGS " \
    --extra-ldflags="-pie -fPIE -L$NEED_LIBS_PATH/lib" \
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
    --enable-zlib \
    --disable-avdevice \
    $ADDITIONAL_CONFIGURE_FLAG
make uninstall
make clean
make -j 4
make install
#$PREBUILT/bin/arm-linux-androideabi-ar d libavcodec/libavcodec.a inverse.o
#$PREBUILT/bin/arm-linux-androideabi-ld -rpath-link=$PLATFORM/usr/lib -L$PLATFORM/usr/lib -L$NEED_LIBS_PATH/lib -I$NEED_LIBS_PATH/include -soname libffmpeg.so -shared -nostdlib  -z noexecstack -Bsymbolic --whole-archive --no-undefined -o $PREFIX/lib/libffmpeg.so libavcodec/libavcodec.a libavformat/libavformat.a libavutil/libavutil.a libswscale/libswscale.a libswresample/libswresample.a -lc -lm -lz -ldl -llog   --dynamic-linker=/system/bin/linker $PREBUILT/lib/gcc/arm-linux-androideabi/4.9/libgcc.a
}

#build_fdk_aac
if [ $ADD_FDK_AAC -eq 1 ] ; then
build_fdk_aac
fi

#build_x264
if [ $ADD_X264 -eq 1 ] ; then
build_x264
fi

#build_ogg
if [ $ADD_OGG -eq 1 ] ; then
build_ogg
fi

#build_vorbis
if [ $ADD_VORBIS -eq 1 ] ; then
build_vorbis
fi

#build_theora
if [ $ADD_THEORA -eq 1 ] ; then
build_theora
fi

#build_opus
if [ $ADD_OPUS -eq 1 ] ; then
build_opus
fi

#build_vpx
if [ $ADD_VPX -eq 1 ] ; then
build_vpx
fi

#build_mp3_lame
if [ $ADD_MP3_LAME -eq 1 ] ; then
build_mp3_lame
fi

#build_ffmpeg
if [ $ADD_FFMPEG -eq 1 ] ; then
build_ffmpeg
fi
