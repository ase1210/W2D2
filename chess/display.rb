require 'colorize' 
require 'byebug' 
require_relative 'board'
require_relative 'cursor' 

class Display
  attr_reader :cursor 
  def initialize(board)
    @cursor = Cursor.new([0, 0], board)
  end

  def render 
    cursor.board.grid.each_with_index do |row, idx|
      row.each_with_index do |piece, idx2|
        if piece.is_a?(NullPiece)
          (cursor.cursor_pos == [idx, idx2]) ? (print '-'.colorize(cursor_color)) : (print '-')
        else 
          color = piece.color
          # byebug
          (cursor.cursor_pos == [idx, idx2]) ? (print piece.symbol.to_s.colorize(cursor_color)) : (print piece.symbol.to_s.colorize(color))
        end
      end 
      puts ''
    end
    puts '--------------'
    nil
  end

  def cursor_color
    cursor.selected ? :green : :blue
  end

  def move_cursor
    while true
      render 
      cursor.get_input
    end
  end

end