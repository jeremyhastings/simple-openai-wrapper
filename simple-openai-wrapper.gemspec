# frozen_string_literal: true

require_relative "lib/simple/openai/version"

Gem::Specification.new do |spec|
  spec.name = "simple-openai-wrapper"
  spec.version = Simple::Openai::VERSION
  spec.authors = ["jeremyhastings"]
  spec.email = ["jeremy.hastings@mac.com"]

  spec.summary = "Simple wrapper for interacting with OpenAI's API."
  spec.description = "This gem provides a simple wrapper for interacting with OpenAI's API, useful for Ruby on Rails applications or standalone console applications."
  spec.homepage = "https://github.com/jeremyhastings/simple-openai-wrapper/"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = File.join(spec.homepage, "blob/main/CHANGELOG.md")

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Runtime dependencies
  spec.add_dependency "dotenv", "~> 3.1.4"
  spec.add_dependency "httparty", "~> 0.18"
  spec.add_dependency "json", "~> 2.5"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
