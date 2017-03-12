# frozen_string_literal: true
require 'spec_helper'

describe Tokogen::BitSplitter do
  let(:bit_splitter) { described_class.new(enum) }

  def expect_bit_splitter_to_yield(yielded)
    expect { |b| bit_splitter.each(&b) }.to yield_successive_args(*yielded)
  end

  context 'with an array of bytes' do
    let(:enum) { array.each }

    context 'with an empty array' do
      let(:array) { [] }

      it 'does not yield anything' do
        expect_bit_splitter_to_yield([])
      end
    end

    context 'with an array of [15]' do
      let(:array) { [15] }

      it 'yields bits that match the manually entered example' do
        expect_bit_splitter_to_yield([1, 1, 1, 1, 0, 0, 0, 0])
      end
    end

    context 'with a sample array' do
      let(:array) { (0..0xFF).to_a }
      # Stages here are simply describing the logic we want from the system.
      let(:sample) do
        array.flat_map do |e|
          # We want to yield least significant bits first because there is
          # an arbitrary number of zeroes after the mpst significant bit,
          # and reader could choose to read only the beginning of the
          # actual data that we've accumulated (and not those zero bits of
          # nothingness). In example user could read three least important
          # bits with `.take(3)`.
          string = e.chr.unpack('b*').first
          # Finally, we have to split our string of zeroes and ones into
          # an array of integers.
          string.split('').map(&:to_i)
        end
      end

      it 'yields bits that match the slower but logicaly correct alternating algorithm' do
        expect_bit_splitter_to_yield(sample)
      end
    end
  end

  context 'with binary string' do
    let(:enum) { buff.each_byte }

    context 'with an empty string' do
      let(:buff) { '' }

      it 'does not yield anything' do
        expect_bit_splitter_to_yield([])
      end
    end

    context 'with a binary string of a single bit' do
      let(:buff) { 1.chr }

      it 'yield a full byte with unsigned value of 1' do
        expect_bit_splitter_to_yield([1, 0, 0, 0, 0, 0, 0, 0])
      end
    end

    context 'with a `hello` string' do
      let(:buff) { 'hello' }
      let(:sample) do
        [
          0, 0, 0, 1, 0, 1, 1, 0, #  22 if LSB last, 104 if LSB first (reverse), 'h'
          1, 0, 1, 0, 0, 1, 1, 0, # 166 if LSB last, 101 if LSB first (reverse), 'e'
          0, 0, 1, 1, 0, 1, 1, 0, #  54 if LSB last, 108 if LSB first (reverse), 'l'
          0, 0, 1, 1, 0, 1, 1, 0, #  54 if LSB last, 108 if LSB first (reverse), 'l'
          1, 1, 1, 1, 0, 1, 1, 0  # 246 if LSB last, 111 if LSB first (reverse), 'o'
        ]
      end

      it 'yield a full byte with unsigned value of 1' do
        expect_bit_splitter_to_yield(sample)
      end
    end
  end
end
