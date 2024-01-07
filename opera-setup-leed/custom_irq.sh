#! /bin/bash

#IRQ 340-403
#0 340: 00,00000000,00000001

# x=0;
# for i in $(seq 340 403); do
#     affinity=$(cat /proc/irq/$i/smp_affinity)
#     echo $x,$i,$affinity
#     x=$(echo "$x+1" | bc)
# done

echo "02,00000000,00000000" | sudo tee /proc/irq/340/smp_affinity 
echo "04,00000000,00000000" | sudo tee /proc/irq/341/smp_affinity 
echo "08,00000000,00000000" | sudo tee /proc/irq/342/smp_affinity 
echo "10,00000000,00000000" | sudo tee /proc/irq/343/smp_affinity 
echo "20,00000000,00000000" | sudo tee /proc/irq/344/smp_affinity 
echo "40,00000000,00000000" | sudo tee /proc/irq/345/smp_affinity 
echo "80,00000000,00000000" | sudo tee /proc/irq/346/smp_affinity 

# echo "04,00000000,00000000" | sudo tee /proc/irq/340/smp_affinity 
# echo "08,00000000,00000000" | sudo tee /proc/irq/341/smp_affinity 
# echo "10,00000000,00000000" | sudo tee /proc/irq/342/smp_affinity 
# echo "20,00000000,00000000" | sudo tee /proc/irq/343/smp_affinity 
# echo "40,00000000,00000000" | sudo tee /proc/irq/344/smp_affinity 
# echo "80,00000000,00000000" | sudo tee /proc/irq/345/smp_affinity 

# # for i in $(seq 340 403); do
# sudo ip netns exec ns1 echo 0| tee /sys/class/net/vethin2/napi_defer_hard_irqs
# echo 200000 | tee /sys/class/net/vethin2/gro_flush_timeout
# echo 2| tee /sys/class/net/vethin3/napi_defer_hard_irqs
# echo 200000 | tee /sys/class/net/vethin3/gro_flush_timeout
# echo 2| tee /sys/class/net/vethin4/napi_defer_hard_irqs
# echo 200000 | tee /sys/class/net/vethin4/gro_flush_timeout
# echo 2| tee /sys/class/net/vethin5/napi_defer_hard_irqs
# echo 200000 | tee /sys/class/net/vethin5/gro_flush_timeout
# echo 2| tee /sys/class/net/vethin6/napi_defer_hard_irqs
# echo 200000 | tee /sys/class/net/vethin6/gro_flush_timeout
# echo 2| tee /sys/class/net/vethin7/napi_defer_hard_irqs
# echo 200000 | tee /sys/class/net/vethin7/gro_flush_timeout
# echo 2| tee /sys/class/net/vethin8/napi_defer_hard_irqs
# echo 200000 | tee /sys/class/net/vethin8/gro_flush_timeout
# echo 2| tee /sys/class/net/vethin9/napi_defer_hard_irqs
# echo 200000 | tee /sys/class/net/vethin9/gro_flush_timeout
# done
 

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
# sudo ip netns exec ns1 echo "0000,00000000,00000000" | sudo tee /sys/class/net/vethin2/queues/rx-0/rps_cpus
# sudo ip netns exec ns2 echo "0000,00000000,00000000" | sudo tee /sys/class/net/vethin3/queues/rx-0/rps_cpus
# sudo ip netns exec ns3 echo "0000,00000000,00000000" | sudo tee /sys/class/net/vethin4/queues/rx-0/rps_cpus
# sudo ip netns exec ns4 echo "0000,00000000,00000000" | sudo tee /sys/class/net/vethin5/queues/rx-0/rps_cpus
# sudo ip netns exec ns5 echo "0000,00000000,00000000" | sudo tee /sys/class/net/vethin6/queues/rx-0/rps_cpus
# sudo ip netns exec ns6 echo "0000,00000000,00000000" | sudo tee /sys/class/net/vethin7/queues/rx-0/rps_cpus
# sudo ip netns exec ns7 echo "0000,00000000,00000000" | sudo tee /sys/class/net/vethin8/queues/rx-0/rps_cpus