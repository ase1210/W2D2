require "singleton"
require 'byebug'
module SlidingPiece

  def moves(current_pos, directions)
    moves = []
    piece = board[current_pos]
    color = piece.color
    other_color = (color == :white) ? :red : :white 
    curr_pos = current_pos.dup
    directions.each do |dir|
      case dir 
      when :up 
        new_pos = curr_pos
        until new_pos[0] == 0
          new_pos[0] -= 1
          break if board[new_pos].color == color
          moves << new_pos.dup
          break if board[new_pos].color == other_color
        end
      when :right 
        new_pos = curr_pos 
        until new_pos[1] == 7
          new_pos[1] += 1
          break if board[new_pos].color == color
          moves << new_pos.dup
          break if board[new_pos].color == other_color
        end
      when :left
        new_pos = curr_pos 
        until new_pos[1] == 0
          new_pos[1] -= 1
          break if board[new_pos].color == color
          moves << new_pos.dup
          break if board[new_pos].color == other_color
        end 
      when :down 
        new_pos = curr_pos 
        until new_pos[0] == 7
          new_pos[0] += 1
          break if board[new_pos].color == color
          moves << new_pos.dup
          break if board[new_pos].color == other_color
        end
      when :diag_up_left
        new_pos = curr_pos 
        until new_pos[0] == 0 || new_pos[1] == 0
          new_pos[0] -= 1
          new_pos[1] -= 1
          break if board[new_pos].color == color
          moves << new_pos.dup
          break if board[new_pos].color == other_color
        end
      when :diag_up_right
        new_pos = curr_pos 
        until new_pos[0] == 0 || new_pos[1] == 7
          new_pos[0] -= 1
          new_pos[1] += 1
          break if board[new_pos].color == color
          moves << new_pos.dup
          break if board[new_pos].color == other_color
        end
      when :diag_down_right
        new_pos = curr_pos 
        until new_pos[0] == 7 || new_pos[1] == 7
          new_pos[0] += 1
          new_pos[1] += 1
          break if board[new_pos].color == color
          moves << new_pos.dup
          break if board[new_pos].color == other_color
        end
      when :diag_down_left
        new_pos = curr_pos 
        until new_pos[0] == 7 || new_pos[1] == 0
          new_pos[0] += 1
          new_pos[1] -= 1
          break if board[new_pos].color == color
          moves << new_pos.dup
          break if board[new_pos].color == other_color
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
    piece = board[current_pos]
    color = piece.color 

    move_set.each do |move|
      new_pos = current_pos.dup
      new_pos[0] += move[0]
      new_pos[1] += move[1]
      next if board[new_pos].color == color 
      moves << new_pos.dup if (0..7).cover?(new_pos[0]) && (0..7).cover?(new_pos[1])
    end
    moves
  end

  # def move_diff
  #   [0,0]
  # end

end 


class Piece
  attr_reader :color, :board
  attr_accessor :current_pos

  def initialize(board, color)
    @color = color
    @current_pos = [3, 1]
    @board = board 
  end
  
end

class King < Piece
  include SteppingPiece
  
  attr_reader :symbol 

  def initialize(board, color)
    @symbol = :K 
    super 
  end

  def move_diff
    [[0,-1],[-1,0],[0,1],[1,0],[-1,1],[1,-1],[-1,-1],[1,1]]
  end
end

class Queen < Piece
  include SlidingPiece
  
  attr_reader :symbol 
  
  def initialize(board, color)
    @symbol = :Q 
    super 
  end

  def move_dirs
    [:up, :right, :left, :down, :diag_up_right, :diag_up_left, :diag_down_right, :diag_down_left]
  end
  
end

class Knight < Piece
  include SteppingPiece
  
  attr_reader :symbol 
  
  def initialize(board, color)
    @symbol = :H
    super 
  end

  def move_diff
    [[-2,-1],[-1,-2],[2,1],[1,2],[-1,2],[2,-1],[1,-2],[-2,1]]
  end
end

class Bishop < Piece
  include SlidingPiece
  
  attr_reader :symbol 
  
  def initialize(board, color)
    @symbol = :B 
    super 
  end

  def move_dirs
    [:diag_up_right, :diag_up_left, :diag_down_right, :diag_down_left]
  end
  
end

class Rook < Piece
  include SlidingPiece
  
  attr_reader :symbol 
  
  def initialize(board, color)
    @symbol = :R 
    super 
  end

  def move_dirs
    [:up, :right, :left, :down]
  end
  
end

class Pawn < Piece

  attr_reader :symbol 
  
  def initialize(board, color)
    @symbol = :P 
    super 
  end

  def moves
    moves = []
    f_dir = forward_dir
    if f_dir == 1
      new_pos = self.current_pos.dup
      new_pos[0] += 1
      moves << new_pos if board[new_pos] == NullPiece.instance
    else
      new_pos = self.current_pos.dup
      new_pos[0] -= 1
      moves << new_pos if board[new_pos] == NullPiece.instance
    end

    if at_start_row?
      new_pos = self.current_pos.dup
      new_pos[0] += 2 if f_dir == 1
      new_pos[0] -= 2 if f_dir == -1
      jump_pos = self.current_pos.dup
      jump_pos[0] += 1 if f_dir == 1
      jump_pos[0] -= 1 if f_dir == -1
      
      moves << new_pos if board[new_pos] == NullPiece.instance && board[jump_pos] == NullPiece.instance
    end
    moves += side_attacks

    moves
  end

  private
  def at_start_row?
    return true if self.color == :white && self.current_pos[0] == 1
    return true if self.color == :red && self.current_pos[0] == 6
    false
  end
  
  def forward_dir
    return 1 if self.color == :white
    -1
  end

  # def forward_steps

  # end

  def side_attacks
    result = []
    f_dir = forward_dir
    if f_dir == 1
      diag_left_pos = [current_pos[0] + 1, current_pos[1] - 1]
      diag_right_pos = [current_pos[0] + 1, current_pos[1] + 1]
      result << diag_left_pos if board[diag_left_pos].color == :red
      result << diag_right_pos if board[diag_right_pos].color == :red
    else
      diag_left_pos = [current_pos[0] - 1, current_pos[1] - 1]
      diag_right_pos = [current_pos[0] - 1, current_pos[1] + 1]
      result << diag_left_pos if board[diag_left_pos].color == :white
      result << diag_right_pos if board[diag_right_pos].color == :white
    end
    result
  end

end

class NullPiece < Piece
  attr_reader :color 
  include Singleton 

  def initialize
    @color = nil 
  end

end
