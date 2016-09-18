puts __FILE__
# __FILE__ is the current executed file

# Just like the previous programs read output.
# Open current file
# Read each line and output the contents.
File.open(__FILE__, "r") do |file|
  file.readlines.each do |line|
    puts line
  end
end
