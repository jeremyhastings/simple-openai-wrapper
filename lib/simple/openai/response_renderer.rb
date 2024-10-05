# frozen_string_literal: true

module Simple
  module Openai
    # The ResponseRenderer class is responsible for rendering the response using a specific strategy.
    # It allows for dynamic changes to the strategy used for rendering the response.
    class ResponseRenderer
      attr_reader :strategy

      # Initializes the ResponseRenderer with an optional strategy.
      # If no strategy is provided, it will need to be set before rendering a response.
      #
      # @param [Object, nil] strategy The strategy to be used for rendering the response. Default is nil.
      def initialize(strategy = nil)
        @strategy = strategy
      end

      # Renders the response using the assigned strategy.
      #
      # @param [Object] response The response object to be rendered.
      # @raise [RuntimeError] If no strategy is set, raises an error indicating that a strategy must be set.
      def render_response(response)
        raise "Strategy not set for ResponseRenderer" unless @strategy

        @strategy.render_response(response)
      end

      # Sets a new strategy to be used for rendering responses.
      #
      # @param [Object] new_strategy The new strategy to be used for rendering responses.
      # @return [void]
      def set_strategy(new_strategy)
        # Perform any validation or additional logic here if needed
        @strategy = new_strategy
      end
    end
  end
end
