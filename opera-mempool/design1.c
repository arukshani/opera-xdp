// SPDX-License-Identifier: GPL-2.0
/* Copyright(c) 2020 - 2022 Intel Corporation. */

#define _GNU_SOURCE
#include <stdbool.h>
#include <poll.h>
#include <pthread.h>
#include <signal.h>
#include <sched.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>
#include <sys/resource.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <time.h>
#include <unistd.h>
#include <getopt.h>
#include <netinet/ether.h>
#include <net/if.h>
#include <linux/err.h>
#include <linux/if_link.h>
#include <linux/if_xdp.h>
#include <xdp/libxdp.h>
#include <xdp/xsk.h>
#include <bpf/bpf.h>
#include <bpf/libbpf.h>
#include <linux/if_ether.h>
#include <linux/ip.h>
#include <net/ethernet.h>
#include <netinet/ether.h>
#include <net/if.h>
#include <arpa/inet.h>
#include <linux/ip.h>
#include <linux/icmp.h>
#include <bpf/bpf_endian.h>
#include <errno.h>
#include <fcntl.h>
#include <inttypes.h>
#include <math.h>
#include <signal.h>
#include <stdlib.h>
#include <string.h>
#include <sys/ioctl.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <sys/time.h>
#include <sys/timex.h>
#include <sys/types.h>
#include <unistd.h>
#include <assert.h>
#include <arpa/inet.h>
#include <sys/socket.h>
#include <netdb.h>
#include <ifaddrs.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <linux/if_link.h>
#include <string.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <limits.h>
#include <linux/ptp_clock.h>

#include "structures.h"
#include "plumbing.h"


static void
print_port(u32 port_id)
{
	struct port *port = ports[port_id];

	printf("Port %u: interface = %s, queue = %u\n",
		   port_id, port->params.iface, port->params.iface_queue);
}

int main(int argc, char **argv)
{
    struct in_addr *ifa_inaddr;
	struct in_addr addr;
	int n,i,x,y,z;

	if (argc != 5)
	{
		fprintf(stderr, "Usage: getifaddr <IP>\n");
		return EXIT_FAILURE;
	}

	if (inet_aton(argv[1], &addr) == 0)
	{
		perror("inet_aton");
		return EXIT_FAILURE;
	}
	if (getifaddrs(&ifaddr) == -1)
	{
		perror("getifaddrs");
		return EXIT_FAILURE;
	}

    char *run_time = argv[2];
	int running_time = atoi(run_time);
	printf("Running time : %d \n", running_time);

    char *num_nses = argv[3];
	int num_of_nses = atoi(num_nses);
	printf("Number of Namespaces : %d \n", num_of_nses);

	char *num_nic_qs = argv[4];
	n_nic_ports = atoi(num_nic_qs);
	printf("Number of NIC Queues : %d \n", n_nic_ports);

    for (ifa = ifaddr, n = 0; ifa != NULL; ifa = ifa->ifa_next, n++)
	{
		if (ifa->ifa_addr == NULL)
			continue;

		/* We seek only for IPv4 addresses */
		if (ifa->ifa_addr->sa_family != AF_INET)
			continue;

		ifa_inaddr = &(((struct sockaddr_in *)ifa->ifa_addr)->sin_addr);
		if (memcmp(ifa_inaddr, &addr, sizeof(struct in_addr)) == 0)
		{
			printf("Interface: %s\n", ifa->ifa_name);
			nic_iface = ifa->ifa_name;
		}
	}

    n_ports = num_of_nses + n_nic_ports;
    n_veth_ports = num_of_nses;

    for (i = 0; i < MAX_PORTS; i++)
    {
        memcpy(&bpool_params[i], &bpool_params_default,
		   sizeof(struct bpool_params));
        memcpy(&umem_cfg[i], &umem_cfg_default,
		   sizeof(struct xsk_umem_config));
        memcpy(&port_params[i], &port_params_default,
			   sizeof(struct port_params));
    }
		

    load_xdp_program();

    for (y = 0; y < n_nic_ports; y++)
	{
        port_params[y].iface = nic_iface; 
	    port_params[y].iface_queue = y;
    }

	z = 0;
	int start_index_for_veth_ports = n_nic_ports;
    for (x = start_index_for_veth_ports; x < n_ports; x++)
	{
		port_params[x].iface = out_veth_arr[z]; 
	    port_params[x].iface_queue = 0;
		z = z + 1;
	}

    for (i = 0; i < n_ports; i++)
	{
        printf("==============Initialize buffer pool for port: %d ================= \n", i);
        bp[i] = bpool_init(&bpool_params[i], &umem_cfg[i]);
        port_params[i].bp = bp[i];

        ports[i] = port_init(&port_params[i]);
		if (!ports[i])
		{
			printf("Port %d initialization failed.\n", i);
			return -1;
		}
        print_port(i);
    }


    printf("===========Update  bpf maps============================\n");
    enter_xsks_into_map_for_nic();

	//Enter xsk into map for veth
	for (x = n_nic_ports; x < n_ports; x++)
	{
		enter_xsks_into_map(x);
	}


    //=============FREE MEMORY===============
    freeifaddrs(ifaddr);

    for (i = 0; i < n_ports; i++)
    {
        port_free(ports[i]);
        bpool_free(bp[i]);
    }
		
    printf("===========Remove XDP Programs from NIC and VETHS============\n");
    remove_xdp_program_nic();
	remove_xdp_program_veth();
}