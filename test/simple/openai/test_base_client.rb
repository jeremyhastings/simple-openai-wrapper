# frozen_string_literal: true

require_relative "../../test_helper"
require_relative "../../../lib/simple/openai/base_client"

# This test file contains unit tests for the Simple::Openai::BaseClient class.
# It ensures that the BaseClient is initialized correctly with a valid API key,
# raises errors when initialized without an API key, and retrieves the API key
# either from the direct initialization or from the environment variables.
class BaseClientTest < Minitest::Test
  def valid_api_key
    "valid_api_key"
  end

  def test_initialize_with_valid_api_key
    client = Simple::Openai::BaseClient.new(valid_api_key)
    assert_equal valid_api_key, client.api_key
  end

  def test_initialize_without_api_key_raises_error
    error = assert_raises(Simple::Openai::BaseClient::Error) do
      Simple::Openai::BaseClient.new(nil)
    end
    assert_equal "API key is missing", error.message
  end

  def test_api_key_method_returns_correct_key
    client = Simple::Openai::BaseClient.new(valid_api_key)
    assert_equal valid_api_key, client.api_key
  end

  def test_api_key_is_fetched_from_env
    ENV["OPENAI_API_KEY"] = "env_api_key"
    client = Simple::Openai::BaseClient.new
    assert_equal "env_api_key", client.api_key
  ensure
    # Cleanup environment variable to not affect other tests
    ENV.delete("OPENAI_API_KEY")
  end
end
