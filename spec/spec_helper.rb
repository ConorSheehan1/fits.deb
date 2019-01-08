RSpec.configure do |config|
  # config.file_fixture_path = "#{__dir__}/fixtures"
  config.before do
    @fixture_path = "#{__dir__}/fixtures"
  end
end
