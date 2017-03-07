# frozen_string_literal: true
require 'securerandom'
require 'tokogen/version'
require 'tokogen/generator'
require 'tokogen/alphabet'

module Tokogen
  def self.token(length = 32)
    default_generator.generate(length)
  end

  def self.default_generator
    generator # calling explicitly without arguments
  end

  def self.generator(randomness_source: SecureRandom, alphabet: Alphabet::BASE62)
    Generator.new(randomness_source: randomness_source, alphabet: alphabet)
  end
end
