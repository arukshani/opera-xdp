```

./opera-setup-yeti/setup_master.sh

sudo ip link set dev enp65s0f0np0 down
sudo ip addr del 10.10.1.1/24 dev enp65s0f0np0
sudo ip addr del 10.10.1.2/24 dev enp65s0f0np0

sudo ip addr add 10.20.1.1/16 dev enp65s0f0np0
sudo ip addr add 10.20.2.1/16 dev enp65s0f0np0
sudo ip link set dev enp65s0f0np0 up
//sudo ip link set enp65s0f0np0 mtu 3490


./opera-setup-yeti/setup_worker.sh
./opera-setup-yeti/unique_ip_for_ns.sh

cd opera-setup-leed
python3 setup_mac.py

./get_veth_info.sh -n 7

python3 setup_all_to_all_arp.py configs/NSnode-1.csv //node2
python3 setup_all_to_all_arp.py configs/NSnode-2.csv //node1

sudo ethtool -L enp65s0f0np0 combined 1
sudo ethtool -L enp65s0f0np0 rx 1
sudo ethtool -L enp65s0f0np0 tx 1
sudo set_irq_affinity.sh enp65s0f0np0


```

```
sudo ip netns exec ns1 bash
```

