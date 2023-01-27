# WD_PR4100_OS5_Packages

This project contains the source and tools for software packages for Western Digital My Cloud PR4100 (OS5) NAS.

- Forked and stripped down from https://github.com/WDCommunity/wdpksrc
- Currently contains updated `MediaDeviceDrivers` package fixed for Hauppauge WinTV-dualHD (fix missing `dvb-demod-si2168-d60-01.fw`)

# Setup Development Environment

## mksapkg setup

For simple script based apps (most of the current packages), you only need mksapkg to create a binary.

On Ubuntu 18.04 (I used WSL):

.. code::

    apt install libxml2 openssl


### Build and deploy test

.. code::
    cd ./wdpk/<app>
    ./build.sh

This builds the OS5 package and places it at `packages/<app>`

# License

When not explicitly set, files are placed under a [3 clause BSD license](http://www.opensource.org/licenses/BSD-3-Clause)
