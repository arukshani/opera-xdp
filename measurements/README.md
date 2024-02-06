

sudo ethtool -T enp24s0np0
<!-- tcpdump -i enp24s0np0 -J
Time stamp types for enp24s0np0 (use option -j to set):
  host (Host)
  adapter_unsynced (Adapter, not synced with system time) -->

## 40 ping packets
sudo ./tdump.sh -f test6

scp -r -P 222 dumps/test_6 dathapathu@trolley.sysnet.ucsd.edu:/home/dathapathu/s24/

## After restart
## test4 - without sys clock sync
## test5 - with sys clock sync

timedatectl status

## test6 - from leed02 to leed01


