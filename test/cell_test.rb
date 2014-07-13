require 'test/unit'
require 'awesome_print'
require 'cell'

class CellTest < Test::Unit::TestCase


  def setup
      
  end


  def test_it 
    cell1 = Cell.new(4,5) 
    assert(cell1.x == 4)
    assert(cell1.y == 5)
    assert(cell1.alive?)
  end

end




