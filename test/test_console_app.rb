# frozen_string_literal: true

require "minitest/autorun"
require "open3"

# This test class verifies the behavior of the Simple OpenAI Wrapper Console Application.
# It ensures that when the console application runs, it displays the appropriate menu,
# handles user input correctly, and exits gracefully when the 'EXIT' command is issued.
class ConsoleAppTest < Minitest::Test
  def test_console_app_runs_and_interacts
    # Using Open3.popen3 to interact with the running console application
    Open3.popen3("./bin/console_app") do |stdin, stdout, stderr, wait_thr|
      # Send 'EXIT' to the stdin to gracefully shut down the application
      stdin.puts "EXIT"
      stdin.close

      # Read all output from stdout and stderr
      output = stdout.read
      error_output = stderr.read

      # Ensure the correct status returned
      assert_equal true, wait_thr.value.success?, "Process failed with errors: #{error_output}"

      # Check if the welcome message and the menu were in the output
      assert_includes output, "Welcome to Simple OpenAI Wrapper Console Application!"

      assert_includes output, "Menu:"
      assert_includes output, "1) Generate Text"
      assert_includes output, "Type 'EXIT' to shutdown the application."
      assert_includes output, "Enter your choice:"

      # Ensure we see a goodbye message
      assert_includes output, "Shutting down the application. Goodbye!"
    end
  end
end
