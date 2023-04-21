require 'spec_helper'

describe Book do
  before :each do
    @book = Book.new 'Title', 'Author'
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
end
