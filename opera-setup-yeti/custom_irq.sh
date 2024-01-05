#! /bin/bash

#even numbereed
# echo "0000,00000000,00000001" | sudo tee /proc/irq/196/smp_affinity #0
# echo "0000,00000000,00000004" | sudo tee /proc/irq/197/smp_affinity #2
# echo "0000,00000000,00000010" | sudo tee /proc/irq/198/smp_affinity #4
# echo "0000,00000000,00000040" | sudo tee /proc/irq/199/smp_affinity #6
# echo "0000,00000000,00000100" | sudo tee /proc/irq/200/smp_affinity #8
# echo "0000,00000000,00000400" | sudo tee /proc/irq/201/smp_affinity #10
# echo "0000,00000000,00001000" | sudo tee /proc/irq/202/smp_affinity #12

#odd numbereed
# echo "0000,00000000,00000002" | sudo tee /proc/irq/196/smp_affinity #1
# echo "0000,00000000,00000008" | sudo tee /proc/irq/197/smp_affinity #3
# echo "0000,00000000,00000020" | sudo tee /proc/irq/198/smp_affinity #5
# echo "0000,00000000,00000080" | sudo tee /proc/irq/199/smp_affinity #7
# echo "0000,00000000,00000200" | sudo tee /proc/irq/200/smp_affinity #9
# echo "0000,00000000,00000800" | sudo tee /proc/irq/201/smp_affinity #11
# echo "0000,00000000,00002000" | sudo tee /proc/irq/202/smp_affinity #13
# echo "0000,00000000,00008000" | sudo tee /proc/irq/203/smp_affinity #15

#veth rps (core 9, 11, 13 etc...)
# sudo ip netns exec ns1 echo "0000,00000000,00000200" | sudo tee /sys/class/net/vethin2/queues/rx-0/rps_cpus
# sudo ip netns exec ns2 echo "0000,00000000,00000800" | sudo tee /sys/class/net/vethin3/queues/rx-0/rps_cpus
# sudo ip netns exec ns3 echo "0000,00000000,00002000" | sudo tee /sys/class/net/vethin4/queues/rx-0/rps_cpus
# sudo ip netns exec ns4 echo "0000,00000000,00008000" | sudo tee /sys/class/net/vethin5/queues/rx-0/rps_cpus
# sudo ip netns exec ns5 echo "0000,00000000,00020000" | sudo tee /sys/class/net/vethin6/queues/rx-0/rps_cpus
# sudo ip netns exec ns6 echo "0000,00000000,00080000" | sudo tee /sys/class/net/vethin7/queues/rx-0/rps_cpus
# sudo ip netns exec ns7 echo "0000,00000000,00200000" | sudo tee /sys/class/net/vethin8/queues/rx-0/rps_cpus

#veth remove rps
sudo ip netns exec ns1 echo "0000,00000000,00000000" | sudo tee /sys/class/net/vethin2/queues/rx-0/rps_cpus
sudo ip netns exec ns2 echo "0000,00000000,00000000" | sudo tee /sys/class/net/vethin3/queues/rx-0/rps_cpus
sudo ip netns exec ns3 echo "0000,00000000,00000000" | sudo tee /sys/class/net/vethin4/queues/rx-0/rps_cpus
sudo ip netns exec ns4 echo "0000,00000000,00000000" | sudo tee /sys/class/net/vethin5/queues/rx-0/rps_cpus
sudo ip netns exec ns5 echo "0000,00000000,00000000" | sudo tee /sys/class/net/vethin6/queues/rx-0/rps_cpus
sudo ip netns exec ns6 echo "0000,00000000,00000000" | sudo tee /sys/class/net/vethin7/queues/rx-0/rps_cpus
sudo ip netns exec ns7 echo "0000,00000000,00000000" | sudo tee /sys/class/net/vethin8/queues/rx-0/rps_cpus