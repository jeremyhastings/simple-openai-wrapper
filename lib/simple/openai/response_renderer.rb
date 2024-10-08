# frozen_string_literal: true

require_relative "response_strategy"

module Simple
  module Openai
    # The ResponseRenderer class is responsible for rendering the response using a specific strategy.
    # It allows for dynamic changes to the strategy used for rendering the response.
    class ResponseRenderer
      attr_reader :strategy

      # Initializes the ResponseRenderer with an optional strategy.
      # If no strategy is provided, a default strategy will be used.
      #
      # @param [Simple::Openai::ResponseStrategy] strategy The strategy to be used for rendering the response.
      #   Default is an instance of Simple::Openai::ResponseStrategy.
      def initialize(strategy = Simple::Openai::ResponseStrategy.new)
        @strategy = strategy
      end

      # Renders the response using the assigned strategy.
      #
      # @param [Object] response The response object to be rendered.
      # @raise [RuntimeError] If no strategy is set, raises an error indicating that a strategy must be set.
      def render_response(response)
        raise "Strategy not set. Please set a strategy before rendering responses." unless @strategy

        @strategy.render_response(response)
      end

      # Sets a new strategy to be used for rendering responses.
      #
      # @param [Simple::Openai::ResponseStrategy] new_strategy The new strategy to be used for rendering responses.
      # @raise [ArgumentError] If the new strategy does not respond to `render_response`.
      # @return [void]
      def apply_strategy(new_strategy)
        unless new_strategy.respond_to?(:render_response)
          raise ArgumentError, "New strategy must respond to `render_response`"
        end

        @strategy = new_strategy
      end
    end
  end
end
