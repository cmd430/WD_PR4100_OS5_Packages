# wdpksrc

This project contains the source and tools for software packages for Western Digital My Cloud PR4100 (OS5) NAS.

# Setup Development Environment

## mksapkg setup

For simple script based apps (most of the current packages), you only need mksapkg to create a binary.

On Ubuntu 18.04:

.. code::

    apt install libxml2 openssl


### Build and deploy test

.. code::
    cd ./wdpk/<app>
    ./build.sh

This builds the OS5 package and places it at `packages/<app>`

# License

When not explicitly set, files are placed under a [3 clause BSD license](http://www.opensource.org/licenses/BSD-3-Clause)
