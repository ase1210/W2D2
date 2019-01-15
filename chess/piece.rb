require "singleton"

class Piece
  def initialize
    
  end
end


class NullPiece < Piece
  include Singleton 

end
