# frozen_string_literal: true

require_relative "base_client"

module Simple
  module Openai
    # Wrapper class to interact with the OpenAI API for generating text
    #
    # @example
    #   client = Simple::Openai::Wrapper.new
    #   response = client.generate_text("Hello, how are you?")
    #   puts response
    class Wrapper < BaseClient
      # The base URL for OpenAI API requests
      OPENAI_API_URL = "https://api.openai.com/v1/chat/completions"
      DEFAULT_MODEL = "gpt-4o-mini"
      DEFAULT_SYSTEM_MESSAGE = "You are a helpful assistant."
      SYSTEM_ROLE = "system"
      USER_ROLE = "user"
      CONTENT_TYPE = "application/json"
      AUTHORIZATION = "Authorization"

      # Generates text based on the provided prompt by making a request to the OpenAI API.
      #
      # @param [String] prompt The prompt text to be sent to the OpenAI API.
      # @param [String] model The model to be used by the OpenAI API.
      # @param [String] system_message The system message to set the assistant's behavior.
      # @return [Hash] The parsed JSON response from the OpenAI API.
      # @raise [Error] If the HTTP request fails or returns a non-successful status.
      def generate_text(prompt, model: DEFAULT_MODEL, system_message: DEFAULT_SYSTEM_MESSAGE)
        request = build_request(prompt, model, system_message)
        response = send_request(request)
        parse_response(response)
      end

      private

      # rubocop:disable Metrics/MethodLength
      # Builds an HTTP POST request to the OpenAI API.
      #
      # @param [String] prompt The prompt text to be sent to the OpenAI API.
      # @param [String] model The model to be used by the OpenAI API.
      # @param [String] system_message The system message to set the assistant's behavior.
      # @return [Net::HTTP::Post] The constructed HTTP POST request.
      def build_request(prompt, model, system_message)
        uri = URI(OPENAI_API_URL)
        Net::HTTP::Post.new(uri).tap do |request|
          request[CONTENT_TYPE] = "application/json"
          request[AUTHORIZATION] = "Bearer #{api_key}"
          request.body = {
            model: model,
            messages: [
              { role: SYSTEM_ROLE, content: system_message },
              { role: USER_ROLE, content: prompt }
            ]
          }.to_json
        end
      end
      # rubocop:enable Metrics/MethodLength

      # Sends an HTTP POST request to the OpenAI API.
      #
      # @param [Net::HTTP::Post] request The constructed HTTP POST request.
      # @return [Net::HTTPResponse] The raw HTTP response object.
      # noinspection RubyMismatchedReturnType
      def send_request(request)
        Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
          http.request(request)
        end
      end

      # Parses the HTTP response from the OpenAI API.
      #
      # @param [Net::HTTPResponse] response The raw HTTP response object.
      # @return [Hash] The parsed JSON response from the OpenAI API.
      # @raise [Error] If the HTTP request fails or returns a non-successful status.
      def parse_response(response)
        raise Error, "Error: #{response&.message}" unless response.is_a?(Net::HTTPSuccess)

        JSON.parse(response.body)
      end
    end
  end
end
