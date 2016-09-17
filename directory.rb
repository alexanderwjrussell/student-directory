def input_students
  @students = []
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  # Keep adding students until the break criteria is hit
  loop do
    # Loop through the questions
    puts "Students name: "
    name = gets.delete "\n"
      if name.empty?
         break
      end
    puts "Which cohort: "
    cohort = gets.chomp.downcase.to_sym
      if cohort.empty?
        cohort = "Unknown"
      end
    puts "Main hobby: "
    hobby = gets.chomp.downcase.to_sym
      if hobby.empty?
        hobby = "None"
      end
    # Add the student information to the hashes in the array
    @students << {name: name, cohort: cohort, hobby: hobby}
    if @students.count == 1
      puts "Now we have #{@students.count} student"
    else
      puts "Now we have #{@students.count} students"
    end
    puts ""
    puts "Add another student (Y/N)"
    break if gets.chomp.downcase == "n"
  end
# Return the array of students
@students
end

def print_header
  puts "The students of Villains Academy".center(40)
  puts "--------------".center(40)
end

def print_students_list(students)
  count = 0
    until count == @students.length
      puts "#{count + 1}. #{students[count][:name]} (#{students[count][:cohort]} cohort)".center(40)
      count += 1
    end
end

def print_footer(names)
  puts "Overall, we have #{names.count} great students".center(40)
end

def name_letter_sort(students)
  letter = "D"
  select_students = @students.select{|student| student[:name][0] == letter}
  puts select_students
end

def lengthy_name_sort(students)
  length = 12
  select_students = @students.select{|student| student[:name].length < length}
  puts select_students
end

def sort_cohort(students)
  @students.sort_by{|student| student[:cohort]}
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "9. Exit"
end

def show_students
  print_header
  print_students_list(@students)
  print_footer(@students)
end

def process(selection)
  case selection
  when "1"
    input_students
  when "2"
    show_students
  when "9"
    exit
  else
    puts "I don't know what you meant, try again"
  end
end

def interactive_menu
  @students = input_students
  loop do
    print_menu
    process(gets.chomp)
  end
end

interactive_menu
