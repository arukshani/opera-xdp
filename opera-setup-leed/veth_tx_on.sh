#!/bin/bash

sudo ip netns exec ns1 ethtool -K vethin2 tx on
sudo ip netns exec ns2 ethtool -K vethin3 tx on
sudo ip netns exec ns3 ethtool -K vethin4 tx on
sudo ip netns exec ns4 ethtool -K vethin5 tx on
sudo ip netns exec ns5 ethtool -K vethin6 tx on
sudo ip netns exec ns6 ethtool -K vethin7 tx on
sudo ip netns exec ns7 ethtool -K vethin8 tx on
sudo ip netns exec ns8 ethtool -K vethin9 tx on