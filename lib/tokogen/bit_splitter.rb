# frozen_string_literal: true
module Tokogen
  class BitSplitter
    BYTE_SIZE = 8

    attr_reader :size

    def initialize(bytes_enum)
      @bytes_enum = bytes_enum

      bytes_enum_size = @bytes_enum.size
      @size = bytes_enum_size * BYTE_SIZE if bytes_enum_size
    end

    def each(&block)
      enum = Enumerator.new(@bytes_enum_bit_size) do |y|
        @bytes_enum.each do |b|
          BYTE_SIZE.times do |i|
            y.yield(b[i])
          end
        end
      end
      return enum if block.nil?
      enum.each(&block)
    end
  end
end
