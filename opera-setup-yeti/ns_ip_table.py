import subprocess
import binascii
import socket
import os

def set_ns_ip_table():
    filename="nsiptable-" + socket.gethostname() + ".csv"
    ipv4 = os.popen('ip addr show ens2np0 | grep "\<inet\>" | awk \'{ print $2 }\' | awk -F "/" \'{ print $1 }\'').read().strip()
    # print(ipv4)
    subnet = ipv4[:-1]
    # print(subnet)
    for i in range(2, 10):
        ns_ip = subnet + str(i)
        # print(ns_ip)
        hex_ns_ip="0x{}".format(binascii.hexlify(socket.inet_aton(ns_ip)).decode('ascii'))
        # print(hex_ns_ip)
        row_record = ns_ip + ",{}".format(hex_ns_ip)
        with open(filename, "a") as myfile:
            myfile.write(row_record + "\n")


    # remoteCmd = './get_mac.sh'
    # stdout = subprocess.run(remoteCmd, shell=True, stdout=subprocess.PIPE).stdout.decode('utf-8').strip()
    # hex_val_lan_ip="0x{}".format(binascii.hexlify(socket.inet_aton(stdout.partition(',')[0])).decode('ascii'))
    # stdout = stdout + ",{}".format(hex_val_lan_ip)
    # with open("/home/dathapathu/emulator/github_code/cr_worker_info.csv", "a") as myfile:
    #     myfile.write(stdout + "\n")

    
if __name__ == '__main__':
    set_ns_ip_table()
