```
sudo ip netns exec blue bash
sudo ethtool -L ens4 combined 16
```


### This is version 5
```
sudo taskset --cpu-list 15 ./emulator_v5 192.168.1.1 configs/node-1-link.csv /dev/ptp0 120 1 1 
sudo taskset --cpu-list 15 ./emulator_v5 192.168.1.2 configs/node-2-link.csv /dev/ptp0 120 1 1 

sudo taskset --cpu-list 11 ./emulator_v5 10.1.0.1 configs/node-1-link.csv /dev/ptp0 120 8 16
sudo taskset --cpu-list 11 ./emulator_v5 10.1.0.2 configs/node-2-link.csv /dev/ptp0 120 8 16 
```

