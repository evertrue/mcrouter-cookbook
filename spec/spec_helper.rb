require 'chefspec'
require 'chefspec/berkshelf'
require 'coveralls'

# Report coverage to Coveralls
Coveralls.wear!

# Generate a report
ChefSpec::Coverage.start!

RSpec.configure do |config|
  config.formatter = :documentation
  config.color = true
end
