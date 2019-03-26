require 'chefspec'
require 'chefspec/berkshelf'

# Generate a report
ChefSpec::Coverage.start!

RSpec.configure do |config|
  config.formatter = :documentation
  config.color = true
end
