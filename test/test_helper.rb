# frozen_string_literal: true

require 'simplecov'
SimpleCov.start do
  add_filter '/test/'
end

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
require 'kris_kringle'

require 'minitest/autorun'
require 'minitest/focus'
require 'minitest/mock'
require 'minitest/reporters'

require 'byebug'

Minitest::Reporters.use!
