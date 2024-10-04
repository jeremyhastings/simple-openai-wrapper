# frozen_string_literal: true

module Simple
  module Openai
    # The ResponseStrategy class serves as an abstract base class for different response rendering strategies.
    # Subclasses of ResponseStrategy should implement the #render_response method with their specific rendering logic.
    class ResponseStrategy
      # Renders the response using the specific strategy implementation.
      # This method must be implemented by any subclass of ResponseStrategy.
      #
      # @param [Object] response The response object to be rendered.
      # @raise [NotImplementedError] If the method is not implemented by the subclass.
      # @return [void]
      def render_response(response)
        raise NotImplementedError, "You must implement the display_response method"
      end
    end
  end
end
