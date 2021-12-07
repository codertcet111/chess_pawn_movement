class Board
  attr_accessor :pawn_x_position, :pawn_y_position, :pawn_color, :pawn_direction, :pawn_icon

  def intialize
    @pawn_x_position = nil
    @pawn_y_position = nil
    @pawn_color = nil
    @pawn_direction = nil
    @pawn_icon = nil
  end

  def self.pawn_icons
    {'NORTH' => '^', 'EAST' => '>', 'SOUTH' => 'v', 'WEST' => '<'}
  end

  def self.bold(str)
    "\e[1m#{str}\e[22m"
  end

  def display
    clear_terminal
    print "PAWN SIMULATION: Let's move the pawn \n\n"
    puts '   ┌────┬────┬────┬────┬────┬────┬────┬────┐'
    
    #Set and display all the rows
    display_rows
    
    puts '   └────┴────┴────┴────┴────┴────┴────┴────┘'
    puts "     1    2    3    4    5    6    7    8  \n\n"
  end

  def clear_terminal
    system 'clear'
    system 'cls'
  end

  def display_rows
    (1..8).each do |row_number|
      display_row(row_number)
      display_row_seprator unless row_number == 8
    end
  end

  def display_row(number)
    print "#{9 - number}  "
    # Can check if current Y location is occupied by Pawn or not
    if @pawn_y_position == ( 9 - number)
      (1..8).each do |col_number|
        print @pawn_x_position == col_number ?  "│ #{@pawn_color == 'WHITE' ? @pawn_icon : Board.bold(@pawn_icon)}  " : '│    '
      end
    else
      print '│    ' * 8
    end
    puts '│'
  end

  def display_row_seprator
    puts '   ├────┼────┼────┼────┼────┼────┼────┼────┤'
  end
end