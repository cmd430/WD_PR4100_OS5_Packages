#!/bin/sh

STOCK_PATH=/var/www/MediaDeviceDrivers/core
LINUXTV_PATH=/var/www/MediaDeviceDrivers/linuxtv

suspend_dvb_devices()
{
   for i in /sys/class/dvb/dvb*.frontend0 ; do
	[ ! -e "$i" ] && break
	for j in 15 14 13 12 11 10 9 8 7 6 5 4 ; do
		x=`readlink "$i" | cut -d'/' -f$j`
		echo $x | egrep -q  "^[0-9]-[0-9]$" && found_dvb=$x && break
	done
	echo $found_dvb > /sys/bus/usb/drivers/usb/unbind
	echo $found_dvb >> /tmp/dvb_devices.txt
   done

   if [ -f /tmp/dvb_devices.txt ] ; then
	sort -u /tmp/dvb_devices.txt > /tmp/dvb_tmp_list.txt
	mv /tmp/dvb_tmp_list.txt /tmp/dvb_devices.txt
   fi
}

resume_dvb_devices()
{
   if [ ! -f /tmp/dvb_devices.txt ] ; then
	return 0
   fi

   for i in `cat /tmp/dvb_devices.txt` ; do
	echo $i > /sys/bus/usb/drivers/usb/bind
   done
}

insert_core_modules()
{
   ## Required/Missing core Kernel Modules ##
   cd $STOCK_PATH
   for i in soundcore.ko snd.ko snd-timer.ko snd-pcm.ko i2c-mux.ko frame_vector.ko \
	    dma-fence.ko reservation.ko dma-buf.ko ; do
	module="${i/.ko/}"
	module="${module/-/.}"
	if [ -z "`lsmod | egrep $module`" -a -e "$i" ] ; then
		echo "Inserting $i"
		insmod $i || ( echo "wtf..." && return 1 )
	fi
   done
   cd ..
}

remove_core_modules()
{
   for i in dma-buf.ko reservation.ko dma-fence.ko frame_vector.ko i2c-mux.ko \
	    snd-pcm.ko snd-timer.ko snd.ko soundcore.ko ; do
	module="${i/.ko/}"
	module="${module/-/.}"
	if [ -n "`lsmod | egrep $module`" ] ; then
		echo "Removing $i"
		rmmod ${i/.ko/} 2>/dev/null
		if [ "$?" != "0" ] ; then
			echo "force removal ${i/.ko/}"
			rmmod -f ${i/.ko/} || echo "wtf...probably in use..."
		fi
	fi
   done
}

insert_media_modules()
{
   ## Tip Media Tree Drivers ##
   cd $LINUXTV_PATH
   for i in mc.ko videodev.ko videobuf-core.ko videobuf-vmalloc.ko tveeprom.ko \
	 videobuf2-common.ko videobuf2-memops.ko videobuf2-vmalloc.ko \
	 dvb-core.ko videobuf2-dvb.ko videobuf2-v4l2.ko rc-core.ko mceusb.ko \
	 cx2341x.ko cx25840.ko si2157.ko si2168.ko lgdt3306a.ko \
	 a8293.ko ts2020.ko m88ds3103.ko mxl692.ko \
	 em28xx.ko em28xx-alsa.ko cx231xx.ko cx231xx-alsa.ko \
	 cx231xx-dvb.ko em28xx-dvb.ko ; do
	if [ -e $i ] ; then
		echo "Inserting $i"
		insmod $i || ( echo "wtf..." && return 1 )
	fi
   done
   cd ..
}

remove_media_modules()
{
   # attempt to remove all non-builtin modules
   for i in em28xx-dvb.ko cx231xx-dvb.ko cx231xx-alsa.ko cx231xx.ko em28xx-alsa.ko em28xx.ko \
	 mxl692.ko m88ds3103.ko ts2020.ko a8293.ko \
	 lgdt3306a.ko si2168.ko si2157.ko cx25840.ko cx2341x.ko \
	 videobuf2-v4l2.ko videobuf2-dvb.ko mceusb.ko rc-core.ko \
	 tveeprom.ko dvb_core.ko videobuf2_vmalloc.ko videobuf2_memops.ko \
	 videobuf2_common.ko videobuf-vmalloc.ko videobuf-core.ko videodev.ko mc.ko ; do
	module="${i/.ko/}"
	module="${module/-/.}"
	if [ -n "`lsmod | egrep $module`" ] ; then
		echo "Removing $i"
		rmmod ${i/.ko/} 2>/dev/null
		if [ "$?" != "0" ] ; then
			echo "force removal ${i/.ko/}"
			rmmod -f ${i/.ko/} || echo "wtf...probably in use..."
		fi
	fi
   done
}

initialize()
{
   path="$1"

   # Create symlinks
   ln -s "$path/bin/tv-loader.sh" /usr/bin/tv-loader.sh 2>/dev/null
   ln -s "$path/bin/w_scan2" /usr/bin/w_scan 2>/dev/null
   ln -s "$path" /var/www/MediaDeviceDrivers 2>/dev/null

   mkdir -p /lib/firmware

   for i in v4l-cx231xx-avcore-01.fw dvb-demod-mxl692.fw \
	 dvb-demod-m88ds3103b.fw dvb-demod-m88ds3103.fw \
	 dvb-demod-si2168-b40-01.fw dvb-tuner-si2157-a30-01.fw \
	 NXP7164-2010-03-10.1.fw NXP7164-2010-04-01.1.fw \
	 dvb-demod-si2168-d60-01.fw ; do
	ln -s "$path/firmware/$i" /lib/firmware/ 2>/dev/null
   done
}

cleanup()
{
   # Remove links & files
   rm -f /usr/bin/tv-loader.sh 2> /dev/null
   rm -f /usr/bin/w_scan 2> /dev/null
   rm -f /var/www/MediaDeviceDrivers

   for i in v4l-cx231xx-avcore-01.fw dvb-demod-mxl692.fw \
	 dvb-demod-m88ds3103b.fw dvb-demod-m88ds3103.fw \
	 dvb-demod-si2168-b40-01.fw dvb-tuner-si2157-a30-01.fw \
	 NXP7164-2010-03-10.1.fw NXP7164-2010-04-01.1.fw \
	 dvb-demod-si2168-d60-01.fw ; do
	rm -f /lib/firmware/$i
   done

   rmdir --ignore-fail-on-non-empty /lib/firmware
}

