class Book
    attr_accessor :title, :author, :rentals
    def initialize(title, author)
        @title = title
        @author = author
        @rentals = []
    end

    def add_rental(book, date)
        @rentals << Rental.new(book, self, date)
    end
end
