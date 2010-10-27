#!/sbin/busybox.init sh
# 
# do last changes before system starts

# tweaks by 'hardcore' : http://forum.xda-developers.com/showthread.php?t=813309
# Tweak cfq io scheduler
#for i in `ls /sys/block/stl* /sys/block/mmc* /sys/block/bml* /sys/block/tfsr*`; do
#	echo "0" > $i/queue/rotational
#	echo "1" > $i/queue/iosched/low_latency
#	echo "1" > $i/queue/iosched/back_seek_penalty
#	echo "1000000000" > $i/queue/iosched/back_seek_max
#	echo "3" > $i/queue/iosched/slice_idle
#done

# Tweak kernel VM management
echo "0" > /proc/sys/vm/swappiness
echo "10" > /proc/sys/vm/dirty_ratio
echo "1000" > /proc/sys/vm/vfs_cache_pressure
echo "4096" > /proc/sys/vm/min_free_kbytes

# Tweak kernel scheduler
echo "4000000" > /proc/sys/kernel/sched_latency_ns
echo "1000000" > /proc/sys/kernel/sched_wakeup_granularity_ns
echo "800000" > /proc/sys/kernel/sched_min_granularity_ns

# debug debug debug
exit 0

# Miscellaneous tweaks
setprop dalvik.vm.startheapsize 8m
setprop wifi.supplicant_scan_interval 90

# copy Superuser.apk if needed (ie, 1st time we are running on this system)
if [ ! -f /system/app/Superuser.apk ]; then
	# copy superuser to /system/app
	cp /Superuser.apk /system/app/
	# and install busybox (if exists) to /system/xbin
	#[ -x /sbin/busybox ] && /sbin/busybox --install -s /system/xbin
fi
rm /Superuser.apk

# allow user specific init script to be executed
[ -x /system/z4mod.init.sh ] && /system/z4mod.init.sh

# return 0 to init
exit 0
