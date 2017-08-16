#
# Cookbook Name:: mcrouter
# Spec:: install
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

describe 'mcrouter::install' do
  context 'when all attributes are default, on Ubuntu 14.04,' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(file_cache_path: '/tmp/chef/cache')
                            .converge(described_recipe)
    end

    let(:mcrouter_build_dir) { '/tmp/chef/cache/mcrouter' }

    it 'downloads mcrouter' do
      expect(chef_run).to put_ark('mcrouter').with(
        url: 'https://github.com/facebook/mcrouter/archive/v0.5.0.zip',
        path: '/tmp/chef/cache'
      )
    end

    it 'builds mcrouter' do
      expect(chef_run).to_not run_execute('build_mcrouter').with(
        command: 'autoreconf --install && ./configure && make',
        cwd: "#{mcrouter_build_dir}/mcrouter"
      )

      build_mcrouter = chef_run.execute 'build_mcrouter'
      expect(build_mcrouter).to subscribe_to('ark[mcrouter]').on(:run).immediately
    end

    it 'waits to delete the mcrouter build dir' do
      resource = chef_run.directory 'delete mcrouter build directory'
      expect(resource).to do_nothing
    end

    it 'installs mcrouter' do
      expect(chef_run).to run_execute('install_mcrouter').with(
        command: 'make install',
        cwd: "#{mcrouter_build_dir}/mcrouter",
        creates: '/usr/local/bin/mcrouter'
      )
    end

    context 'after installing mcrouter' do
      it 'deletes the mcrouter build dir' do
        install_mcrouter = chef_run.execute('install_mcrouter')
        expect(install_mcrouter).to notify('directory[delete mcrouter build directory]').to :delete
      end
    end

    it 'creates a mcrouter user' do
      expect(chef_run).to create_user('mcrouter').with(
        system: true,
        shell: '/bin/false'
      )
    end
  end
end
