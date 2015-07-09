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
      runner = ChefSpec::SoloRunner.new
      runner.converge(described_recipe)
    end

    before do
      stub_commands
    end

    folly_dir = '/opt/folly/folly'

    it 'downloads folly' do
      expect(chef_run).to put_ark('folly').with(
        url: 'https://github.com/facebook/folly/archive/v0.47.0.zip',
        path: '/opt'
      )
    end

    it 'downloads googletest' do
      expect(chef_run).to put_ark('gtest').with(
        url: 'http://googletest.googlecode.com/files/gtest-1.7.0.zip',
        path: "#{folly_dir}/test"
      )
    end

    it 'executes autoreconf_folly' do
      expect(chef_run).to run_execute('autoreconf_folly').with(
        command: 'autoreconf -ivf',
        cwd: '/opt/folly/folly',
        creates: '/opt/folly/folly/build-aux'
      )
    end

    it 'configures folly' do
      expect(chef_run).to run_execute('configure_folly').with(
        command: './configure',
        cwd: folly_dir
      )
    end

    it 'makes folly' do
      expect(chef_run).to run_execute('make_folly').with(
        command: 'make',
        cwd: folly_dir
      )
    end

    it 'checks folly' do
      expect(chef_run).to run_execute('check_folly').with(
        command: 'make check',
        cwd: folly_dir
      )
    end

    it 'installs folly' do
      expect(chef_run).to run_execute('install_folly').with(
        command: 'make install',
        cwd: folly_dir,
        creates: '/usr/local/lib/libfolly.so'
      )
    end
  end
end
