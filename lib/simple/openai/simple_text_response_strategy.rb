# frozen_string_literal: true

require_relative "response_strategy"

module Simple
  module Openai
    # The SimpleTextResponseStrategy class provides a concrete implementation of the ResponseStrategy.
    # It specifically handles rendering a simple text response by extracting and printing the generated text.
    class SimpleTextResponseStrategy < ResponseStrategy
      # Renders the response by extracting and printing the generated text.
      #
      # This method expects the response to be a hash with a structure similar to what OpenAI's API returns.
      # Specifically, it looks for the text in response["choices"].first["message"]["content"].
      #
      # @param [Hash] response The response object containing the generated text.
      # @raise [RuntimeError] If the provided response format is incorrect or missing expected data.
      def render_response(response)
        if response && response["choices"] && response["choices"].first
          text = response["choices"].first["message"]["content"]
          puts "Generated Text: #{text}"
        else
          puts "Failed to generate text. Response: #{response}"
        end
      end
    end
  end
end
