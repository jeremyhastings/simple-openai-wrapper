# frozen_string_literal: true

# Load the library's path into the $LOAD_PATH for easy requiring
$LOAD_PATH.unshift File.expand_path("../lib", __dir__)

require "dotenv"
Dotenv.load(".env.test")

# Or directly set in code if necessary
ENV["OPENAI_API_KEY"] ||= "test_api_key"

# Load the Simple OpenAI Wrapper library
require "simple/openai/wrapper"

# Load Minitest and WebMock for testing
require "minitest/autorun"

# A setup method to ensure the environment variable is set for every test
module Minitest
  class Test
    def setup
      super
      ENV["OPENAI_API_KEY"] ||= "test_api_key"
    end
  end
end
