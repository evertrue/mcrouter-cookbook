include_recipe 'build-essential'

%w(
  autoconf
  libboost1.54-dev
  libboost-context1.54-dev
  libboost-filesystem1.54-dev
  libboost-python1.54-dev
  libboost-regex1.54-dev
  libboost-system1.54-dev
  libboost-thread1.54-dev
  libcap-dev
  libdouble-conversion-dev
  libevent-dev
  libgoogle-glog-dev
  libssl-dev
  libtool
  ragel
).each do |pkg|
  package pkg
end
