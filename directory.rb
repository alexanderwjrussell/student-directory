def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  # Create and ampty array
  students= []
  # Get the first name
  name = gets.chomp
  # WHile the name is not empty, repaet the code
  while !name.empty? do
    # Add the student hash to the array
    students << {name: name, cohort: :november}
    puts "Now we have #{students.count} students"
    # Get another name from the user
    name = gets.chomp
  end
# Return the array of students
students
end

def print_header
  puts "The students of Villains Academy"
  puts "--------------"
end

def print(students)
  count = 0
  until count == students.length
    puts "#{count + 1}. #{students[count][:name]} (#{students[count][:cohort]} cohort)"
    count += 1
  end
end

def print_footer(names)
  puts "Overall, we have #{names.count} great students"
end

def name_letter_sort(students)
  letter = "D"
  select_students = students.select{|student| student[:name][0] == letter}
  puts select_students
end

def lengthy_name_sort(students)
  length = 12
  select_students = students.select{|student| student[:name].length < length}
  puts select_students
end

students = input_students
print_header
print(students)
print_footer(students)
puts "-------------"
name_letter_sort(students)
puts "-------------"
lengthy_name_sort(students)
