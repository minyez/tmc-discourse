#!/usr/bin/env bash
# shellcheck disable=SC2164,2086
#
# Build git completely without gnutls
# to get rid of the gnutls_handshake() and curl 56 GnuTLS recv error
#
# This script is adapted from the Gist by Shawna Jean
#     https://gist.github.com/seveas/6a00d20aa40f9ca677c96eb44a6c5140
# and brought into my sight by Bee Min
#     https://unix.stackexchange.com/a/438734

inst_dir=git-test-inst
nproc=2
export LD_LIBRARY_PATH=$HOME/$inst_dir/lib
mkdir -p $inst_dir

# versions
vcurl=7.73.0
vssl=1.1.1k
vgit=2.31.1

cd $inst_dir/
[[ ! -f curl-$vcurl.tar.gz ]]   && wget https://dl.uxnr.de/mirror/curl/curl-$vcurl.tar.gz
[[ ! -f openssl-$vssl.tar.gz ]] && wget https://www.openssl.org/source/openssl-$vssl.tar.gz
[[ ! -f git-$vgit.tar.gz ]]     && wget https://mirrors.edge.kernel.org/pub/software/scm/git/git-$vgit.tar.gz 

tar -zxf openssl-$vssl.tar.gz 
cd openssl-$vssl
./config --prefix=$HOME/$inst_dir
make -j$nproc && make install
cd ../

tar -zxf curl-$vcurl.tar.gz 
cd curl-$vcurl

# Besides --without-gnutls, one also has to disable packages that may
# bring gnutls in. See https://github.com/curl/curl/issues/809
./configure --with-ssl=$HOME/$inst_dir --prefix=$HOME/$inst_dir --without-gnutls --disable-ldap
make -j$nproc && make install && (ldd -v $HOME/$inst_dir/lib/libcurl.so | grep -i gnutls) \
  && echo "Warning! libcurl.so may be linked to libgnutls."
cd ../

tar -zxf git-$vgit.tar.gz 
cd git-$vgit
make configure
./configure --prefix=$HOME/$inst_dir/ --with-openssl=$HOME/$inst_dir/ --with-curl=$HOME/$inst_dir/
make -j$nproc && make install && (ldd -v $HOME/$inst_dir/libexec/git-core/git-remote-https | grep -i gnutls) \
  && echo "Warning! git-remote-https may be linked to libgnutls."
cd ../

