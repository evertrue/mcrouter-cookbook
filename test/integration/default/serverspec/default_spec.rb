require 'spec_helper'

describe 'mcrouter::default' do
  context 'installs mcrouter to the $PATH' do
    describe command 'which mcrouter' do
      its(:stdout) { is_expected.to match(%r{/usr/local/bin/mcrouter}) }
    end
  end

  context 'configures mcrouter appropriately' do
    describe file '/etc/mcrouter/mcrouter.json' do
      describe '#content' do
        subject { super().content }
        it do
          is_expected.to(
            match(
              /\{\s+"pools": \{\s+"A": \{\s+"servers": \[\s+"localhost:11811"\s+\]\s+\}\s+\},\s+"route": "PoolRoute\|A"\s+\}/
            )
          )
        end
      end
    end
  end
end
