# frozen_string_literal: true

require_relative "wrapper"

module Simple
  module Openai
    # Main class for running the Simple OpenAI Wrapper Console Application.
    # This class provides an interactive console application that allows users
    # to generate text using OpenAI's API.
    class Main
      # Entry point for the Simple OpenAI Wrapper Console Application.
      # It displays a welcome message, presents a menu of options, and handles
      # user input in a loop until the user chooses to exit.
      def self.run
        puts "Welcome to Simple OpenAI Wrapper Console Application!"

        wrapper = Simple::Openai::Wrapper.new

        loop do
          puts "\nMenu:"
          puts "1) Generate Text"
          puts "Type 'EXIT' to shutdown the application."
          print "Enter your choice: "
          choice = gets.chomp

          case choice
          when "1"
            prompt = prompt_user_for_text
            response = wrapper.generate_text(prompt)
            display_response(response)
          when "EXIT", "exit"
            puts "Shutting down the application. Goodbye!"
            break
          else
            puts "Invalid choice, please try again."
          end
        end
      end

      # Prompts the user to enter a text prompt for generating text.
      # @return [String] the user's text prompt.
      def self.prompt_user_for_text
        print "Enter your prompt: "
        gets.chomp
      end

      # Displays the generated text response from the OpenAI API.
      # If the response contains valid generated text, it prints it.
      # Otherwise, it prints an error message along with the full response.
      # @param response [Hash] the response from the OpenAI API.
      def self.display_response(response)
        if response && response["choices"] && response["choices"].first
          haiku = response["choices"].first["message"]["content"]
          puts "Generated Text: #{haiku}"
        else
          puts "Failed to generate text. Response: #{response}"
        end
      end
    end
  end
end
