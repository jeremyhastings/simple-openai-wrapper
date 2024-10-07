# frozen_string_literal: true

require_relative "../../test_helper"
require_relative "../../../lib/simple/openai/response_strategy"
require_relative "../../../lib/simple/openai/simple_text_response_strategy"

# This test file contains unit tests for the Simple::Openai::SimpleTextResponseStrategy class.
# The SimpleTextResponseStrategy class is a concrete implementation of the ResponseStrategy
# that formats and prints the response from the OpenAI API in a simple text format.
# These tests ensure that the SimpleTextResponseStrategy correctly renders various types of responses.
class SimpleTextResponseStrategyTest < Minitest::Test
  def strategy
    @strategy ||= Simple::Openai::SimpleTextResponseStrategy.new
  end

  # rubocop:disable Metrics/MethodLength
  def test_render_response_with_proper_response
    response = {
      "choices" => [
        {
          "message" => {
            "content" => "This is a generated text."
          }
        }
      ]
    }

    assert_output("Generated Text: This is a generated text.\n") do
      strategy.render_response(response)
    end
  end
  # rubocop:enable Metrics/MethodLength

  def test_render_response_with_improper_response
    response = { "choices" => [] }

    assert_output("Failed to generate text. Response: {\"choices\"=>[]}\n") do
      strategy.render_response(response)
    end
  end

  def test_render_response_with_no_choices
    response = { "other_key" => "value" }

    assert_output("Failed to generate text. Response: {\"other_key\"=>\"value\"}\n") do
      strategy.render_response(response)
    end
  end

  def test_render_response_with_nil_response
    assert_output("Failed to generate text. Response: \n") do
      strategy.render_response(nil)
    end
  end
end
