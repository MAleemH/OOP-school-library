class RentalStorage
  def self.save(rentals)
    all_rentals = rentals.map do |rental|
      { date: rental.date, book_title: rental.book.title,
        book_author: rental.book.author, person_name: rental.person.name, person_id: rental.person.id }
    end
    File.write('./data/rentals.json', JSON.generate(all_rentals))
  end

  def self.rentals
    all_rentals = []
    if File.exist?('./data/rentals.json')
      JSON.parse(File.read('./data/rentals.json')).map do |rental_hash|
        books = BookStorage.books.find { |book| book.title == rental_hash['book_title'] }
        people = PersonStorage.people.find { |person| person.id == rental_hash['person_id'] }
        new_rental = Rental.new(books, people, rental_hash['date'])
        all_rentals.push(new_rental)
      end
    end
    all_rentals
  end
end
