#! /bin/bash

# Arch:
pacman -Qet | awk '{print $1}' >> ~/.local/share/package-list
