#
# Cookbook Name:: mcrouter
# Recipe:: default
#
# Copyright 2015 EverTrue, Inc.
# Copyright 2019 Jeff Byrnes
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

unless platform?('ubuntu') && ::Gem::Version.new(node['platform_version']) >= ::Gem::Version.new(16.04)
  Chef::Log.fatal 'This cookbook only supports Ubuntu 16.04 & 18.04'
end

apt_repository 'mcrouter' do
  uri "https://facebook.github.io/mcrouter/debrepo/#{node['lsb']['codename']}"
  components %w(contrib)
  deb_src false
  key "https://facebook.github.io/mcrouter/debrepo/#{node['lsb']['codename']}/PUBLIC.KEY"
end

apt_update
build_essential 'mcrouter'

include_recipe 'memcached::default' if node['mcrouter']['local_memcached']

user node['mcrouter']['user'] do
  system true
  shell '/bin/false'
end

package 'mcrouter'

cli_opts = node['mcrouter']['cli_opts']

[
  '/etc/mcrouter',
  File.dirname(cli_opts['log-path']),
  cli_opts['async-dir'],
  cli_opts['stats-root'],
].each do |dir|
  directory dir do
    owner node['mcrouter']['user']
    group node['mcrouter']['user']
    recursive true
  end
end

file cli_opts['config-file'] do
  content json_config(node['mcrouter']['config'])
  owner node['mcrouter']['user']
  group node['mcrouter']['user']
end

systemd_unit 'mcrouter.service' do
  content(
    Unit: {
      Description: 'mcrouter',
      After: 'network.target',
    },
    Service: {
      User: node['mcrouter']['user'],
      ExecStart: "#{node['mcrouter']['bin_path']} #{shell_opts(node['mcrouter']['cli_opts'])}",
      Restart: 'on-failure',
    },
    Install: {
      WantedBy: 'multi-user.target',
    }
  )
  action :create
end

service 'mcrouter' do
  provider Chef::Provider::Service::Systemd
  action %i(enable restart)
end
