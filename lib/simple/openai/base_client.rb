# frozen_string_literal: true

require "dotenv/load" unless ENV["RACK_ENV"] == "production"
require "net/http"
require "json"

module Simple
  module Openai
    # Base class for OpenAI API clients, providing shared functionality.
    class BaseClient
      # Custom error class for handling exceptions specific to the OpenAI API clients.
      class Error < StandardError; end

      # Initializes the client with the provided API key.
      # Raises an error if the API key is missing.
      #
      # @param [String, nil] api_key The API key for authentication. Default is fetched from ENV["OPENAI_API_KEY"].
      # @raise [Error] If the API key is missing.
      def initialize(api_key = ENV.fetch("OPENAI_API_KEY", nil))
        raise Error, "API key is missing" unless api_key

        @api_key = api_key
      end

      # Getter method for the API key. This allows subclasses to access the API key.
      #
      # @return [String] The API key.
      def api_key
        @api_key ||= ENV.fetch("OPENAI_API_KEY", nil)
      end
    end
  end
end
