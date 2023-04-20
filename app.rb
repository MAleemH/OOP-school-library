require 'json'
require './book'
require './classroom'
require './decorator'
require './nameable'
require './person'
require './rental'
require './student'
require './teacher'
require './storage/book_storage'

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
    people = @people.map do |person|
      if person.class == 'Student'
        { age: person.age, name: person.name, permission: person.parent_permission, type: person.class }
      else
        { name: person.name, age: person.age, specialization: person.specialization, type: person.class }
      end
    end

    BookStorage.save(@books)

    # rentals = @rentals.map do |rental|
    #   { date: rental.date, book_index: @books.index(rental.book), book_title: rental.book.title,
    #     book_author: rental.book.author, person_index: @people.index(rental.person), person_name: rental.person.name }
    # end

    # File.write('./data/people.json', JSON.generate(people))
    # File.write('./data/rentals.json', JSON.generate(rentals))
  end

  # load data
  def load_data
    if File.exist?('./data/people.json')
      JSON.parse(File.read('./data/people.json')).map do |person_hash|
        case person_hash['type']
        when 'Student'
          newStudent = Student.new(person_hash['age'], person_hash['id'], person_hash['name'], parent_permission: person_hash['parent_permission'])
          people.push(newStudent)
        when 'Teacher'
          newTeacher = Teacher.new(person_hash['age'], person_hash['specialization'], person_hash['name'], person_hash['id'])
          people.push(newTeacher)
        end
      end
    end
    
    @books = BookStorage.getBooks

    # if File.exist?('./data/rentals.json')
    #   JSON.parse(File.read('./data/rentals.json')).map do |rental_hash|
    #     # newRental = Rental.new(books[rental_hash['book_index']], people[rental_hash['person_index']], rental_hash['date'])
    #     rentals.push(rental_hash)
    #   end
    # end
  end

  # exit handler
  def exit_handler
    store_data
  end
end
