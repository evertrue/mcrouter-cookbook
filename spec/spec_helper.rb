require 'chefspec'
require 'chefspec/berkshelf'
require 'coveralls'

Coveralls.wear!

RSpec.configure do |config|
  config.formatter = :documentation
  config.color = true
  config.platform = 'ubuntu'
  config.version = '14.04'
end

def stub_commands
  stub_command('test -d /usr/include/double-conversion').and_return true
end

at_exit { ChefSpec::Coverage.report! }
