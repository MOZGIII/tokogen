# frozen_string_literal: true
module Tokogen
  class BitCombiner
    attr_reader :size

    def initialize(bits_enum, width_in_bits)
      @bits_enum = bits_enum
      @width_in_bits = width_in_bits

      bits_enum_size = @bits_enum.size
      @size = bits_enum_size / @width_in_bits if bits_enum_size
    end

    def each(&block) # rubocop:disable Metrics/MethodLength
      enum = Enumerator.new(@size) do |y|
        @bits_enum.each_slice(@width_in_bits) do |slice|
          num = 0
          slice.size.times do |i|
            num |= (slice[i] << i)
          end
          y.yield(num)
        end
      end
      return enum if block.nil?
      enum.each(&block)
    end
  end
end
