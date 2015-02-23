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
              /\{"pools": \{\s+"A": \{"servers": \["localhost:11811"\]\}\},\s+"route": "PoolRoute|A"}/
            )
          )
        end
      end
    end
  end
end
