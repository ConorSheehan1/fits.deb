# frozen_string_literal: true

Dir["#{__dir__}/support/*.rb"].each { |f| require f }

RSpec.configure do |config|
  config.include Helpers
  config.before do
    @fixture_path = "#{__dir__}/fixtures"
  end
end
