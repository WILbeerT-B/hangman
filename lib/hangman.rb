class Board
  attr_reader :code
  def initialize(s_code)
    @code = Array.new(s_code.length, "_")
    
  end

  def display_board
    code.each { |c| print c, ' '}
    #code.join.each_char { |c| print c, ' '} 
  end

  def update_board(index, input)
    code[index] = input
  end
end

class Hangman
  attr_reader :lines, :my_lines, :secret_code, :board, :match, :not_match
  def initialize
    @lines = File.readlines('google-10000-english-no-swears.txt')
    @my_lines = []
    @my_lines = filter_lines
    @secret_code = generate_code
    @board = Board.new(@secret_code)
    @match = []
    @not_match = []
  end

  def filter_lines
    for i in 0..lines.length-1 do
      my_lines.push(lines[i].chomp)
    end
    my_lines
    #for line in lines do 
      #my_lines.push(line.chomp)  
    #end
  end

  def generate_code
    (my_lines.select {|line| line.length > 4}).sample
  end

  def play
    puts "Hangman"
    p secret_code
    puts secret_code.length
    board.display_board
    while not_match.length < 7
      player_input
    end
  end

  def player_input
    puts
    print "Enter a letter: "
    input = gets.chomp
    idx = secret_code.index(input)
    if secret_code.count(input) == 0
      not_match << input
    elsif secret_code.count(input) == 1
      match << input
      board.update_board(idx, input)
    else
      all_index = []
      all_index = (0...secret_code.length).find_all {|i| secret_code[i,1] == input}
      for i in 0...all_index.length do
        match << input
        board.update_board(all_index[i], input)
      end
    end
    
    board.display_board
    puts
    puts "Not match: #{not_match}"
    puts "Match: #{match}"
    puts "Board code: #{board.code.join}"
    puts "Game over! You did not guess the secret code '#{secret_code}'." if not_match.length == 7
    if board.code.join == secret_code
      not_match.length == 7
      puts "You guess it right!"
      
    end
  end
end

game = Hangman.new
game.play