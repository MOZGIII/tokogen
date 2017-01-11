# frozen_string_literal: true
require 'securerandom'
require 'tokogen/version'
require 'tokogen/generator'

module Tokogen
  def self.token(length = 32)
    default_generator.generate(length)
  end

  def self.default_generator
    generator # calling explicitly without arguments
  end

  def self.generator(randomness_source: SecureRandom, **options)
    Generator.new(randomness_source: randomness_source, **options)
  end
end
