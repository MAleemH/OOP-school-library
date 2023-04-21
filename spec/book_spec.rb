require 'spec_helper'

describe Book do
  before :each do
    @person = Person.new 24, 'Muhammad Aleem', true
    @book = Book.new 'Title', 'Author'
    @date = Date.new(2023, 4, 21)
  end
  context '#new' do
    it 'takes two parameters and return a book object' do
      expect(@book).to be_an_instance_of Book
    end
  end
  context '#title' do
    it 'returns the correct title' do
      expect(@book.title).to eql 'Title'
    end
  end
  context '#author' do
    it 'returns the correct author' do
      expect(@book.author).to eql 'Author'
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
end
