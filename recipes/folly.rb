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

git node['folly']['src_dir'] do
  repository 'https://github.com/facebook/folly.git'
  action :checkout
end

git '/opt/double-conversion' do
  repository 'https://github.com/floitsch/double-conversion.git'
  action :checkout
  not_if 'test -d /usr/include/double-conversion'
  notifies :create, 'link[/opt/double-conversion/double-conversion]', :immediately
end

link '/opt/double-conversion/double-conversion' do
  to '/opt/double-conversion/src'
  action :nothing
end

remote_file "#{node['folly']['src_dir']}/folly/test/gtest-1.6.0.zip" do
  source 'http://googletest.googlecode.com/files/gtest-1.6.0.zip'
end

execute 'unzip gtest-1.6.0.zip' do
  cwd "#{node['folly']['src_dir']}/folly/test"
  creates "#{node['folly']['src_dir']}/folly/test/gtest-1.6.0"
end

execute 'autoreconf_folly' do
  command 'autoreconf --install'
  cwd "#{node['folly']['src_dir']}/folly"
  creates "#{node['folly']['src_dir']}/folly/build-aux"
end

execute 'install_folly' do
  command %(LD_LIBRARY_PATH="#{node['mcrouter']['install_dir']}/lib:$LD_LIBRARY_PATH" ) +
    %(LD_RUN_PATH="#{node['mcrouter']['install_dir']}/lib" ) +
    %(./configure --prefix="#{node['mcrouter']['install_dir']}" && make && make install)
  cwd "#{node['folly']['src_dir']}/folly"
  creates "#{node['mcrouter']['install_dir']}/lib"
end
