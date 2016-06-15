# -*- coding: utf-8 -*-

class Student
  def initialize(name, age)
    @name = name
    @age = age
  end
  
  attr_accessor :name, :age
  
  def to_s
    "#@name, #@age"
  end
end

test_a = Student.new("てすと AAA", 18)
test_b = Student.new("てすと BBB", 20)

puts test_a.to_s
puts test_b.to_s

puts test_a.name

test_a.name = "てすと CCC"

puts test_a.name
