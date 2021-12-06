require_relative "board.rb"
class Game
  attr_accessor :board

  def initialize
    @board = Board.new
  end

  def play
    @board.display
    start
  end

  def start
    until false
      next_input
      @board.display
    end
  end

  def next_input
    print "Give next command, in the below format:"
    puts "PLACE X,Y,F,C"
    puts "MOVE X"
    puts "LEFT"
    puts "RIGHT"
    puts "REPORT\n"

    loop do
      move = get_move
      valid_move = true
      break if valid_move
      print "\nThat is a Invalid move. Please try again:\n> "
    end

    move
  end

  def move
    # Make actual chages for :pawn_x_position, :pawn_y_position, :pawn_color, :pawn_direction, :pawn_icon of board
    @board.pawn_icon = '<'
    @board.pawn_x_position = 2
    @board.pawn_y_position = 2
  end

  def get_move
    move = input
    until move_formats(move)
      print "\nThat doesn't appear to be in the correct format. Please see the above instructions.\n> "
      move = input
    end
    move
  end

  def input
    gets.chomp
  end

  def move_formats(input_str)
    true
  end
end