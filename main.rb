require_relative 'app'
require_relative 'options'

def list_options
  'Please choose an option by entering a nubmer:
        1 - List of all books
        2 - List of all people
        3 - Add a person
        4 - Create a book
        5 - Add a rental
        6 - List of all rental for given id
        7 - Exit'
end

def main
  app = App.new
  app.load_data

  puts "Welcome to School Library App!\n\n"

  loop do
    puts list_options
    option = gets.chomp.to_i
    Options.option(option, app)
  end

  # set up exit handler
  at_exit { app.exit_handler }
end

main
