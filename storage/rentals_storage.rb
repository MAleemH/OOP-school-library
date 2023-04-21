require 'pry'
# require 'book_storage'
# require 'person_storage'

class RentalStorage
  def self.save(rentals)
    all_rentals = rentals.map do |rental|
      # binding.pry
      { date: rental.date, book_title: rental.book.title,
        book_author: rental.book.author, person_name: rental.person.name, person_id: rental.person.id }
    end
    File.write('./data/rentals.json', JSON.generate(all_rentals))
  end

  def self.get_rentals
    all_rentals = []
    if File.exist?('./data/rentals.json')
      JSON.parse(File.read('./data/rentals.json')).map do |rental_hash|
        books = BookStorage.get_books.find { |book| book.title == rental_hash['book_title'] }
        people = PersonStorage.get_people.find { |person| person.id == rental_hash['person_id'] }
        binding.pry
        newRental = Rental.new(books, people, rental_hash['date'])
        all_rentals.push(newRental)
      end
    end
    all_rentals
  end
end
