# frozen_string_literal: true

require "dotenv/load" unless ENV["RACK_ENV"] == "production"
require "net/http"
require "json"

module Simple
  module Openai
    # Wrapper class to interact with the OpenAI API for generating text
    class Wrapper
      # Custom error class for handling exceptions specific to the Wrapper
      class Error < StandardError; end
      # The base URL for OpenAI API requests
      OPENAI_API_URL = "https://api.openai.com/v1/chat/completions"

      # Initializes the Wrapper with the provided API key.
      # Raises an error if the API key is missing.
      #
      # @param [String, nil] api_key The API key for authentication with the OpenAI API. Default is fetched from ENV["OPENAI_API_KEY"].
      # @raise [Error] If the API key is missing.
      def initialize(api_key = ENV["OPENAI_API_KEY"])
        raise Error, "API key is missing" unless api_key

        @api_key = api_key
      end

      # Generates text based on the provided prompt by making a request to the OpenAI API.
      #
      # @param [String] prompt The prompt text to be sent to the OpenAI API.
      # @return [Hash] The parsed JSON response from the OpenAI API.
      # @raise [Error] If the HTTP request fails or returns a non-successful status.
      def generate_text(prompt)
        uri = URI(OPENAI_API_URL)
        request = Net::HTTP::Post.new(uri)
        request["Content-Type"] = "application/json"
        request["Authorization"] = "Bearer #{@api_key}"

        body = {
          model: "gpt-4o-mini",
          messages: [
            { role: "system", content: "You are a helpful assistant." },
            { role: "user", content: prompt }
          ]
        }
        request.body = body.to_json

        response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
          http.request(request)
        end

        raise Error, "Error: #{response&.message}" unless response.is_a?(Net::HTTPSuccess)

        JSON.parse(response.body)
      end
    end
  end
end
