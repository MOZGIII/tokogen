# frozen_string_literal: true
module Tokogen
  class Generator
    attr_reader :randomness_source, :alphabet

    def initialize(randomness_source:, alphabet:)
      @randomness_source = randomness_source
      @alphabet = alphabet
    end

    def generate(length)
      token_bits_amount = length * bits_per_char
      bytes_to_read = full_bytes_in_bits(token_bits_amount)
      bytes = random_bytes(bytes_to_read)
      bits = bytes.unpack('b*')[0]
      # It's possible we've read a couple exta bits of randomness,
      # since randomness is rounded to bytes.
      # Here we only take first `length` of bit that we need.
      bit_string_split(bits, bits_per_char)
        .take(length)
        .map { |index| alphabet_char(index) }
        .join
    end

    def random_bytes(size)
      @randomness_source.random_bytes(size)
    end

    def max_char_index
      @alphabet.size - 1
    end

    def bits_per_char
      max_char_index.bit_length
    end

    def full_bytes_in_bits(bits)
      (bits + 7) >> 3
    end

    private

    def bit_string_split(bits, bits_per_char, &block) # rubocop:disable Metrics/MethodLength
      top = max_char_index
      curry = 0
      last_curry = 0
      bits.each_char.each_slice(bits_per_char).map do |binary_ord|
        val = binary_ord.join.to_i(2) + curry
        last_curry = curry
        if val <= top
          current = val
          curry = 0
        else
          current = top
          curry = val % top
        end
        current
      end.each(&block)
    end

    def alphabet_char(index)
      @alphabet[index]
    end
  end
end
