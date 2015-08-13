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

include_recipe 'mcrouter::_deps'

ark 'folly' do
  url 'https://github.com/facebook/folly/archive/v0.53.0.zip'
  path Chef::Config[:file_cache_path]
  action :put
end

folly_build_dir = "#{Chef::Config[:file_cache_path]}/folly"

execute 'build_folly' do
  command 'autoreconf -ivf && ./configure && make'
  cwd "#{folly_build_dir}/folly"
  subscribes :run, 'ark[folly]', :immediately
  action :nothing
end

# We have to use a "unique" resource name here because `ark` above already has
# a directory resource with this path as its name.
directory 'delete folly build directory' do
  path      folly_build_dir
  action    :nothing
  recursive true
end

execute 'rebuild_ld_so_cache' do
  command 'ldconfig'
  action  :nothing
end

execute 'install_folly' do
  command 'make install'
  cwd "#{folly_build_dir}/folly"
  creates '/usr/local/lib/libfolly.so'
  notifies :run, 'execute[rebuild_ld_so_cache]', :immediately
  notifies :delete, 'directory[delete folly build directory]'
end
