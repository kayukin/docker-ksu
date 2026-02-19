#!/system/bin/sh
while [ "$(getprop sys.boot_completed)" != 1 ]; do
    sleep 1
done
log Info "System loaded"
sleep 20
log Info "Started mounting"

mount -t tmpfs -o mode=755 tmpfs /sys/fs/cgroup
mkdir -p /sys/fs/cgroup/devices
mount -t cgroup -o devices cgroup /sys/fs/cgroup/devices

log Info "Finished mounting"

ip route add default via 192.168.1.1 dev wlan0
ip rule add from all lookup main pref 30000

log Info "Routes added"

ndc network interface add local docker0
ndc network route add local docker0 172.17.0.0/16
ndc ipfwd enable docker
ndc ipfwd add docker0 wlan0

log Info "Bridge fixed"