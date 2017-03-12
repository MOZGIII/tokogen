# frozen_string_literal: true
require 'spec_helper'

describe Tokogen::BitCombiner do
  let(:bit_combiner) { described_class.new(enum, width) }

  def expect_bit_combiner_to_yield(yielded)
    expect { |b| bit_combiner.each(&b) }.to yield_successive_args(*yielded)
  end

  shared_examples 'well-behaved bit combiner with specific width' do
    context 'with an array of bits' do
      let(:enum) { array.each }

      context 'with an empty string' do
        let(:array) { [] }

        it 'does not yield anything' do
          expect_bit_combiner_to_yield([])
        end
      end

      context 'with a single 0' do
        let(:array) { [0] }

        it 'yields a signle 0' do
          expect_bit_combiner_to_yield([0])
        end
      end

      context 'with a single 1' do
        let(:array) { [1] }

        it 'yields a signle 1' do
          expect_bit_combiner_to_yield([1])
        end
      end

      context 'with a `width` of 0s' do
        let(:array) { [0] * width }

        it 'yields a signle 0' do
          expect_bit_combiner_to_yield([0])
        end
      end

      context 'with a `width` of 1s' do
        let(:array) { [1] * width }

        it 'yields a signle `2 ^ (width-1)` int' do
          expect_bit_combiner_to_yield([(2**width) - 1])
        end
      end

      context 'with a single 1 and `width-1` 0s after it' do
        let(:array) { [1] + ([0] * (width - 1)) }

        it 'yields a 0 and then 0' do
          expect_bit_combiner_to_yield([1])
        end
      end

      context 'with a `width + 1` of 0s' do
        let(:array) { [0] * (width + 1) }

        it 'yields a signle 0' do
          expect_bit_combiner_to_yield([0, 0])
        end
      end

      context 'with a `width` of 0s and a 1 after them' do
        let(:array) { [0] * width + [1] }

        it 'yields a 0 and a 1' do
          expect_bit_combiner_to_yield([0, 1])
        end
      end
    end
  end

  context 'with the width of 1' do
    let(:width) { 1 }
    include_examples 'well-behaved bit combiner with specific width'
  end

  context 'with the width of 3' do
    let(:width) { 3 }
    include_examples 'well-behaved bit combiner with specific width'
  end

  context 'with the width of 8' do
    let(:width) { 8 }
    include_examples 'well-behaved bit combiner with specific width'
  end

  context 'with the width of 9' do
    let(:width) { 9 }
    include_examples 'well-behaved bit combiner with specific width'
  end

  context 'with an array of bits' do
    let(:enum) { array.each }

    context 'with a [0 1 0] and width 3' do
      let(:width) { 3 }
      let(:array) { [0, 1, 0] }

      it 'yields a 2' do
        expect_bit_combiner_to_yield([2])
      end
    end

    context 'with a [0 1 0] and width 2' do
      let(:width) { 2 }
      let(:array) { [0, 1, 0] }

      it 'yields a 2' do
        expect_bit_combiner_to_yield([2, 0])
      end
    end

    context 'with a [0 1 0] and width 1' do
      let(:width) { 1 }
      let(:array) { [0, 1, 0] }

      it 'yields a 2' do
        expect_bit_combiner_to_yield([0, 1, 0])
      end
    end
  end
end
