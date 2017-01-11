# frozen_string_literal: true
require 'spec_helper'

describe Tokogen do
  it 'has a version number' do
    expect(Tokogen::VERSION).not_to be nil
  end
end

describe Tokogen, '.score' do
  it 'generates token of the correct length' do
    (0..1024).each do |length|
      expect(Tokogen.token(length).size).to eq length
    end
  end

  it 'generates 32 length token without arguments' do
    expect(Tokogen.token.size).to eq 32
  end
end

describe Tokogen, '.default_generator' do
  it 'build a generator' do
    expect(Tokogen.default_generator).to be_kind_of Tokogen::Generator
  end

  it 'build a generator with SecureRandom randomness source' do
    generator = Tokogen.default_generator
    expect(generator.randomness_source).to eq SecureRandom
  end
end


describe Tokogen, '.generator' do
  it 'build a generator' do
    expect(Tokogen.generator).to be_kind_of Tokogen::Generator
  end

  it 'can be called without options' do
    expect { Tokogen.generator }.to_not raise_error
  end

  it 'can be called with options' do
    expect { Tokogen.generator(randomness_source: :test_randomness_source) }.to_not raise_error
    expect { Tokogen.generator(alphabet: 'ABC') }.to_not raise_error
    expect { Tokogen.generator(randomness_source: :test_randomness_source, alphabet: 'ABC') }.to_not raise_error
  end

  it 'build different objects (does not cache anything)' do
    one = Tokogen.generator
    two = Tokogen.generator
    expect(one).to_not eq two
  end
end
