# frozen_string_literal: true

require "test_helper"

class Simple::Openai::TestWrapper < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Simple::Openai::Wrapper::VERSION
  end

  def test_it_does_something_useful
    assert false
  end
end
