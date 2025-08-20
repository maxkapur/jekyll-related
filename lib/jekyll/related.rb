# frozen_string_literal: true

require_relative "related/version"
require_relative "generator"
require_relative "tag"

module Jekyll
  module Related
    DEFAULT_CONFIG = {
      "count" => nil,
      "factor" => 10.0
    }
  end
end
