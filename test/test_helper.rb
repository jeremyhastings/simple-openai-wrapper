# frozen_string_literal: true

# Load the library's path into the $LOAD_PATH for easy requiring
$LOAD_PATH.unshift File.expand_path("../lib", __dir__)

# Load the dotenv gem to auto-load environment variables from .env files
require "dotenv/load"

# Load the Simple OpenAI Wrapper library
require "simple/openai/wrapper"

# Load Minitest and WebMock for testing
require "minitest/autorun"
