require "singleton"

module SlidingPiece

  def moves(current_pos, directions)
    moves = []
    directions.each do |dir|
      case dir 
      when :up 
        new_pos = current_pos 
        until new_pos[0] == 0
          new_pos[0] -= 1
          moves << new_pos 
        end
      when :right 
        new_pos = current_pos 
        until new_pos[1] == 7
          new_pos[1] += 1
          moves << new_pos 
        end
      when :left
        new_pos = current_pos 
        until new_pos[1] == 0
          new_pos[1] -= 1
          moves << new_pos 
        end 
      when :down 
        new_pos = current_pos 
        until new_pos[0] == 7
          new_pos[0] += 1
          moves << new_pos 
        end
      when :diag_up_left
        new_pos = current_pos 
        until new_pos[0] == 0 || new_pos[1] == 0
          new_pos[0] -= 1
          new_pos[1] -= 1
          moves << new_pos 
        end
      when :diag_up_right
        until new_pos[0] == 0 || new_pos[1] == 7
          new_pos[0] -= 1
          new_pos[1] += 1
          moves << new_pos 
        end
      when :diag_down_right
        until new_pos[0] == 7 || new_pos[1] == 7
          new_pos[0] += 1
          new_pos[1] += 1
          moves << new_pos 
        end
      when :diag_down_left
        until new_pos[0] == 7 || new_pos[1] == 0
          new_pos[0] += 1
          new_pos[1] -= 1
          moves << new_pos 
        end
      end 
    end

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
