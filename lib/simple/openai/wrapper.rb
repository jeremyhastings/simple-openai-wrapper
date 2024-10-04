# frozen_string_literal: true

require "net/http"
require "json"

module Simple
  module Openai
    class Wrapper
      class Error < StandardError; end
      OPENAI_API_URL = "https://api.openai.com/v1/chat/completions"

      def initialize(api_key = ENV["OPENAI_API_KEY"])
        @api_key = api_key
        raise Error, "API key is missing" unless @api_key
      end

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

        raise Error, "Error: #{response.message}" unless response.is_a?(Net::HTTPSuccess)

        JSON.parse(response.body)
      end
    end
  end
end
