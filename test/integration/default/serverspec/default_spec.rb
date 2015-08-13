require 'spec_helper'

describe 'mcrouter::default' do
  context 'installs mcrouter to the $PATH' do
    describe command 'which mcrouter' do
      its(:stdout) { is_expected.to match(%r{/usr/local/bin/mcrouter}) }
    end
  end

  context 'configures mcrouter appropriately' do
    %w(
      /etc/mcrouter
      /var/spool/mcrouter
      /var/log/mcrouter
      /var/run/mcrouter
      /var/mcrouter/stats
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
          # rubocop:disable Style/LineLength
          is_expected.to(
            match(/\{\s+"pools": \{\s+"A": \{\s+"servers": \[\s+"localhost:11811"\s+\]\s+\}\s+\},\s+"route": "PoolRoute\|A"\s+\}/)
          )
          # rubocop:enable Style/LineLength
        end
      end
    end
  end

  context 'sets up the mcrouter service' do
    describe file '/etc/init/mcrouter.conf' do
      describe '#content' do
        subject { super().content }
        it do
          is_expected.to(include('exec /usr/local/bin/mcrouter --port 11211 ' \
                                 '--config-file /etc/mcrouter/mcrouter.json ' \
                                 '--async-dir /var/spool/mcrouter ' \
                                 '--log-path /var/log/mcrouter/mcrouter.log ' \
                                 '--pid-file /var/run/mcrouter/mcrouter.pid ' \
                                 '--stats-root /var/mcrouter/stats'))
        end
      end
    end

    describe service 'mcrouter' do
      it { is_expected.to be_enabled }
      it { is_expected.to be_running }
    end
  end

  context 'cleans up unnecessary build directories' do
    %w(folly mcrouter).each do |build_dir|
      describe file "/tmp/kitchen/cache/#{build_dir}" do
        it { is_expected.to_not be_directory }
      end
    end
  end
end
