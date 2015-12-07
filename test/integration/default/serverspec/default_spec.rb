require 'spec_helper'

describe 'mcrouter::default' do

  context 'configures mcrouter appropriately' do
    %w(
      /etc/mcrouter
      /var/spool/mcrouter
      /var/log/mcrouter
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
          is_expected.to(
            match(/\{\s+"pools": \{\s+"A": \{\s+"servers": \[\s+"localhost:11811"\s+\]\s+\}\s+\},\s+"route": "PoolRoute\|A"\s+\}/)
          )
        end
      end
    end
  end
end
