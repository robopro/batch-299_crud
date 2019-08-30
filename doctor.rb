require_relative 'setup'

class Doctor
  attr_accessor :id
  attr_reader :name, :age, :specialty

  def initialize(args = {})
    @id = args[:id]
    @name = args[:name]
    @age = args[:age]
    @specialty = args[:specialty]
  end

  def save
    # TODO: Make a method that saves data to database, and updates instance @id.
  end
end

# Websites do crud on databases
# https://www.airbnb.com/rooms/19384771
# https://www.airbnb.com/rooms/:id
#
# f.ex for table 'rooms'
# SELECT * FROM rooms WHERE id = 19384771

require 'sqlite3'

DB = SQLite3::Database.new("db/doctors.db")
DB.results_as_hash = true

results = DB.execute("SELECT * FROM doctors")
p results

doctor = Doctor.new(name: "John", age: 43, specialty: "Rocket surgeon")
p doctor
doctor.save # <= CALLING SAVE SHOULD UPDATE ID IN MEMORY
doctor.id = DB.last_insert_row_id # <= WE CAN USE THIS METHOD TO GET THE CORRECT ID.
p doctor.id
# => id=7
