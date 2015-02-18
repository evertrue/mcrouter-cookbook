require 'spec_helper'

describe 'mcrouter::default' do
  context 'installs mcrouter to the $PATH' do
    describe command('which mcrouter') do
      its(:stdout) { is_expected.to match(%r{/usr/local/bin/mcrouter}) }
    end
  end
end
