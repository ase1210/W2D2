require_relative 'piece'
require_relative 'display'

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
    self[start_pos] = NullPiece.instance
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
    p1 = p1_pieces
    p2 = p2_pieces
    np = NullPiece.instance
    @grid.each_with_index do |row, row_idx|
      case row_idx
      when 0, 1
        row.each_index do |col_idx|
          piece = p1.shift
          pos = [row_idx, col_idx]
          self[pos] = piece
          piece.current_pos = [row_idx, col_idx]
        end
      when 6, 7
        row.each_index do |col_idx|
          piece = p2.shift
          pos = [row_idx, col_idx]
          self[pos] = piece
          piece.current_pos = [row_idx, col_idx]
        end
      else
        row.each_index do |col_idx|
          pos = [row_idx, col_idx]          
          self[pos] = np
        end
      end
    end
  end
 
  def p1_pieces
    pieces = []
    1.times { pieces << Rook.new(self, :white) }
    1.times { pieces << Knight.new(self, :white) }
    1.times { pieces << Bishop.new(self, :white) }
    1.times { pieces << Queen.new(self, :white) }
    1.times { pieces << King.new(self, :white) }
    1.times { pieces << Bishop.new(self, :white) }
    1.times { pieces << Knight.new(self, :white) }
    1.times { pieces << Rook.new(self, :white) }    
    8.times { pieces << Pawn.new(self, :white) }

    pieces
  end

  def p2_pieces
    pieces = []
    8.times { pieces << Pawn.new(self, :red) }
    1.times { pieces << Rook.new(self, :red) }
    1.times { pieces << Knight.new(self, :red) }
    1.times { pieces << Bishop.new(self, :red) }
    1.times { pieces << King.new(self, :red) }
    1.times { pieces << Queen.new(self, :red) }
    1.times { pieces << Bishop.new(self, :red) }
    1.times { pieces << Knight.new(self, :red) }
    1.times { pieces << Rook.new(self, :red) }    

    pieces
  end

end

if $PROGRAM_NAME == __FILE__
  board = Board.new 
  p board
end