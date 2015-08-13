include_recipe 'build-essential'

%w(
  automake
  autoconf-archive
  libboost-all-dev
  libcap-dev
  libdouble-conversion-dev
  libevent-dev
  libgoogle-glog-dev
  libgflags-dev
  liblz4-dev
  liblzma-dev
  libsnappy-dev
  zlib1g-dev
  binutils-dev
  libjemalloc-dev
  libssl-dev
  libtool
  ragel
  libiberty-dev
).each do |pkg|
  package pkg
end
