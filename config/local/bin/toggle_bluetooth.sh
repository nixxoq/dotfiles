#!/bin/sh

[ $(bluetoothctl show | grep "Powered: yes" | wc -c) -eq 0 ] && bluetoothctl power on || bluetoothctl power off
