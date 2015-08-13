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

at_exit { ChefSpec::Coverage.report! }
