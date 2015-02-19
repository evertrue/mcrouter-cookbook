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
      runner = ChefSpec::SoloRunner.new
      runner.converge(described_recipe)
    end

    before do
      stub_commands
    end

    it 'installs necessary dependencies' do
      %w(
        gcc-4.8
        g++-4.8
        libboost1.54-dev
        libboost-thread1.54-dev
        libboost-filesystem1.54-dev
        libboost-system1.54-dev
        libboost-regex1.54-dev
        libboost-python1.54-dev
        libboost-context1.54-dev
        ragel
        autoconf
        unzip
        libtool
        python-dev
        cmake
        libssl-dev
        libcap-dev
        libevent-dev
        libgtest-dev
        libsnappy-dev
        scons
        binutils-dev
        make
        wget
        libdouble-conversion-dev
        libgflags-dev
        libgoogle-glog-dev
      ).each do |pkg|
        expect(chef_run).to install_package(pkg)
      end
    end

    it 'updates alternatives for compilers' do
      {
        'gcc' => '4.8',
        'g++' => '4.8'
      }.each do |name, ver|
        expect(chef_run).to run_execute(
          "update-alternatives --install /usr/bin/#{name} #{name} /usr/bin/#{name}-#{ver} 50"
        )
      end
    end

    it 'checks out the mcrouter Git repo' do
      expect(chef_run).to checkout_git('/opt/mcrouter')
        .with repository: 'https://github.com/facebook/mcrouter.git'
    end

    it 'includes the folly recipe' do
      expect(chef_run).to include_recipe 'mcrouter::folly'
    end

    it 'executes autoreconf_mcrouter' do
      expect(chef_run).to run_execute('autoreconf_mcrouter').with(
        command: 'autoreconf --install',
        cwd: '/opt/mcrouter/mcrouter',
        creates: '/opt/mcrouter/mcrouter/build-aux'
      )
    end

    it 'configures, makes and installs mcrouter' do
      expect(chef_run).to run_execute('install_mcrouter').with(
        command: 'LD_LIBRARY_PATH="/opt/mcrouter/install/lib:$LD_LIBRARY_PATH" ' \
          'LD_RUN_PATH="/opt/mcrouter/pkgs/folly/folly/test/.libs:/opt/mcrouter/install/lib" ' \
          'LDFLAGS="-L/opt/mcrouter/pkgs/folly/folly/test/.libs -L/opt/mcrouter/install/lib" ' \
          'CPPFLAGS="-I/opt/mcrouter/pkgs/folly/folly/test/gtest-1.6.0/include -I/opt/mcrouter/install/include ' \
          '-I/opt/mcrouter/pkgs/folly -I/opt/mcrouter/pkgs/double-conversion" ' \
          './configure --prefix="/opt/mcrouter/install" && ' \
          'make && make install',
        cwd: '/opt/mcrouter/mcrouter',
        creates: '/opt/mcrouter/install/bin/mcrouter'
      )
    end

    it 'links mcrouter into /usr/local/bin' do
      expect(chef_run).to create_link('/usr/local/bin/mcrouter').with(
        to: '/opt/mcrouter/install/bin/mcrouter'
      )
    end
  end
end
