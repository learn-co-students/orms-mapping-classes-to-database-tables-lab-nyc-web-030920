require 'pry'
class Student

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]  
  attr_accessor :name, :grade 
  attr_reader :id 
  # Method used to initialize the Student class. 
  def initialize(name, grade, id=nil)
    @name = name 
    @grade = grade 
    @id = id 
  end 
  # Method used to link and create a table in the database. 
  def self.create_table
    sql =  <<-SQL
      CREATE TABLE IF NOT EXISTS students (
        id INTEGER PRIMARY KEY,
        name TEXT,
        grade TEXT
        )
    SQL
    DB[:conn].execute(sql)
  end 
  # Method used to drop a table in the database. 
  def self.drop_table 
    sql = "DROP TABLE IF EXISTS students"
    DB[:conn].execute(sql) 
  end 
  # Method used to save an instance of the Student class to the database 
  def save 
    sql = <<-SQL 
      INSERT INTO students (name, grade)
      VALUES(?, ?) 
    SQL
    
    DB[:conn].execute(sql, self.name, self.grade)
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0] 
  end 
  # Method used to take in a hash of attributes and uses metaprogramming to create a new student object. 
  # Then it uses the #save method to save that student to the database. 
  def self.create(name:, grade:)
    student = Student.new(name, grade)
    student.save 
    student 
  end 

end
