#
# Cookbook Name:: mcrouter
# Recipe:: _double_conversion
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
double_conversion_checkout_path = "#{Chef::Config[:file_cache_path]}/double-conversion"
install_dir = '/usr/local'
include_file = '/usr/local/lib/libdouble-conversion.a'

directory double_conversion_checkout_path do
  action :delete
  recursive true
  only_if { Dir.exist?(double_conversion_checkout_path) }
end

git double_conversion_checkout_path do
  repository 'https://github.com/google/double-conversion.git'
  revision node['mcrouter']['double_conversion_commit_hash']
  action :sync
  notifies :run, 'execute[Double-conversion - prepare build]'
end

execute 'Double-conversion - prepare build' do
  cwd double_conversion_checkout_path
  command "cmake . -DBUILD_SHARED_LIBS=ON -DCMAKE_INSTALL_PREFIX=#{install_dir}"
  notifies :run, 'execute[Double-Conversion - Build and install]'
  not_if { File.exist?(include_file) }
end

execute 'Double-Conversion - Build and install' do
  command 'make && make install'
  cwd double_conversion_checkout_path
  not_if { File.exist?(include_file) }
end

Dir.glob("#{double_conversion_checkout_path}/double-conversion/*.h") do |filename|
  file "/usr/local/include/double-conversion/#{Pathname.new(filename).basename}" do
    owner node['mcrouter']['user']
    mode 0o0660
    content lazy { IO.binread(filename) }
    not_if { File.exist?("/usr/local/include/double-conversion/#{Pathname.new(filename).basename}") }
  end
end
