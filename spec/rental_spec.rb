require 'spec_helper'
require 'date'

describe Rental do
    book = Book.new "Title", "Author"
    person = Student.new 23, 'Full-stack' "Muhammad Asif"
    before :each do
        @rental = Rental.new book, person, Date.today
    end
    context "#new" do
        it "takes three parameters and return a student object" do
            expect(@rental).to be_an_instance_of Rental
        end
    end

    context "#rental book" do
        it "rental book must return a book object" do
            expect(@rental.book).to be_an_instance_of Book
        end
    end

    context "#rental person" do
        it "rental person must be a person object" do
            expect(@rental.person).to be_an_instance_of Person
        end
    end
end
