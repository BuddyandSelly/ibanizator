# frozen_string_literal: true

require 'spec_helper'

# Iban::Validator is a leftover copy of Ibanizator::Iban::Validator that
# lib/ibanizator.rb still loads. It cannot validate anything: it has no public
# #validate and it holds no iban, so the four methods below are only reachable
# through #send. The specs describe what the class does today; removing it is a
# change for a major version.
describe Iban::Validator do
  subject(:validator) { described_class.new }

  describe '#sanitize_input' do
    it 'strips the whitespace out of the input' do
      expect(validator.sanitize_input(' DE68 2105 0170 0012 3456 78 ')).to eq('DE68210501700012345678')
    end

    it 'takes anything that answers to_s' do
      expect(validator.sanitize_input(nil)).to eq('')
    end
  end

  describe '#valid_length?' do
    it 'is false for an iban too short to hold a country code and a checksum' do
      expect(validator.send(:valid_length?, 'DE68')).to eq(false)
    end

    it 'is false when the length does not match the country' do
      expect(validator.send(:valid_length?, 'DE6821050170001234567')).to eq(false)
    end

    it 'is true when the length matches the country' do
      expect(validator.send(:valid_length?, 'DE68210501700012345678')).to eq(true)
    end
  end

  describe '#valid_checksum?' do
    it 'is true for a correct checksum' do
      expect(validator.send(:valid_checksum?, 'DE68210501700012345678')).to eq(true)
    end

    it 'is false for a wrong checksum' do
      expect(validator.send(:valid_checksum?, 'DE00210501700012345678')).to eq(false)
    end
  end

  describe '#reorder' do
    it 'moves the first four characters to the end' do
      expect(validator.send(:reorder, 'DE68210501700012345678')).to eq('210501700012345678DE68')
    end
  end

  describe '#integerize' do
    it 'replaces every letter with its position in the alphabet plus ten' do
      expect(validator.send(:integerize, 'AB12')).to eq(101_112)
    end
  end
end
