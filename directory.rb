require 'CSV'

@students = []

def input_students
  puts "Please enter the names of the students"
  # Keep adding students until the break criteria is hit
  loop do
    # Loop through the question methods
    input_students_name
    input_students_cohort
    input_students_hobby
    # Add the student information to the hashes in the array
    push_students(@name, @cohort)
    output_user_input
    break if STDIN.gets.chomp.downcase == "n"
  end
# Return the array of students
@students
end

def interactive_menu
  @students = input_students
  loop do
    print_menu
    process(STDIN.gets.chomp)
    selection_feedback
  end
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "4. Load the list from students.csv"
  puts "9. Exit"
end

def show_students
  print_header
  print_students_list(@students)
  print_footer(@students)
end

def process(selection)
  @selection = selection
  case selection
  when "1" then input_students
  when "2" then show_students
  when "3" then input_filename(selection)
  when "4" then input_filename(selection)
  when "9" then exit
  else
    puts "I don't know what you meant, try again"
  end
end

def selection_feedback
  puts "You have selected option #{@selection}."
end

def push_students(name, cohort)
  @students << {name: name, cohort: cohort.to_sym}
end

def print_header
  puts "The students of Villains Academy".center(40)
  separation_line
end

def print_students_list(students)
  count = 0
    until count == @students.length
      puts "#{count + 1}. #{students[count][:name]} (#{students[count][:cohort]} cohort)".center(40)
      count += 1
    end
end

def print_footer(names)
  separation_line
  puts "Overall, we have #{@students.count} great #{@students.count > 1 ? "students" : "student"}".center(40)
end

def save_students(filename = "students.csv")
  # Open the file for writing
  CSV.open("students.csv", "wb") do |csv|
    # Iterate over the array of studetns
    @students.each do |student|
      csv << [student[:name], student[:cohort]]
    end
  end
end

def load_students(filename = "students.csv")
  CSV.foreach(filename) do |line|
      name = line[0]
      cohort = line[1]
      push_students(name, cohort)
  end
end

def try_load_students
  filename = ARGV.first
  if filename.nil?
    then load_students
  elsif File.exists?(filename)
    load_students(filename)
    puts "Loaded #{@students.count} from #{filename}"
  else
    puts "Sorry, #{filename} doesn't exist."
    exit
  end
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

def separation_line
  puts "--------------".center(40)
end

def input_students_name
  puts "Students name: "
  @name = STDIN.gets.delete "\n"
end

def input_students_cohort
  puts "Which cohort: "
  @cohort = STDIN.gets.chomp.downcase.to_sym
    if @cohort.empty?
      @cohort = "Unknown"
    end
end

def input_students_hobby
  puts "Main hobby: "
  @hobby = STDIN.gets.chomp.downcase.to_sym
    if @hobby.empty?
      @hobby = "None"
    end
end

def output_user_input
  puts "You have now added #{@students.count} #{@students.count > 1 ? "students" : "student"}"
  puts ""
  puts "Add another student (Y/N)"
end

def input_filename(selection)
  puts "Please enter a filename: "
  filename = STDIN.gets.chomp
  selection == "3" ? save_students(filename) : load_students(filename)
end

try_load_students
interactive_menu
