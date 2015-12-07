#
# Cookbook Name:: mcrouter
# Recipe:: _wangle
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
wangle_checkout_path = "#{Chef::Config[:file_cache_path]}/wangle"
wangle_build_dir = "#{wangle_checkout_path}/wangle"
wangle_lib_path = '/usr/local/lib/libwangle.a'

directory wangle_checkout_path do
  action :delete
  recursive true
  only_if { Dir.exist?(wangle_checkout_path) }
end

git wangle_checkout_path do
  repository 'https://github.com/facebook/wangle'
  revision node['mcrouter']['wangle_commit_hash']
  action :sync
end

execute 'Wangle - Clean up CMakeLists' do
  command 'sed -i -r -e "s@\ \ -lpthread@\ \ -lgflags\n\ \ -lgflags@" CMakeLists.txt'
  cwd wangle_build_dir
  not_if { File.exist?(wangle_lib_path) }
end

execute 'Wangle - prepare build' do
  command 'cmake . -DCMAKE_INSTALL_PREFIX=/usr/local -DBUILD_TESTS=OFF'
  cwd wangle_build_dir
  not_if { File.exist?(wangle_lib_path) }
end

execute 'Wangle - make' do
  command 'make'
  cwd wangle_build_dir
  not_if { File.exist?(wangle_lib_path) }
end

execute 'Wangle - make install' do
  command 'make install'
  cwd wangle_build_dir
  not_if { File.exist?(wangle_lib_path) }
end
