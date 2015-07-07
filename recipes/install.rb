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

mcrouter_executable = '/usr/local/bin/mcrouter'

include_recipe 'mcrouter::folly'

ark 'mcrouter' do
  url 'https://github.com/facebook/mcrouter/archive/master.zip'
  path Chef::Config[:file_cache_path]
  action :put
  not_if { File.exist?(mcrouter_executable) }
end

mcrouter_build_dir = "#{Chef::Config[:file_cache_path]}/mcrouter"

execute 'autoreconf_mcrouter' do
  command 'autoreconf --install'
  cwd "#{mcrouter_build_dir}/mcrouter"
  creates "#{mcrouter_build_dir}/mcrouter/build-aux"
  not_if { File.exist?(mcrouter_executable) }
end

execute 'install_mcrouter' do
  command './configure && make && make install'
  cwd "#{mcrouter_build_dir}/mcrouter"
  creates mcrouter_executable
end

directory mcrouter_build_dir do
  action    :delete
  recursive true
end

user node['mcrouter']['user'] do
  system true
  shell '/bin/false'
end
