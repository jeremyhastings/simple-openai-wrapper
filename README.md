# Simple::Openai::Wrapper

Welcome to Simple::Openai::Wrapper! This gem provides a wrapper for interacting with OpenAI's API. You can use it within a Ruby on Rails application or as a standalone console application for experimentation and documentation purposes.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'simple-openai-wrapper', path: 'path/to/your/gem'
```

And then execute:

```bash
bundle install
```

Or install it yourself as:

```bash
gem install simple-openai-wrapper
```

## Usage

### In a Ruby on Rails Application

To use the gem in a Rails application, simply add it to your `Gemfile`:

```ruby
gem 'simple-openai-wrapper', path: 'path/to/your/gem'
```

Run `bundle install` to install the gem.

### Console Application

You can also use the gem as a standalone console application to interact with the OpenAI API. After installing the gem, you can run the console app from the terminal:

```bash
bin/console_app
```

This will start the console application, which provides a simple interface for experimenting with the gem's functionality.

### Using the Wrapper

To generate text using the wrapper:

```ruby
require 'simple/openai/wrapper'

wrapper = Simple::Openai::Wrapper.new("your_openai_api_key")
response = wrapper.generate_text("What is the weather like today?")
puts response
```

### Using Response Strategies

The gem provides a flexible way to handle responses by implementing different response strategies.

#### SimpleTextResponseStrategy

A basic strategy that extracts and prints the generated text from the OpenAI API response.

```ruby
require 'simple/openai/simple_text_response_strategy'

example_response = {
  "choices" => [
    {
      "message" => {
        "content" => "This is generated text from OpenAI."
      }
    }
  ]
}

strategy = Simple::Openai::SimpleTextResponseStrategy.new
strategy.render_response(example_response)
```

## Running the Tests

To run all the tests for this gem, follow these steps:

1. Ensure all dependencies are installed:

    ```bash
    bundle install
    ```

2. Run the tests using Rake:

    ```bash
    rake test
    ```

If you are using Bundler, you can also use:

```bash
bundle exec rake test
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at [https://github.com/jeremyhastings/simple-openai-wrapper](https://github.com/jeremyhastings/simple-openai-wrapper). This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/simple-openai-wrapper/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Simple::Openai::Wrapper project's codebases, issue trackers, chat rooms, and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/simple-openai-wrapper/blob/main/CODE_OF_CONDUCT.md).