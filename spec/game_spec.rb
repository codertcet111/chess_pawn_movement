require 'game'
require 'board'

describe Game do
  let(:game) { Game.new }
  let(:board) { Board.new }

  before do
    game.board = board
  end

  describe '#validate_move' do
    it 'Valid input commands will return true from validate_move' do
      expect(game.validate_move('PLACE 2,3,NORTH,BLACK')).to eq(true)
      game.make_move('PLACE 2,3,NORTH,BLACK')
      expect(game.validate_move('MOVE 2')).to eq(true)
      expect(game.validate_move('LEFT')).to eq(true)
    end

    it 'Invalid input commands will return false from validate_move' do
      game.make_move('PLACE 1,1,SOUTH,BLACK')
      expect(game.validate_move('MOVE 2')).to eq(false)
      expect(game.validate_move('MOVE 1')).to eq(false)
    end    
  end

  describe '#make_move' do
    it 'Will place pawn on chess' do
      game.make_move('PLACE 2,3,NORTH,BLACK')
      expect(game.board.pawn_x_position).to eq(2)
      expect(game.board.pawn_y_position).to eq(3)
      expect(game.board.pawn_direction).to eq('NORTH')
    end

    it 'Will make move on chess' do
      game.make_move('PLACE 2,3,NORTH,BLACK')
      game.make_move('MOVE 1')
      expect(game.board.pawn_x_position).to eq(2)
      expect(game.board.pawn_y_position).to eq(4)
    end    
  end
end
