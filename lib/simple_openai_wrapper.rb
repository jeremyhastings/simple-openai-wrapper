# frozen_string_literal: true

require "simple/openai/version"
require "simple/openai/railtie" if defined?(Rails)
require "simple/openai/wrapper"
require "simple/openai/main"

# The Simple module serves as a namespace for the Openai gem.
# It encapsulates all classes and modules related to this gem.
module Simple
  # The Openai module contains all the functionality for interacting with OpenAI services.
  # It also includes initialization code and any main configurations required for the gem to work.
  module Openai
    # Add any additional initialization code or main gem module functionality below:
    #
    # NOTE: This is a placeholder comment to indicate where custom initialization logic or
    #       additional configuration can be added according to the gem's requirements.
  end
end
