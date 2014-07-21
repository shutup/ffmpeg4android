ffmpeg-4-android
================

share the scripts to build ffmpeg lib for android platform.

##WHAT IS THIS?
offer the usable scripts to build ffmpeg lib for android platforms

##USAGES

* put this script in top of FFmpeg source tree
* ./build_android
* It generates binary for following architectures:
    * ARMv6 
    * ARMv6+VFP 
    * ARMv7+VFPv3-d16 (Tegra2) 
    * ARMv7+Neon (Cortex-A8)
* Customizing:
    * 1. Feel free to change ./configure parameters for more features
    * 2. To adapt other ARM variants
        * set $CPU and $OPTIMIZE_CFLAGS 
        * call build_one

##THANKS
* [roman's blog] http://www.roman10.net/how-to-build-android-applications-based-on-ffmpeg-by-an-example/

##ABOUT ME

* name:  shutup
* emails:fyjc999@gmail.com
