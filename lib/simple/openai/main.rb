# frozen_string_literal: true

require_relative "response_renderer"
require_relative "simple_text_response_strategy"
require_relative "wrapper"

module Simple
  module Openai
    # Main class for running the Simple OpenAI Wrapper Console Application.
    # This class provides an interactive console application that allows users
    # to generate text using OpenAI's API.
    class Main
      # rubocop:disable all
      # Entry point for the Simple OpenAI Wrapper Console Application.
      # It displays a welcome message, presents a menu of options, and handles
      # user input in a loop until the user chooses to exit.
      def self.run
        puts "Welcome to Simple OpenAI Wrapper Console Application!"

        wrapper = Simple::Openai::Wrapper.new
        renderer = Simple::Openai::ResponseRenderer.new

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
            strategy = Simple::Openai::SimpleTextResponseStrategy.new
            renderer.apply_strategy(strategy)
            renderer.render_response(response)
          when "EXIT", "exit"
            puts "Shutting down the application. Goodbye!"
            break
          else
            puts "Invalid choice, please try again."
          end
        end
      end
      # rubocop:enable all

      # Prompts the user to enter a text prompt for generating text.
      # @return [String] the user's text prompt.
      def self.prompt_user_for_text
        print "Enter your prompt: "
        gets.chomp
      end
    end
  end
end
