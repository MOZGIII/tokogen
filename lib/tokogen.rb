# frozen_string_literal: true
require 'securerandom'
require 'tokogen/version'
require 'tokogen/generator'

module Tokogen
  def self.token(length = 32)
    default_generator.generate(length)
  end

  def self.default_generator
    Generator.new(randomness_source: SecureRandom)
  end
end
