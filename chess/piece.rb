require "singleton"

module SlidingPiece

  def moves(current_pos, directions)
    moves = []


    moves
  end
  
end

module SteppingPiece
  
  def moves(current_pos)
  
  end

end


class Piece

  def initialize
    @color = :white
    @symbol = :P
    @current_pos = [0, 1]
  end
  
end

class King < Piece

end

class Queen < Piece

  def move_dirs
    [:up, :right, :left, :down, :diag_up_right, :diag_up_left, :diag_down_right, :diag_down_left]
  end

end

class Knight < Piece

end

class Bishop < Piece
  include SlidingPiece

  def move_dirs
    [:diag_up_right, :diag_up_left, :diag_down_right, :diag_down_left]
  end
  
end

class Rook < Piece
  
  def move_dirs
    [:up, :right, :left, :down]
  end

end

class Pawn < Piece
  
  # def move_dirs
  #   [:up]
  # end

end

class NullPiece < Piece
  include Singleton 

end
