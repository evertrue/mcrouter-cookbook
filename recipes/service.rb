#
# Cookbook Name:: mcrouter
# Recipe:: service
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

systemd_service 'mcrouter' do
  unit_description 'mcrouter'
  unit_after 'network.target'
  service_type 'simple'
  service_user node['mcrouter']['user']
  service_working_directory '/usr/local/mcrouter/'
  service_exec_start "/usr/local/mcrouter/bin/mcrouter #{shell_opts(node['mcrouter']['cli_opts'])}"
  service_restart 'on-abort'
  install_wanted_by 'multi-user.target'
  action [:create, :restart]
end
