#
# Cookbook Name:: mcrouter
# Spec:: default
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

describe 'mcrouter::default' do
  context 'when all attributes are default, on Ubuntu 14.04,' do
    let(:chef_run) do
      runner = ChefSpec::SoloRunner.new platform: 'ubuntu', version: '14.04'
      runner.converge(described_recipe)
    end

    before do
      stub_command('test -d /usr/include/double-conversion').and_return true
    end

    it 'ensures apt is up-to-date' do
      expect(chef_run).to include_recipe 'apt::default'
    end

    it 'installs git' do
      expect(chef_run).to include_recipe 'git::default'
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

    it 'includes the folly recipe' do
      expect(chef_run).to include_recipe 'mcrouter::folly'
    end
  end
end
