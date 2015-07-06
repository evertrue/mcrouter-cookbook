#
# Cookbook Name:: mcrouter
# Recipe:: install
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

ark 'mcrouter' do
  url 'https://github.com/facebook/mcrouter/archive/master.zip'
  path '/opt'
  action :put
end

execute 'autoreconf_mcrouter' do
  command 'autoreconf --install'
  cwd "#{node['mcrouter']['src_dir']}/mcrouter"
  creates "#{node['mcrouter']['src_dir']}/mcrouter/build-aux"
end

execute 'install_mcrouter' do
  command './configure && make && make install'
  cwd "#{node['mcrouter']['src_dir']}/mcrouter"
  creates '/usr/local/bin/mcrouter'
end

user node['mcrouter']['user'] do
  system true
  shell '/bin/false'
end
