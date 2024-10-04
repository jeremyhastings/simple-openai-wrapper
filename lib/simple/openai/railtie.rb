# frozen_string_literal: true

# lib/simple/openai/railtie.rb

require "rails/railtie"

module Simple
  module Openai
    class Railtie < Rails::Railtie
      initializer "simple.openai.configure_rails_initialization" do
        # Your Rails-related initialization code here
      end
    end
  end
end
