```
./install_packages.sh
./create-docker-containers.sh

./get_docker_info.sh -n 6

python3 setup_all_to_all_arp.py DOCKERyeti-00.sysnet.ucsd.edu.csv //on node 01
python3 setup_all_to_all_arp.py DOCKERyeti-01.sysnet.ucsd.edu.csv //on node 00
```