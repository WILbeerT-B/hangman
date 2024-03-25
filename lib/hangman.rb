class Board
  attr_reader :code
  def initialize(code)
    @code = Array.new(code.length, "_")
    
  end

  def display_board
    code.each { |c| print c} 
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
    if idx != nil
      match << input
      board.update_board(idx, input)
    else
      not_match << input
    end
    
    board.display_board
    puts
    puts "Not match: #{@not_match}"
    puts "Match: #{@match}"
    puts "Game over! You did not guess the secret code." if @not_match.length == 7
  end
end

game = Hangman.new
game.play