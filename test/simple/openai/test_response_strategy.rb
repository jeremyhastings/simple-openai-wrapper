# frozen_string_literal: true

require_relative "../../test_helper"
require_relative "../../../lib/simple/openai/response_strategy"

# This test file contains unit tests for the Simple::Openai::ResponseStrategy class.
# ResponseStrategy is a base class that other response strategies should inherit from.
# It expects subclasses to implement a specific interface for rendering responses.
# These tests ensure that the ResponseStrategy initializes correctly and raises a NotImplementedError
# when the `render_response` method is called without being implemented in a subclass.
class ResponseStrategyTest < Minitest::Test
  def strategy
    @strategy ||= Simple::Openai::ResponseStrategy.new
  end

  def test_initialization
    assert_instance_of Simple::Openai::ResponseStrategy, strategy
  end

  def test_render_response_raises_not_implemented_error
    error = assert_raises(NotImplementedError, "You must implement the display_response method") do
      strategy.render_response({ key: "value" })
    end
    assert_equal "You must implement the display_response method", error.message
  end
end
