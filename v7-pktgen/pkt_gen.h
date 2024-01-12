static void *memset32_htonl(void *dest, u32 val, u32 size)
{
	u32 *ptr = (u32 *)dest;
	int i;

	val = htonl(val);

	for (i = 0; i < (size & (~0x3)); i += 4)
		ptr[i >> 2] = val;

	for (; i < size; i++)
		((char *)dest)[i] = ((char *)&val)[i & 3];

	return dest;
}

static void gen_eth_hdr_data(void)
{
    struct pktgen_hdr *pktgen_hdr;
	struct udphdr *udp_hdr;
	struct iphdr *ip_hdr;

    struct ethhdr *eth_hdr = (struct ethhdr *)pkt_data;

    udp_hdr = (struct udphdr *)(pkt_data +
					    sizeof(struct ethhdr) +
					    sizeof(struct iphdr));
    ip_hdr = (struct iphdr *)(pkt_data +
                    sizeof(struct ethhdr));
    pktgen_hdr = (struct pktgen_hdr *)(pkt_data +
                        sizeof(struct ethhdr) +
                        sizeof(struct iphdr) +
                        sizeof(struct udphdr));

	printf("HELLO  1++++++++++++++++++\n");
    
    /* ethernet header */
    memcpy(eth_hdr->h_dest, &opt_txdmac, ETH_ALEN);
    memcpy(eth_hdr->h_source, &opt_txsmac, ETH_ALEN);
    eth_hdr->h_proto = htons(ETH_P_IP);

	printf("HELLO  2++++++++++++++++++\n");

    /* IP header */
	ip_hdr->version = IPVERSION;
	ip_hdr->ihl = 0x5; /* 20 byte header */
	ip_hdr->tos = 0x0;
	ip_hdr->tot_len = htons(IP_PKT_SIZE);
	ip_hdr->id = 0;
	ip_hdr->frag_off = 0;
	ip_hdr->ttl = IPDEFTTL;
	ip_hdr->protocol = IPPROTO_UDP;
	ip_hdr->saddr = htonl(0x0a140101); //192.168.1.1
	ip_hdr->daddr = htonl(0x0a140201); //192.168.2.1

    ip_hdr->check = 0;
	// ip_hdr->check = ip_fast_csum((const void *)ip_hdr, ip_hdr->ihl);
    // compute_ip_checksum(ip_hdr);

	printf("HELLO  3++++++++++++++++++\n");

    /* UDP header */
	udp_hdr->source = htons(0x1000);
	udp_hdr->dest = htons(0x1000);
	udp_hdr->len = htons(UDP_PKT_SIZE);

    /* UDP data */
	memset32_htonl(pkt_data + PKT_HDR_SIZE, opt_pkt_fill_pattern,
		       UDP_PKT_DATA_SIZE);

	/* UDP header checksum */
	udp_hdr->check = 0;
	printf("HELLO  4++++++++++++++++++\n");
	// udp_hdr->check = udp_csum(ip_hdr->saddr, ip_hdr->daddr, UDP_PKT_SIZE,
	// 			  IPPROTO_UDP, (u16 *)udp_hdr);
    // unsigned short *ipPayload = (pkt_data +
	// 				    sizeof(struct ethhdr) +
	// 				    sizeof(struct iphdr));
	// compute_udp_checksum(ip_hdr, ipPayload);
}