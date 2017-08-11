ffmpeg-4-android
================

share the scripts to build ffmpeg lib and program for android platform.

##WHAT IS THIS?
offer the usable scripts to build ffmpeg lib and program for android platforms

#Update

1.if you need `libffmpeg.so` then ,refer to [build_ffmpeg_lib.sh](https://github.com/shutup/ffmpeg4android/blob/master/one/build_ffmpeg_lib.sh)

2.if you need `ffmpeg` program ,then refer to [build_ffmpeg_program.sh](https://github.com/shutup/ffmpeg4android/blob/master/one/build_ffmpeg_program.sh) and [ffmpeg_program_with_x264_x265.sh](https://github.com/shutup/ffmpeg4android/blob/master/one/build_ffmpeg_program_with_x264_x265.sh)

3.An Image show ffmpeg program run on android 7.0 with libx264 ,libx265 support.(Note :After android 5.0, program need add PIE feature)

![ffmpeg program run on android 7.0 with libx264 ,libx265 support](https://github.com/shutup/ffmpeg4android/blob/master/ffmpeg_run_on_android.png)

##USAGES
The Content below may be out of date, just as refrence.

* change the src path and so on,then 
* `./build_all.sh` or `./build_xxx.sh`

* Customizing:
    * 1. Feel free to change ./configure parameters for more features
    * 2. To adapt other ARM variants
        * set $CPU and $OPTIMIZE_CFLAGS 
        * call `build_all` in one folder or `build_xxx` in alone folder 

##THANKS
* [roman's blog] http://www.roman10.net/how-to-build-android-applications-based-on-ffmpeg-by-an-example/
* [Rockplayer Sources build scripts]

##ABOUT ME

* name:  shutup
* emails:fyjc999#gmail.com
