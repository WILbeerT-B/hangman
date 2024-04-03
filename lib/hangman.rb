class Board
  attr_reader :code
  def initialize(s_code)
    @code = Array.new(s_code.length, "_")
    
  end

  def display_board
    code.each { |c| print c, ' '}
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
    @count = 0
  end

  def filter_lines
    for i in 0...lines.length do
      my_lines.push(lines[i].chomp)
    end
    my_lines
  end

  def generate_code
    (my_lines.select {|line| line.length > 4}).sample
  end

  def play
    puts "Hangman"
    puts
    board.display_board
    while @count != 7 do
      player_input
    end
  end

  def get_index(input)
    idx = secret_code.index(input)
    if secret_code.count(input) == 0
      @count += 1
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
  end

  def you_guess_it_right
    board.code.join == secret_code
  end

  def game_over
    not_match.length == 7
  end

  def is_input_taken?(letter)
    !(match.include?(letter) || not_match.include?(letter))
  end

  def is_input_valid?(letter)
    letter.length == 1 
  end

  def player_input
    puts
    puts
    print "Enter a letter: "
    input = gets.chomp
    if input == input.upcase
      input = input.downcase
    end
    if is_input_valid?(input)
      if is_input_taken?(input)
        get_index(input)
        puts 
        board.display_board
        puts
        puts
        puts "Not match: #{not_match}"

        if you_guess_it_right
          @count = 7
          puts "You guess it right!"
        end

        if game_over
          puts "Game over! You did not guess the secret code '#{secret_code}'."
        end
      else
        puts "'#{input}' is already guessed!"
      end
    else
      puts "Input is invalid! Please enter a letter."  
    end
  end
end

game = Hangman.new
game.play