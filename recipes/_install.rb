#
# Cookbook Name:: mcrouter
# Recipe:: _install
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

mcrouter_checkout_path = "#{Chef::Config[:file_cache_path]}/mcrouter"
mcrouter_build_dir = "#{mcrouter_checkout_path}/mcrouter"
configure_command = <<-COMMAND
LD_LIBRARY_PATH="/usr/local/lib:$LD_LIBRARY_PATH" \
LD_RUN_PATH="/usr/local/lib:$LD_RUN_PATH" \
LDFLAGS="-L/usr/local/lib $LDFLAGS" \
CPPFLAGS="-I/usr/local/include $CPPFLAGS" \
./configure --prefix="#{node['mcrouter']['install_dir']}"
COMMAND
mcrouter_bin = '/usr/local/mcrouter/bin/mcrouter'

directory mcrouter_checkout_path do
  action :delete
  recursive true
  only_if { Dir.exist?(mcrouter_checkout_path) }
end

git mcrouter_checkout_path do
  repository 'https://github.com/facebook/mcrouter.git'
  checkout_branch node['mcrouter']['version-branch']
  revision node['mcrouter']['version-branch']
  action :sync
end

execute 'Mcrouter - Prepare build' do
  command 'autoreconf --install'
  cwd mcrouter_build_dir
  not_if { File.exist?(mcrouter_bin) }
end

execute 'Mcrouter - Configure' do
  cwd mcrouter_build_dir
  command configure_command
  not_if { ::File.exist?(mcrouter_bin) }
end

execute 'Mcrouter - Make' do
  command 'make -j2'
  cwd mcrouter_build_dir
  not_if { File.exist?(mcrouter_bin) }
end

execute 'Mcrouter - Make install' do
  command 'make install'
  cwd mcrouter_build_dir
  not_if { File.exist?(mcrouter_bin) }
end

directory '/usr/local/mcrouter' do
  owner node['mcrouter']['user']
  group node['mcrouter']['user']
  recursive true
end
