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

    it 'checks out the folly Git repo' do
      expect(chef_run).to checkout_git('/opt/folly')
        .with repository: 'https://github.com/facebook/folly.git'
    end

    it 'does not check out the double-conversion Git repo' do
      expect(chef_run).to_not checkout_git('/opt/double-conversion')
        .with repository: 'https://github.com/floitsch/double-conversion.git'
    end

    it 'does not symlink double-conversion' do
      double_conv_link = chef_run.link '/opt/double-conversion/double-conversion'
      expect(double_conv_link).to do_nothing
    end

    it 'creates remote_file gtest-1.6.0.zip' do
      expect(chef_run).to create_remote_file('/opt/folly/folly/test/gtest-1.6.0.zip')
        .with source: 'http://googletest.googlecode.com/files/gtest-1.6.0.zip'
    end

    it 'unzips gtest-1.6.0.zip' do
      expect(chef_run).to run_execute('unzip gtest-1.6.0.zip').with(
        cwd: '/opt/folly/folly/test',
        creates: '/opt/folly/folly/test/gtest-1.6.0'
      )
    end

    it 'executes autoreconf_folly' do
      expect(chef_run).to run_execute('autoreconf_folly').with(
        command: 'autoreconf --install',
        cwd: '/opt/folly/folly',
        creates: '/opt/folly/folly/build-aux'
      )
    end

    it 'configures, makes and installs folly' do
      expect(chef_run).to run_execute('install_folly').with(
        command: 'LD_LIBRARY_PATH="/opt/mcrouter/install/lib:$LD_LIBRARY_PATH" ' \
          'LD_RUN_PATH="/opt/mcrouter/install/lib" ' \
          './configure --prefix="/opt/mcrouter/install" && make && make install',
        cwd: '/opt/folly/folly',
        creates: '/opt/mcrouter/install/lib'
      )
    end
  end
end

describe 'mcrouter::folly' do
  context 'when double-conversion is not installed, on Ubuntu 14.04,' do
    let(:chef_run) do
      runner = ChefSpec::SoloRunner.new platform: 'ubuntu', version: '14.04'
      runner.converge(described_recipe)
    end

    before do
      stub_command('test -d /usr/include/double-conversion').and_return false
    end

    it 'checks out the the double-conversion Git repo' do
      expect(chef_run).to checkout_git('/opt/double-conversion')
        .with repository: 'https://github.com/floitsch/double-conversion.git'
    end

    it 'notifies the link[/opt/double-conversion/double-conversion] to create' do
      double_conv_git = chef_run.git('/opt/double-conversion')
      expect(double_conv_git).to notify('link[/opt/double-conversion/double-conversion]')
        .to(:create).immediately
    end
  end
end
