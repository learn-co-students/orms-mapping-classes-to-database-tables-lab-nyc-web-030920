require 'sqlite3'
class Student

  attr_accessor  :name, :grade
  attr_reader  :id
  def initialize(name, grade)
@name=name
@grade=grade

  end
def self.create_table
  table = <<-SQL
  CREATE TABLE IF NOT EXISTS students (
    id INTEGER PRIMARY KEY,
    name TEXT,
    grade INTEGER
  )
  SQL
  DB[:conn].execute(table)
end

def self.drop_table
  drop_table = <<-SQL
    DROP TABLE IF EXISTS students
  SQL
  DB[:conn].execute(drop_table)
end

def save
save= <<-SQL
    INSERT INTO students (name, grade)
    VALUES (?,?)
  SQL
  DB[:conn].execute(save, self.name, self.grade)
  @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
end

def self.create(name:, grade:)
s=Student.new(name, grade)
s.save
s

end
  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]  
  
end
