# require all helpers
Dir[File.join(__dir__, 'support', '**', '*.rb')].each do |file|
  require file
end

RSpec.configure do |config|
  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.include(Helpers)
end
