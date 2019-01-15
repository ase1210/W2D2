require_relative 'piece'

class Board
  attr_reader :grid
  def initialize(grid=Array.new(8) {Array.new(8)})
    @grid = grid 
    setup_default_grid
  end

  def move_piece(start_pos, end_pos)
    raise ArguementError.new("There is no piece at #{start_pos}") if self[start_pos].is_a?(NullPiece)
    raise ArguementError.new("You cannot move to #{end_pos}") unless valid_move?(start_pos, end_pos)
    piece = self[start_pos]
    self[end_pos] = piece
    self[start_pos] = NullPiece.new
    nil
  end

  def valid_pos?(pos)
    !self[pos].nil?
  end
  
  private

  def valid_move?(start_pos, end_pos)
    true
  end

  def [](pos)
    x,y = pos 
    @grid[x][y]
  end

  def []=(pos, val)
    x,y = pos 
    @grid[x][y] = val 
  end

  def setup_default_grid
    @grid.each_with_index do |row, idx|
      case idx 
      when 0, 1, 6, 7
        row.each_index do |col|
          pos = [idx, col]
          self[pos] = Piece.new
          # grid[idx][col] = Piece.new 
        end
      else
        row.each_index do |col|
          pos = [idx, col]
          self[pos] = NullPiece.new
          # grid[idx][col] = NullPiece.new 
        end
      end 
    end
  end

end

if $PROGRAM_NAME == __FILE__
  board = Board.new 
  p board
end