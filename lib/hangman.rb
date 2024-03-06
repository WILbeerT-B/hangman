puts "Hangman Game!"

lines = File.readlines('google-10000-english-no-swears.txt')

my_lines = []
for i in 0..lines.length-1 do
  my_lines.push(lines[i].chomp)
end
secret_code = (my_lines.select {|line| line.length > 4}).sample
puts "(1 2 3 4 5 6 7) #{secret_code.gsub(/[#{secret_code}]/, "_ ")} #{secret_code}" 