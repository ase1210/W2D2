require "singleton"
require 'byebug'
module SlidingPiece

  def moves(current_pos, directions)
    moves = []
    curr_pos = current_pos.dup
    directions.each do |dir|
      case dir 
      when :up 
        new_pos = curr_pos
        until new_pos[0] == 0
          new_pos[0] -= 1
          moves << new_pos.dup
        end
      when :right 
        new_pos = curr_pos 
        until new_pos[1] == 7
          new_pos[1] += 1
          moves << new_pos.dup
        end
      when :left
        new_pos = curr_pos 
        until new_pos[1] == 0
          new_pos[1] -= 1
          moves << new_pos.dup
        end 
      when :down 
        new_pos = curr_pos 
        until new_pos[0] == 7
          new_pos[0] += 1
          moves << new_pos.dup
        end
      when :diag_up_left
        new_pos = curr_pos 
        until new_pos[0] == 0 || new_pos[1] == 0
          new_pos[0] -= 1
          new_pos[1] -= 1
          moves << new_pos.dup
        end
      when :diag_up_right
        new_pos = curr_pos 
        until new_pos[0] == 0 || new_pos[1] == 7
          new_pos[0] -= 1
          new_pos[1] += 1
          moves << new_pos.dup
        end
      when :diag_down_right
        new_pos = curr_pos 
        until new_pos[0] == 7 || new_pos[1] == 7
          new_pos[0] += 1
          new_pos[1] += 1
          moves << new_pos.dup
        end
      when :diag_down_left
        new_pos = curr_pos 
        until new_pos[0] == 7 || new_pos[1] == 0
          new_pos[0] += 1
          new_pos[1] -= 1
          moves << new_pos.dup
        end
      end 
    end

    moves
  end
  
  # def move_dirs
  #   [:up]
  # end
end

module SteppingPiece
  
  def moves(current_pos, move_set)
    moves = [] 
    move_set.each do |move|
      new_pos = current_pos.dup
      new_pos[0] += move[0]
      new_pos[1] += move[1]
      moves << new_pos.dup if (0..7).cover?(new_pos[0]) && (0..7).cover?(new_pos[1])
    end
    moves
  end

  # def move_diff
  #   [0,0]
  # end

end 


class Piece
  attr_reader :color, :symbol, :current_pos
  def initialize
    @color = :white
    @symbol = :P
    @current_pos = [3, 1]
  end
  
end

class King < Piece
  include SteppingPiece
  
  def move_diff
    [[0,-1],[-1,0],[0,1],[1,0],[-1,1],[1,-1],[-1,-1],[1,1]]
  end
end

class Queen < Piece
  include SlidingPiece
  
  def move_dirs
    [:up, :right, :left, :down, :diag_up_right, :diag_up_left, :diag_down_right, :diag_down_left]
  end
  
end

class Knight < Piece
  include SteppingPiece
  
  def move_diff
    [[-2,-1],[-1,-2],[2,1],[1,2],[-1,2],[2,-1],[1,-2],[-2,1]]
  end
end

class Bishop < Piece
  include SlidingPiece
  
  def move_dirs
    [:diag_up_right, :diag_up_left, :diag_down_right, :diag_down_left]
  end
  
end

class Rook < Piece
  include SlidingPiece
  
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
