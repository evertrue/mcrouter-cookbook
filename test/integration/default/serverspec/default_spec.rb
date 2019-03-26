require 'spec_helper'

describe 'mcrouter::default' do
  context 'installs mcrouter to the $PATH' do
    describe command 'which mcrouter' do
      its(:stdout) { is_expected.to match(%r{/usr/bin/mcrouter}) }
    end
  end

  context 'configures mcrouter appropriately' do
    %w(
      /etc/mcrouter
      /var/spool/mcrouter
      /var/log/mcrouter
    ).each do |dir|
      describe file dir do
        it { is_expected.to be_directory }
        it { is_expected.to be_owned_by 'mcrouter' }
        it { is_expected.to be_grouped_into 'mcrouter' }
      end
    end

    describe file '/etc/mcrouter/mcrouter.json' do
      describe '#content' do
        subject { super().content }
        it do
          is_expected.to(
            match(/\{\s+"pools": \{\s+"A": \{\s+"servers": \[\s+"localhost:11811"\s+\]\s+\}\s+\},\s+"route": "PoolRoute\|A"\s+\}/)
          )
        end
      end
    end
  end

  context 'sets up the mcrouter service' do
    describe service 'mcrouter' do
      it { is_expected.to be_enabled }
      it { is_expected.to be_running }
    end
  end
end
