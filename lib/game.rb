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
    # Run the loop for infinite time
    until false
      # In this simulator, we are taking input, printing entire board with pawn and then again clearing the terminal and taking input again
      next_input
      @board.display
    end
  end

  def next_input
    puts "Give next command, in the below format with examples (In capitals only)"
    puts "PLACE X,Y,F,C  (For example, PLACE 2,3,NORTH,BLACK)"
    puts "MOVE X"
    puts "LEFT"
    puts "RIGHT"
    puts "REPORT"
    puts "Q (To Quit the game)"
    move = "REPORT"
    loop do
      move = get_move
      break if validate_move(move)
      print "\nThat is a Invalid move. Please try again:\n> "
    end

    make_move(move)
  end

  def validate_move(move)
    # Only need to check move validation
    if move.include? 'PLACE'
      new_x, new_y, new_direction, new_color = move.split(" ")[1].split(",")
      (1..8) === new_x.to_i && (1..8) === new_y.to_i
    elsif move.include? 'MOVE'
      steps = move.split(" ")[-1].to_i rescue 1
      permited = case @board.pawn_direction
      when 'NORTH'
        @board.pawn_y_position + steps <= 8
      when 'SOUTH'
        @board.pawn_y_position - steps >= 1
      when 'WEST'
        @board.pawn_x_position - steps >= 1
      when 'EAST'
        @board.pawn_x_position + steps <= 8
      end
      permited || false
    else
      true
    end
  end

  def make_move(move)
    # Make actual chages for :pawn_x_position, :pawn_y_position, :pawn_color, :pawn_direction, :pawn_icon of board
    # @board.pawn_icon = '<'
    # @board.pawn_x_position = 2
    # @board.pawn_y_position = 2
    if move.include? 'PLACE'
      #Split the inputs
      new_x, new_y, new_direction, new_color = move.split(" ")[1].split(",")
      @board.pawn_y_position = new_y.to_i
      @board.pawn_x_position = new_x.to_i
      @board.pawn_color = new_color
      @board.pawn_direction = new_direction
      @board.pawn_icon = Board.pawn_icons[new_direction]
    elsif move.include? 'MOVE'
      steps = move.split(" ")[-1].to_i rescue 1
      case @board.pawn_direction
      when 'NORTH'
        @board.pawn_y_position += steps
      when 'SOUTH'
        @board.pawn_y_position -= steps
      when 'WEST'
        @board.pawn_x_position -= steps
      when 'EAST'
        @board.pawn_x_position += steps
      end
    elsif move == 'LEFT'
      current_direction = @board.pawn_direction
      current_index = Board.pawn_icons.find_index {|k,| k == current_direction}
      @board.pawn_direction, @board.pawn_icon = Board.pawn_icons.to_a[current_index - 1]
    elsif move == 'RIGHT'
      current_direction = @board.pawn_direction
      current_index = Board.pawn_icons.find_index {|k,| k == current_direction}
      @board.pawn_direction, @board.pawn_icon = Board.pawn_icons.to_a[current_index == 3 ? 0 : current_index + 1]
    elsif move == 'REPORT'
      # No movement only print report
      puts "** Report:"
      puts "#{@board.pawn_x_position},#{@board.pawn_y_position},#{@board.pawn_direction},#{@board.pawn_color}"
    elsif move == 'Q'
      exit
    end
  end

  def get_move
    move = input
    until move_formats(move)
      puts "\nThat doesn't seems to be in the correct format. Please see the above instructions."
      puts "If its first instruction, then only PLACE command is allowed"
      move = input
    end
    move
  end

  def input
    gets.chomp
  end

  def move_formats(input_str)
    #Check if its start of the input
    if @board.pawn_y_position == nil
      input_str =~ /^PLACE ([1-8]),([1-8]),(NORTH|SOUTH|EAST|WEST),(BLACK|WHITE)$/
    else
      input_str =~ /^PLACE ([1-8]),([1-8]),(NORTH|SOUTH|EAST|WEST),(BLACK|WHITE)$/ || input_str =~ /^MOVE ([1-2])$/ || ['LEFT','RIGHT','REPORT','Q'].any? { |word| input_str.include?(word) }
    end
  end
end