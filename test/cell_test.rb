require 'test/unit'
require 'awesome_print'
require 'cell'

class CellTest < Test::Unit::TestCase

  def setup
    @cell01 = Cell.new(0,1)
    @cell02 = Cell.new(0,2)
      
  end


  def test_init
    cell45 = Cell.new(4,5) 
    assert(cell45.row == 4)
    assert(cell45.col == 5)
  end

  def test_alive
    assert(@cell01.alive?)

    @cell01.alive = false
    assert(!@cell01.alive?)

    cell03 = Cell.new(0,3, false)
    assert(!cell03.alive?)
  end

  def test_name
    assert_equal("0_1", @cell01.name) 
    assert_equal("0_2", @cell02.name) 
    assert_equal("252_252", Cell.new(252, 252).name)
  end

  

end




