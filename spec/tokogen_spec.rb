# frozen_string_literal: true
require 'spec_helper'

describe Tokogen do
  it 'has a version number' do
    expect(Tokogen::VERSION).not_to be nil
  end

  it 'generates token of the correct length' do
    (0..1024).each do |length|
      expect(Tokogen.token(length).size).to eq length
    end
  end

  it 'generates 32 length token without arguments' do
    expect(Tokogen.token.size).to eq 32
  end
end
