#/bin/bash

for arg in "$@"
do
case $arg in
    -f|--file_name)
        shift
        file_name=$1
        shift
        ;;
esac
done

path="dumps/"
file_name="node6-BR1"

# chown -R $USER:$USER Experiments/A1/

tshark -2 -r $path/$file_name.pcap -R "udp.dstport == 12101" -T fields -e frame.time -e ip.src -e ip.dst > $path/$file_name.csv