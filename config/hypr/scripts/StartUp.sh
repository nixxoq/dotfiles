#!/bin/bash

if lspci | grep -i nvidia > /dev/null; then
    env LIBVA_DRIVER_NAME=nvidia
    env GDM_BACKEND=nvidia-drm
    env __GLX_VENDOR_LIBRARY_NAME=nvidia
    env VDPAU_DRIVER,nvidia
    env NVD_BACKEND,direct
else
    env LIBVA_DRIVER_NAME=radeonsi
    env GDM_BACKEND=amd
    env __GLX_VENDOR_LIBRARY_NAME=mesa
fi
