# frozen_string_literal: true

require "stringio"
require_relative "../../test_helper"
require_relative "../../../lib/simple/openai/main"
require_relative "../../../lib/simple/openai/wrapper"
require_relative "../../../lib/simple/openai/response_renderer"
require_relative "../../../lib/simple/openai/simple_text_response_strategy"

# This test file contains unit tests for the Simple::Openai::Main class.
# The Main class represents the console application that interacts with the Simple OpenAI Wrapper.
# These tests ensure that the console menu displays correctly, processes user input to generate text,
# handles invalid user inputs, and integrates correctly with the wrapper, response renderer, and strategy classes.
class MainTest < Minitest::Test
  def setup
    Simple::Openai::BaseClient.stub :new, wrapper do
      Simple::Openai::Wrapper.stub :new, wrapper do
        Simple::Openai::ResponseRenderer.stub :new, renderer do
          app
        end
      end
    end
  end

  def teardown
    # Reset standard input and output
    $stdin = STDIN
    $stdout = STDOUT

    # Verify and reset mocks
    wrapper.verify
    renderer.verify
    strategy.verify
  end

  def wrapper
    @wrapper ||= Minitest::Mock.new
  end

  def renderer
    @renderer ||= Minitest::Mock.new
  end

  def strategy
    @strategy ||= Minitest::Mock.new
  end

  def app
    @app ||= Simple::Openai::Main
  end

  def test_menu_display_and_exit
    input = StringIO.new("EXIT\n")
    output = StringIO.new
    $stdin = input
    $stdout = output

    app.run

    output.rewind
    assert_match("Welcome to Simple OpenAI Wrapper Console Application!", output.read)
  end

  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
  def test_generate_text_option
    input = StringIO.new("1\nHello, world!\nEXIT\n")
    output = StringIO.new
    $stdin = input
    $stdout = output

    wrapper.expect :generate_text, { "choices" => [{ "text" => "Hello response!" }] }, ["Hello, world!"]
    renderer.expect :apply_strategy, nil, [strategy]
    renderer.expect :render_response, nil, [{ "choices" => [{ "text" => "Hello response!" }] }]

    Simple::Openai::SimpleTextResponseStrategy.stub :new, strategy do
      Simple::Openai::Wrapper.stub :new, wrapper do
        Simple::Openai::ResponseRenderer.stub :new, renderer do
          app.run
        end
      end
    end
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength

  def test_invalid_choice
    input = StringIO.new("invalid\nEXIT\n")
    output = StringIO.new
    $stdin = input
    $stdout = output

    app.run

    output.rewind
    assert_match("Invalid choice, please try again.", output.read)
  end
end
