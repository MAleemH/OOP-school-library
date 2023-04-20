require 'json'
require './book'
require './classroom'
require './decorator'
require './nameable'
require './person'
require './rental'
require './student'
require './teacher'

class App
  attr_accessor :people, :books, :rentals

  def initialize
    @people = []
    @books = []
    @rentals = []
  end

  def list_books
    @books.each { |book| puts "Title: \"#{book.title}\", Author: #{book.author}" }
  end

  def list_people
    @people.each { |person| puts "[#{person.class}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}" }
  end

  def create_person
    print 'Do you want to create a student (1) or a teacher (2)? [Input the number]: '
    select_person = gets.chomp.to_i
    print 'Name: '
    name = gets.chomp
    print 'Age: '
    age = gets.chomp.to_i
    case select_person
    when 1
      print 'Has parent permission? [Y/N]: '
      parent_permission = gets[0].capitalize
      parent_permission = parent_permission == 'Y'
      @people << Student.new(age, nil, name, parent_permission: parent_permission)
    when 2
      print 'Specialization: '
      specialization = gets.chomp
      @people << Teacher.new(age, specialization, name)
    end
    puts 'Person created successfully'
  end

  def create_book
    print 'Title: '
    title = gets.chomp
    print 'Author: '
    author = gets.chomp
    @books << Book.new(title, author)
    puts 'Book created successfully'
  end

  def create_rental
    puts 'Select a book from the following list by number'
    @books.each_with_index { |book, index| puts "#{index}) Title: \"#{book.title}\", Author: #{book.author}" }
    book_number = gets.chomp.to_i
    puts 'Select a person from the following list by number (not id)'
    @people.each_with_index do |person, index|
      puts "#{index}) [#{person.class}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end
    person_number = gets.chomp.to_i
    print 'Date: '
    date = gets.chomp
    @rentals << Rental.new(@books[book_number], @people[person_number], date)
    puts 'Rental created successfully'
  end

  def list_rentals
    print 'ID of person: '
    id = gets.chomp.to_i
    puts 'Rentals: '
    @rentals.each do |rental|
      puts "Date: #{rental.date}, Book: \"#{rental.book.title} by #{rental.book.author}" if rental.person.id == id
    end
  end

  # store data
  def store_data
    File.write('./data/people.json', JSON.generate(@people.map(&:to_h)))
    File.write('./data/books.json', JSON.generate(@books.map(&:to_h)))
    File.write('./data/rentals.json', JSON.generate(@rentals.map(&:to_h)))
  end

  # load data
  def load_data
    if File.exist?('./data/people.json')
      @people = JSON.parse(File.read('./data/people.json')).map do |person_hash|
        case person_hash['type']
        when 'Student'
          Student.new(person_hash['age'], person_hash['id'], person_hash['name'], parent_permission: person_hash['parent_permission'])
        when 'Teacher'
          Teacher.new(person_hash['age'], person_hash['specialization'], person_hash['name'], person_hash['id'])
        end
      end
    end

    if File.exist?('./data/books.json')
      @books = JSON.parse(File.read('./data/books.json')).map do |book_hash|
        Book.new(book_hash['title'], book_hash['author'])
      end
    end

    if File.exist?('./data/rentals.json')
      @rentals = JSON.parse(File.read('./data/rentals.json')).map do |rental_hash|
        Rental.new(
          rental_hash['data'],
          rental_hash['person'],
          rental_hash['book']
        )
      end
    end
  end

  # exit handler
  def exit_handler
    store_data
  end
end
