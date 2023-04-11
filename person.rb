class Person
  attr_reader :id
  attr_accessor :name, :of_age

  def initialize(age, name = 'Unknown', parent_permission: true)
    @id = generate_id
    @name = name
    @age = age
    @parent_permission = parent_permission
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
end
