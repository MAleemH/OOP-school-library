require 'spec_helper'

describe Person do
  before :each do
    @person = Person.new 24, 'Muhammad Aleem', true
  end
  context '#age' do
    it 'returns the correct age' do
      expect(@person.age).to eql 24
    end
  end
  context '#name' do
    it 'returns the correct name' do
      expect(@person.name).to eql 'Muhammad Aleem'
    end
  end
  context '#parent_permission' do
    it 'returns the correct parent_permission' do
      expect(@person.parent_permission).to eql true
    end
  end
end
