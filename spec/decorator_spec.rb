require 'spec_helper'

describe CapitalizeDecorator do
  before :each do
    @nameable = double('Nameable', correct_name: 'asif')
    @decorator = CapitalizeDecorator.new(@nameable)
  end

  describe '#correct_name' do
    it 'capitalizes the first letter of the nameable object' do
      expect(@decorator.correct_name).to eq('Asif')
    end

    it 'does not modify the original nameable object' do
      @decorator.correct_name
      expect(@nameable).to have_received(:correct_name).once
    end
  end
end

describe TrimmerDecorator do
  before :each do
    @nameable = double('Nameable', correct_name: '1234567890abcdefghij')
    @decorator = TrimmerDecorator.new(@nameable)
  end

  describe '#correct_name' do
    it 'trims the nameable object to 10 characters' do
      expect(@decorator.correct_name).to eq('1234567890')
    end

    it 'does not modify the original nameable object' do
      @decorator.correct_name
      expect(@nameable).to have_received(:correct_name).once
    end
  end
end
