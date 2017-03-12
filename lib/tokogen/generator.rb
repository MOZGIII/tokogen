# frozen_string_literal: true
module Tokogen
  class Generator
    class AssertionFail < StandardError; end

    attr_reader :randomness_source, :alphabet

    def initialize(randomness_source:, alphabet:)
      @randomness_source = randomness_source
      @alphabet = alphabet

      @alphabet_size = @alphabet.size
      @max_char_index = @alphabet_size - 1
      @bits_per_char = @max_char_index.bit_length
    end

    def generate(length) # rubocop:disable Metrics/AbcSize
      token_bits_amount = length * @bits_per_char
      bytes_to_read = full_bytes_in_bits(token_bits_amount)
      bytes = random_bytes(bytes_to_read)
      splitter = BitSplitter.new(bytes.each_byte)
      combiner = BitCombiner.new(splitter.each, @bits_per_char)
      # It's possible we've read a couple exta bits of randomness,
      # since randomness is rounded to bytes.
      # Here we only take first `length` of bit that we need.
      indexes = combiner.each.take(length)
      raise AssertionFail, 'Invalid length' if indexes.size != length
      indexes.map do |index|
        # We accumulates indexes as a set of indexes
        alphabet_char(index % @alphabet_size)
      end.join
    end

    def random_bytes(size)
      @randomness_source.random_bytes(size)
    end

    def alphabet_char(index)
      @alphabet[index]
    end

    private

    def full_bytes_in_bits(bits)
      (bits + 7) >> 3
    end
  end
end
