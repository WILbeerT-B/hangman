puts "Hangman Game!"

lines = File.readlines('google-10000-english-no-swears.txt')

my_lines = []
for i in 0..lines.length-1 do
  my_lines.push(lines[i].chomp)
end

error_count = [1, 2, 3, 4, 5, 6, 7]
error_chars = []

secret_code = (my_lines.select {|line| line.length > 4}).sample
print error_count 
puts ""
puts "#{secret_code.gsub(/[#{secret_code}]/, "_ ")} #{secret_code}(#{secret_code.length})"
puts "Not matched: "

def guess_right?(word, code)
  word == code
end

input_match = []
input_not_match = []


while input_not_match.length < 7 do
  puts "Please enter a letter: "
  input = gets.chomp
  
  if secret_code.include? input
    input_match.push(input)
    break if guess_right?(input_match.join, secret_code)
    
  else
    input_not_match.push(input)
  end
end

puts "input matched: #{input_match.join}"
puts "input not matched: #{input_not_match.join}"
