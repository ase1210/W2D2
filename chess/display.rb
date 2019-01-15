require 'colorize' 
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
          (cursor.cursor_pos == [idx, idx2]) ? (print '-'.colorize(:blue)) : (print '-')
        else 
          (cursor.cursor_pos == [idx, idx2]) ? (print 'P'.colorize(:blue)) : (print 'P')
        end
      end 
      puts ''
    end
    puts '--------------'
    nil
  end

  def move_cursor
    while true
      render 
      cursor.get_input
    end
  end

end