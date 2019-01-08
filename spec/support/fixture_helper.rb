# frozen_string_literal: true

module Helpers
  def fixture_path
    File.absolute_path("#{__dir__}/../fixtures")
  end

  # @param [Array] extensions
  # @return [Array] flat list of paths to fixtures with a given extension
  def fixtures_with_extensions(extensions)
    extensions.map do |ext|
      Dir["#{fixture_path}/#{ext}"]
    end.flatten
  end
end
