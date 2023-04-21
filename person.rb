require './nameable'

class Person < Nameable
  attr_reader :id
  attr_accessor :name, :age, :rentals, :parent_permission

  def initialize(age, name = 'Unknown', id = nil, parent_permission: true)
    super()
    @id = id || generate_id
    @name = name
    @age = age
    @parent_permission = parent_permission
    @rentals = []
  end

  def generate_id
    rand(1000..9999)
  end

  def of_age?
    @age >= 18
  end

  private :of_age?

  def can_use_services?
    of_age? || @parent_permission
  end

  def correct_name
    @name
  end

  def add_rental(book, date)
    @rentals << Rental.new(book, self, date)
  end
end
