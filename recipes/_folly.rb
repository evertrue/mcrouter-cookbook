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
folly_checkout_path = "#{Chef::Config[:file_cache_path]}/folly"
folly_build_dir = "#{folly_checkout_path}/folly"
folly_lib_path = '/usr/local/lib/libfolly.a'
folly_build_install_command = <<-EOF
LDFLAGS=-L/usr/local/lib CPPFLAGS=-I/usr/local/include ./configure && \
make && make install
EOF

directory folly_checkout_path do
  action :delete
  recursive true
  only_if { Dir.exist?(folly_checkout_path) }
end

git folly_checkout_path do
  repository 'https://github.com/facebook/folly'
  revision node['mcrouter']['folly_commit_hash']
  action :sync
end

execute 'Folly - Prepare build ' do
  command 'autoreconf --install'
  cwd folly_build_dir
  not_if { File.exist?(folly_lib_path) }
end

execute 'Folly - Build and install folly' do
  cwd folly_build_dir
  command folly_build_install_command
  not_if { File.exist?(folly_lib_path) }
end
