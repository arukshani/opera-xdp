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


```

