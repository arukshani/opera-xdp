### All Nodes

### Intel machine turn off init on alloc
```
sudo vi  /etc/default/grub
GRUB_CMDLINE_LINUX_DEFAULT="init_on_alloc=0 init_on_free=0 intel_iommu=off"
sudo update-grub
and sudo reboot
```

```
cd /home/dathapathu/emulator/github_code/opera-xdp/opera-setup-yeti
./setup_master.sh 
```

### Setup IPs
```
sudo ip addr add 10.1.0.1/24 dev ens4
sudo ip addr add 10.1.0.2/24 dev ens4
sudo ip addr add 10.1.0.3/24 dev ens4
sudo ip addr add 10.1.0.4/24 dev ens4
sudo ip link set dev ens4 up
sudo ip link set dev ens4 down
```

### Worker things
```
./setup_worker.sh
./create_multi_ns.sh
<!-- ./ns_for_corundum.sh -->
./unique_ip_for_ns.sh
```

### Write mac details to file
```
python3 setup_mac.py
```

### Add ARP records
```
./get_veth_info.sh -n 13
scp arp records
python3 setup_arp.py yeti-00.sysnet.ucsd.edu.csv
python3 setup_arp.py yeti-01.sysnet.ucsd.edu.csv
python3 setup_arp.py yeti-02.sysnet.ucsd.edu.csv
python3 setup_arp.py yeti-03.sysnet.ucsd.edu.csv

for corundum
./get_veth_info.sh -n 7
<!-- python3 setup_arp.py CRyeti-00.sysnet.ucsd.edu.csv
python3 setup_arp.py CRyeti-01.sysnet.ucsd.edu.csv -->

python3 setup_all_to_all_arp.py NSyeti-00.sysnet.ucsd.edu.csv
python3 setup_all_to_all_arp.py NSyeti-01.sysnet.ucsd.edu.csv
```

### HW Queue setup
```
sudo ethtool -L ens4 combined 16
sudo ethtool -G ens4 rx 2048
sudo ethtool -G ens4 tx 2048
sudo set_irq_affinity.sh ens4
```


### Update clang version to 11 if needed 
```
sudo apt-get install clang-11 libc++-11-dev libc++abi-11-dev
sudo su
cd /usr/lib/llvm-11/bin
for f in *; do rm -f /usr/bin/$f; \
    ln -s ../lib/llvm-11/bin/$f /usr/bin/$f; done
exit
clang --version
```

```
sudo ip netns del ns
ip netns list
sudo ip netns exec ns11 bash
iperf -c 10.1.0.2 -u -t 200 -b 50000M -i 1
```

```
(main)
n_ports = 9;

t->ports_rx[8] = ports[8]; // veth29

port_params[8].iface = "vethout29"; 
port_params[8].iface_queue = 0;

(thread_func_veth)
if (track_veth_rx_port == 8) {

(load_xdp_program)
struct config cfgs[9]

static struct xdp_program *xdp_prog[9];
```

```
sudo ./p2_drop 10.1.0.1 configs/node-1-link.csv /dev/ptp0 100 1
sudo ./p2_drop 10.1.0.1 configs/node-1-link.csv /dev/ptp0 100 2
sudo ./p2_drop 10.1.0.1 configs/node-1-link.csv /dev/ptp0 100 3
```

```
lscpu | grep NUMA
```

```
https://github.com/ucsdsysnet/corundum
https://github.com/ucsdsysnet/corundum/tree/master/modules/mqnic 

Install Corundum driver:
* Clone https://github.com/corundum/corundum.git
* Go to modules/mqnic
* Build mqnic.ko, e.g. make -j $(nproc) all
* Install the kernel module: cp mqnic.ko /tmp && sudo insmod /tmp/mqnic.ko (copy-to-tmp needed because of NFS root permission issues, same below)


sudo ip addr add 10.20.2.1/24 dev ens2np0
sudo ip link set dev ens2np0 up
sudo ip link set ens2np0 mtu 3490

sudo ip addr add 10.20.2.2/24 dev ens2np0
sudo ip link set dev ens2np0 up
sudo ip link set ens2np0 mtu 3490

sudo ethtool -L ens2np0 rx 1
sudo ethtool -L ens2np0 tx 1

iperf3 -c 10.20.2.2 -p 5000  
iperf3 -s 10.20.2.2 -p 5000 

sudo ip addr del 10.10.1.1/24 dev ens2np0
sudo ip addr del 10.10.1.2/24 dev ens2np0

sudo ip addr del 10.20.2.1/24 dev ens2np0
sudo ip addr del 10.20.2.2/24 dev ens2np0

use the mqnic-fw utility to reset the FPGA
mqnic-fw -d /dev/mqnic0 -t

full reboot of the FPGA from flash
mqnic-fw -d /dev/mqnic0 -b

reboot the server
mqnic-fw is in the utils subdir

cd /home/dathapathu/emulator/github_code/corundum/utils
sudo ./mqnic-fw -d /dev/mqnic0 -t
```


### Corundum setup
```
cd /home/dathapathu/emulator/github_code/corundum/modules/mqnic
make -j $(nproc) all
cp mqnic.ko /tmp
sudo insmod /tmp/mqnic.ko
```

```
sudo ip addr add 10.20.1.1/16 dev ens2np0
sudo ip addr add 10.20.2.1/16 dev ens2np0
sudo ip link set dev ens2np0 up
sudo ip link set ens2np0 mtu 3490
```

```
sudo ./unique_ip_for_ns.sh
python3 setup_mac.py
./get_veth_info.sh -n 7

python3 setup_all_to_all_arp.py NSyeti-00.sysnet.ucsd.edu.csv //on node 01
python3 setup_all_to_all_arp.py NSyeti-01.sysnet.ucsd.edu.csv //on node 00
```

```
sudo ethtool -L ens2np0 rx 1
sudo ethtool -L ens2np0 tx 1
sudo set_irq_affinity.sh ens2np0
```