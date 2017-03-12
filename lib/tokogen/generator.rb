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
        # We split out random data into chunks of bits with fixed length.
        # Therefore it's possible to have an index value that is larger than
        # an alphabet size.
        # In this case we'd resolve to nil, so we're just using modulo of the
        # alphabet size. This will probably ruin the distribution that
        # the randromness source provides, but it will at least work.
        # If you don't want this behavior, just ensure you're using an alphabet
        # with an even size - then there will always be a bijection between
        # the generated indicies and the alphabet and the described issue
        # will never occur.
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
