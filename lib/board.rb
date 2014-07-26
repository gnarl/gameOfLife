

class Board
  attr_reader :current_state, :future_state

  def initialize(map)
    @current_state = map 
    @future_state = nil
  end

end


