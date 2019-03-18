#
# Cookbook Name:: mcrouter
# Recipe:: _deps_ubuntu
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
include_recipe 'build-essential'

%w(
  scons
  autoconf
  binutils-dev
  bison
  cmake
  flex
  g++
  gcc
  git
  libboost1.58-all-dev
  libdouble-conversion-dev
  libevent-dev
  libgflags-dev
  libgoogle-glog-dev
  libjemalloc-dev
  libssl-dev
  libtool
  make
  pkg-config
  python-dev
  ragel
).each do |pkg|
  package pkg
end
