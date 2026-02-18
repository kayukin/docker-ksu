#!/system/bin/sh
until [ "$(getprop sys.boot_completed)" = "1" ]; do
  sleep 5
done

sleep 5

mount -t tmpfs -o mode=755 tmpfs /sys/fs/cgroup
mkdir -p /sys/fs/cgroup/devices
mount -t cgroup -o devices cgroup /sys/fs/cgroup/devices