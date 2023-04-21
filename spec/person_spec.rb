require 'spec_helper'

describe Person do
  before :each do
    @person = Person.new 24, 'Muhammad Aleem', true
    @book = Book.new('The Hitchhiker\'s Guide to the Galaxy', 'Douglas Adams')
    @date = Date.new(2023, 4, 21)
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
  context '#add_rental' do
    it 'creates a rental with the correct book, person, and date' do
      @person.add_rental(@book, @date)
      rental = @person.rentals.last
      expect(rental.book).to eql @book
      expect(rental.person).to eql @person
      expect(rental.date).to eql @date
    end
  end
  context '#can_use_services?' do
    it 'returns true if person is of age' do
      @person.age = 18
      expect(@person.can_use_services?).to eql true
    end
    it 'returns true if person is not of age but has parent permission' do
      @person.age = 17
      expect(@person.can_use_services?).to eql true
    end
    it 'returns false if person is not of age and does not have parent permission' do
      @person.age = 17
      @person.parent_permission = false
      expect(@person.can_use_services?).to eql false
    end
  end
  context '#correct_name' do
    it 'returns the correct name' do
      expect(@person.correct_name).to eql 'Muhammad Aleem'
    end
  end
end
