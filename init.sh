#!/usr/bin/env bash

sudo apt update
sudo apt upgrade
sudo apt update
sudo apt-get install -y build-essential gcc g++ wget make autoconf zlib1g-dev \
  gettext
# if error persists in compile ssl git, also install tcl-dev tk-dev 

# install to /usr/local/
chmod +x compile_ssl_git.sh && sudo ./compile_ssl_git.sh /usr/local

