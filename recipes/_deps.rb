#
# Cookbook Name:: mcrouter
# Recipe:: _deps
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

apt_update
build_essential 'mcrouter'

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
