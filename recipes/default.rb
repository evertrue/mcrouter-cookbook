#
# Cookbook Name:: mcrouter
# Recipe:: default
#
# Copyright 2015 EverTrue, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

include_recipe 'apt::default'
include_recipe 'git::default'

%w(
  gcc-4.8
  g++-4.8
  libboost1.54-dev
  libboost-thread1.54-dev
  libboost-filesystem1.54-dev
  libboost-system1.54-dev
  libboost-regex1.54-dev
  libboost-python1.54-dev
  libboost-context1.54-dev
  ragel
  autoconf
  unzip
  libtool
  python-dev
  cmake
  libssl-dev
  libcap-dev
  libevent-dev
  libgtest-dev
  libsnappy-dev
  scons
  binutils-dev
  make
  wget
  libdouble-conversion-dev
  libgflags-dev
  libgoogle-glog-dev
).each do |pkg|
  package pkg
end

{
  'gcc' => '4.8',
  'g++' => '4.8'
}.each do |name, ver|
  execute "update-alternatives --install /usr/bin/#{name} #{name} /usr/bin/#{name}-#{ver} 50"
end

git '/opt/mcrouter' do
  repository 'https://github.com/facebook/mcrouter.git'
  action :checkout
end

include_recipe 'mcrouter::folly'

execute 'autoreconf_mcrouter' do
  command 'autoreconf --install'
  cwd '/opt/mcrouter/mcrouter'
  creates '/opt/mcrouter/mcrouter/build-aux'
end

execute 'install_mcrouter' do
  command 'LD_LIBRARY_PATH="/opt/mcrouter/install/lib:$LD_LIBRARY_PATH" ' \
      'LD_RUN_PATH="/opt/mcrouter/pkgs/folly/folly/test/.libs:/opt/mcrouter/install/lib" ' \
      'LDFLAGS="-L/opt/mcrouter/pkgs/folly/folly/test/.libs -L/opt/mcrouter/install/lib" ' \
      'CPPFLAGS="-I/opt/mcrouter/pkgs/folly/folly/test/gtest-1.6.0/include -I/opt/mcrouter/install/include ' \
      '-I/opt/mcrouter/pkgs/folly -I/opt/mcrouter/pkgs/double-conversion" ' \
      './configure --prefix="/opt/mcrouter/install" && ' \
      'make && make install'
  cwd '/opt/mcrouter/mcrouter'
  creates '/opt/mcrouter/install/bin/mcrouter'
end

link '/usr/local/bin/mcrouter' do
  to '/opt/mcrouter/install/bin/mcrouter'
end
