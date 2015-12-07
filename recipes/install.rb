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

mcrouter_build_dir = file_cache_path 'mcrouter', 'mcrouter'
install_command = "LD_LIBRARY_PATH='/usr/local/lib:$LD_LIBRARY_PATH' " \
                  "LD_RUN_PATH='/usr/local/lib:$LD_RUN_PATH' " \
                  "LDFLAGS='-L/usr/local/lib $LDFLAGS' " \
                  "CPPFLAGS='-I/usr/local/include $CPPFLAGS' " \
                  "./configure --prefix='#{node['mcrouter']['install_dir']}'"
mcrouter_bin = '/usr/local/mcrouter/bin/mcrouter'

execute 'autoreconf --install' do
  cwd mcrouter_build_dir
  creates mcrouter_bin
end

execute 'install mcrouter' do
  cwd mcrouter_build_dir
  command install_command
  creates mcrouter_bin
end

execute 'make -j2' do
  cwd mcrouter_build_dir
  creates mcrouter_bin
end

execute 'make install' do
  cwd mcrouter_build_dir
  creates mcrouter_bin
end

directory '/usr/local/mcrouter' do
  owner node['mcrouter']['user']
  group node['mcrouter']['user']
  recursive true
end
