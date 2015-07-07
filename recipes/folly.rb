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

%w(
  g++
  automake
  autoconf
  autoconf-archive
  libtool
  libboost-all-dev
  libevent-dev
  libdouble-conversion-dev
  libgoogle-glog-dev
  libgflags-dev
  liblz4-dev
  liblzma-dev
  libsnappy-dev
  make
  zlib1g-dev
  binutils-dev
  libjemalloc-dev
  libssl-dev
  libiberty-dev
).each do |pkg|
  package pkg
end

folly_so = '/usr/local/lib/libfolly.so'

ark 'folly' do
  url 'https://github.com/facebook/folly/archive/v0.47.0.zip'
  path Chef::Config[:file_cache_path]
  action :put
  not_if { File.exist?(folly_so) }
end

folly_build_dir = "#{Chef::Config[:file_cache_path]}/folly"

ark 'gtest' do
  url 'http://googletest.googlecode.com/files/gtest-1.7.0.zip'
  path "#{folly_build_dir}/test"
  action :put
  not_if { File.exist?(folly_so) }
end

execute 'autoreconf_folly' do
  command 'autoreconf -ivf'
  cwd "#{folly_build_dir}/folly"
  creates "#{folly_build_dir}/build-aux"
  not_if { File.exist?(folly_so) }
end

execute 'build_install_folly' do
  command './configure && make && make install'
  cwd "#{folly_build_dir}/folly"
  creates folly_so
end

directory folly_build_dir do
  action    :delete
  recursive true
end
