#
# Cookbook Name:: mcrouter
# Recipe:: configure
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

%w(
  /etc/mcrouter
  /var/run/mcrouter
  /mnt/mcrouter
  /mnt/mcrouter/log
  /mnt/mcrouter/spool
  /mnt/mcrouter/stats
).each do |dir|
  directory dir do
    owner 'mcrouter'
    group 'mcrouter'
  end
end

file '/etc/mcrouter/mcrouter.json' do
  content json_config(node['mcrouter']['config'])
  owner 'mcrouter'
  group 'mcrouter'
end
