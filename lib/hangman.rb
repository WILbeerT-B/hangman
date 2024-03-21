class Board
  attr_reader :code
  def initialize(code)
    @code = Array.new(code.length, "_")
    
  end

  def display_board
    @code.each { |c| print c} 
  end

  def update_board(index, input)
    @code[index] = input
  end
end

class Hangman
  def initialize
    @lines = File.readlines('google-10000-english-no-swears.txt')
    @my_lines = []
    @my_lines = filter_lines
    @secret_code = generate_code
    @board = Board.new(@secret_code)
    @count = 1
  end

  def filter_lines
    @lines.each do |line|
      @my_lines.push(line.chomp)
    end
  end

  def generate_code
    (@my_lines.select {|line| line.length > 4}).sample
  end

  def play
    puts "Hangman"
    puts @secret_code
    @board.display_board
    while @count < @secret_code.length
      player_input
    end
  end

  def player_input
    puts
    print "Enter a letter: "
    input = gets.chomp
    idx = @secret_code.index(input)
    @board.update_board(idx, input)
    @board.display_board
  end
end

game = Hangman.new
game.play