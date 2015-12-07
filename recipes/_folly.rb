#
# Cookbook Name:: mcrouter
# Recipe:: _folly
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
folly_checkout_path = file_cache_path 'folly'
folly_build_dir = "#{folly_checkout_path}/folly"
folly_build_install_command = 'LDFLAGS=-L/usr/local/lib ' \
                              'CPPFLAGS=-I/usr/local/include ./configure && ' \
                              'make && make install'

git folly_checkout_path do
  repository 'https://github.com/facebook/folly'
  revision node['mcrouter']['folly_commit_hash']
  action :sync
  notifies :run, 'execute[Folly - Prepare build]', :immediately
end

execute 'Folly - Prepare build' do
  command 'autoreconf --install'
  cwd folly_build_dir
  action :nothing
  notifies :run, 'execute[Folly - Build and install]', :immediately
end

execute 'Folly - Build and install' do
  command folly_build_install_command
  cwd folly_build_dir
  action :nothing
end
