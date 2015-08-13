#
# Cookbook Name:: mcrouter
# Spec:: folly
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

require 'spec_helper'

describe 'mcrouter::folly' do
  context 'When all attributes are default, on Ubuntu 14.04,' do
    let(:chef_run) do
      runner = ChefSpec::SoloRunner.new file_cache_path: '/tmp/chef/cache'
      runner.converge(described_recipe)
    end

    let(:folly_dir) { '/tmp/chef/cache/folly/folly' }

    it 'installs necessary dependencies' do
      expect(chef_run).to include_recipe 'mcrouter::_deps'
    end

    it 'downloads folly' do
      expect(chef_run).to put_ark('folly').with(
        url: 'https://github.com/facebook/folly/archive/v0.53.0.zip',
        path: '/tmp/chef/cache'
      )
    end

    it 'builds folly' do
      expect(chef_run).to_not run_execute('build_folly').with(
        command: 'autoreconf -ivf && ./configure && make',
        cwd: folly_dir
      )

      build_folly = chef_run.execute 'build_folly'
      expect(build_folly).to subscribe_to('ark[folly]').on(:run).immediately
    end

    it 'waits to delete the folly build dir' do
      resource = chef_run.directory 'delete folly build directory'
      expect(resource).to do_nothing
    end

    it 'waits to rebuild the static library cache' do
      resource = chef_run.execute 'rebuild_ld_so_cache'
      expect(resource).to do_nothing
    end

    it 'installs folly' do
      expect(chef_run).to run_execute('install_folly').with(
        command: 'make install',
        cwd: folly_dir,
        creates: '/usr/local/lib/libfolly.so'
      )
    end

    context 'after installing folly' do
      let(:install_folly) { chef_run.execute('install_folly') }

      it 'rebuilds the static library cache' do
        expect(install_folly).to notify('execute[rebuild_ld_so_cache]').to(:run).immediately
      end

      it 'deletes the folly build dir' do
        expect(install_folly).to notify('directory[delete folly build directory]').to :delete
      end
    end
  end
end
