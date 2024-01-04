#!/bin/bash

# echo $1 $2 $3 $4
docker exec -i $1 arp -i $2 -s $3 $4
