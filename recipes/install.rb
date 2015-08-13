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

include_recipe 'mcrouter::folly'

ark 'mcrouter' do
  url "https://github.com/facebook/mcrouter/archive/#{node['mcrouter']['version']}.zip"
  path Chef::Config[:file_cache_path]
  action :put
end

mcrouter_build_dir = "#{Chef::Config[:file_cache_path]}/mcrouter"

execute 'build_mcrouter' do
  command 'autoreconf --install && ./configure && make'
  cwd "#{mcrouter_build_dir}/mcrouter"
  subscribes :run, 'ark[mcrouter]', :immediately
  action :nothing
end

# We have to use a "unique" resource name here because `ark` above already has
# a directory resource with this path as its name.
directory 'delete mcrouter build directory' do
  path      mcrouter_build_dir
  action    :nothing
  recursive true
end

execute 'install_mcrouter' do
  command 'make install'
  cwd "#{mcrouter_build_dir}/mcrouter"
  creates '/usr/local/bin/mcrouter'
  notifies :delete, 'directory[delete mcrouter build directory]'
end

user node['mcrouter']['user'] do
  system true
  shell '/bin/false'
end
