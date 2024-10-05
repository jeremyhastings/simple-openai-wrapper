# frozen_string_literal: true

require "rails/railtie"

# This file defines a Railtie for the Simple::Openai module, which allows the gem to integrate
# with Ruby on Rails applications. A Railtie is the core of the Rails framework and provides
# hooks to extend Rails capabilities in an application or engine.
module Simple
  module Openai
    # The Railtie class for the Simple::Openai module.
    #
    # Railties are a major component used in the initialization process of a Rails application.
    # They allow gems or libraries to hook into important events during the bootstrapping
    # process of the Rails application.
    #
    # This class inherits from Rails::Railtie, thereby gaining the ability to utilize the
    # Railtie API to enhance or modify the behavior of a Rails application when the gem is included.
    class Railtie < Rails::Railtie
      # The initializer block allows us to define code that should run at a certain point in the
      # Rails initialization process. In this case, the `simple.openai.configure_rails_initialization`
      # initializer is created to run any configuration specific to the Simple::Openai module.
      #
      # Initializers are a way to set up configurations, specify dependencies, and generally
      # prepare the environment before the rest of the application loads.
      #
      # Usage:
      # To customize the setup of this gem in a Rails application, place necessary code inside
      # this initializer block. This can include setting configuration defaults, requiring
      # necessary files, or defining middleware.
      #
      # Example (Inside the initializer block):
      # initializer "simple.openai.configure_rails_initialization" do
      #   Rails.application.config.simple_openai = ActiveSupport::OrderedOptions.new
      #   Rails.application.config.simple_openai.api_key = ENV["OPENAI_API_KEY"]
      # end
      #
      initializer "simple.openai.configure_rails_initialization" do
        # Your Rails-related initialization code here.
        #
        # Placeholder for any code that needs to be executed during the Rails initialization
        # process related to the Simple::Openai module.
        #
        # This is where you can put code that sets up configuration options, dependencies,
        # or any other preparatory tasks necessary to integrate this module with a Rails application.
      end
    end
  end
end
