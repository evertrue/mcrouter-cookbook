require 'spec_helper'

describe 'mcrouter::default' do
  context 'installs mcrouter to the $PATH' do
    describe command('which mcrouter') do
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
              /"B": \{\s+"servers": \[\s+"10.0.111.182:11811",\s+"10.0.111.155:11811"\s+\],\s+"protocol": "ascii",\s+"keep-routing_prefix": "true"\s+\}/)
          )
        end

        it do
          is_expected.to(
            match(
              /"C": \{\s+"servers": \[\s+"10.0.112.176:11811",\s+"10.0.112.15:11811"\s+\],\s+"protocol": "ascii",\s+"keep-routing_prefix": "true"\s+\}/)
          )
        end

        it do
          is_expected.to(
            match(
              /"C": \{\s+"servers": \[\s+"10.0.112.176:11811",\s+"10.0.112.15:11811"\s+\],\s+"protocol": "ascii",\s+"keep-routing_prefix": "true"\s+\}/
            )
          )
        end

        it do
          is_expected.to(
            match(
              /"D": \{\s+"servers": \[\s+"10.0.113.230:11811"\s+\],\s+"protocol": "ascii",\s+"keep-routing_prefix": "true"\s+\}/
            )
          )
        end

        it do
          is_expected.to(
            match(
              /"named_handles": \[\s+\{\s+"type": "PoolRoute",\s+"name": "zoneB",\s+"pool": "B"\s+\},\s+\{\s+"type": "PoolRoute",\s+"name": "zoneC",\s+"pool": "C"\s+\},\s+{\s+"type": "PoolRoute",\s+"name": "zoneD",\s+"pool": "D"\s+\}\s+\]/
            )
          )
        end
      end
    end
  end
end
