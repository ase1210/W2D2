require 'colorize' 
require_relative 'board'
require_relative 'cursor' 

class Display
  attr_reader :cursor 
  def initialize(board)
    @cursor = Cursor.new([0, 0], board)
  end

  def render 
    print '  '
    (0..7).each {|n| print n}
    puts ''
    cursor.board.grid.each_with_index do |row, idx|
      print "#{idx} "
      row.each_with_index do |piece, idx2|
        if piece.is_a?(NullPiece)
          if cursor.cursor_pos == [idx, idx2]
            print '-'.colorize(:blue) 
          else
            print '-'
          end
        else 
          if cursor.cursor_pos == [idx, idx2]
            print 'P'.colorize(:blue) 
          else
            print 'P'
          end
        end
      end 
      puts ''
    end
    nil
  end

end