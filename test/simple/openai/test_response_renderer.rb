# frozen_string_literal: true

require_relative "../../test_helper"
require_relative "../../../lib/simple/openai/response_renderer"

# This test file contains unit tests for the Simple::Openai::ResponseRenderer class.
# ResponseRenderer is responsible for rendering responses based on a provided strategy.
# These tests ensure that the ResponseRenderer class initializes correctly with or without a strategy,
# sets the correct strategy, and raises errors when attempting to render a response without a set strategy.
class ResponseRendererTest < Minitest::Test
  def strategy
    @strategy ||= Minitest::Mock.new
  end

  def response_renderer
    @response_renderer ||= Simple::Openai::ResponseRenderer.new
  end

  def teardown
    strategy.verify
  end

  def test_initialize_with_no_strategy
    assert_nil response_renderer.strategy
  end

  def test_initialize_with_strategy
    renderer = Simple::Openai::ResponseRenderer.new(strategy)
    assert_equal strategy.__id__, renderer.strategy.__id__
  end

  def test_render_response_with_no_strategy
    assert_raises(RuntimeError, "Strategy not set for ResponseRenderer") do
      response_renderer.render_response({ key: "value" })
    end
  end

  def test_render_response_with_strategy
    strategy.expect :render_response, nil, [{ key: "value" }]
    response_renderer.apply_strategy(strategy)
    response_renderer.render_response({ key: "value" })
  end

  def test_set_strategy
    new_strategy = Minitest::Mock.new
    response_renderer.apply_strategy(new_strategy)
    assert_equal new_strategy.__id__, response_renderer.strategy.__id__

    new_strategy.verify
  end
end
