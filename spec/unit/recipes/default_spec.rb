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
      runner = ChefSpec::SoloRunner.new
      runner.converge(described_recipe)
    end

    before do
      stub_commands
    end

    it 'ensures apt is up-to-date' do
      expect(chef_run).to include_recipe 'apt::default'
    end

    it 'includes ark' do
      expect(chef_run).to include_recipe 'ark::default'
    end

    it 'installs and starts memcached' do
      expect(chef_run).to include_recipe 'memcached::default'
    end

    it 'installs mcrouter & its dependencies' do
      expect(chef_run).to include_recipe 'mcrouter::install'
    end

    it 'configured mcrouter' do
      expect(chef_run).to include_recipe 'mcrouter::configure'
    end
  end
end
