#
# Cookbook Name:: mcrouter
# Spec:: _deps
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

describe 'mcrouter::_deps_ubuntu' do
  context 'when all attributes are default, on Ubuntu 14.04,' do
    let(:chef_run) do
      ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '14.04')
                            .converge described_recipe
    end

    it 'installs necessary dependencies' do
      %w(
        automake
        autoconf-archive
        libboost-all-dev
        libcap-dev
        libdouble-conversion-dev
        libevent-dev
        libgoogle-glog-dev
        libgflags-dev
        liblz4-dev
        liblzma-dev
        libsnappy-dev
        zlib1g-dev
        binutils-dev
        libjemalloc-dev
        libssl-dev
        libtool
        ragel
        libiberty-dev
      ).each do |pkg|
        expect(chef_run).to install_package(pkg)
      end
    end
  end
end
