require 'pry'
class PersonStorage
  
  def self.save(people)
    all_people = people.map do |person|
      if person.class.name == 'Student'
        { age: person.age, name: person.name, permission: person.parent_permission, type: person.class }
      else
        { name: person.name, age: person.age, specialization: person.specialization, type: person.class }
      end
    end

    File.write('./data/people.json', JSON.generate(all_people))
  end

  def self.getPeople
    people = []
    if File.exist?('./data/people.json')
      JSON.parse(File.read('./data/people.json')).map do |person_hash|
        case person_hash['type']
        when 'Student'
          newStudent = Student.new(person_hash['age'], person_hash['id'], person_hash['name'], parent_permission: person_hash['parent_permission'])
          people.push(newStudent)
        when 'Teacher'
          newTeacher = Teacher.new(person_hash['age'], person_hash['specialization'], person_hash['name'])
          people.push(newTeacher)
        end
      end
    end
    people
  end

end