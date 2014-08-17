
module CellOutput

  def cli_out(cells)
    left_max_col = nil 
    right_max_col = nil

    cells.each do |x|
      if left_max_col.nil?  
        left_max_col = x.col 
      elsif x.col < left_max_col
        left_max_col = x.col 
      end

      if right_max_col.nil? 
        right_max_col = x.col 
      elsif x.col > right_max_col 
        right_max_col = x.col 
      end
    end

    current_row = cells[0].row
    current_col = left_max_col 

    cells.each do |x|

      while x.row > current_row 
        while current_col <= right_max_col do
          print "____|"
          current_col = current_col + 1
        end
        puts "\n" 
        current_row = current_row + 1 
        current_col = left_max_col
      end
      
      print_column(x.row, x.col, current_col)
      current_col = x.col + 1 
    end

    #DRY
    while current_col <= right_max_col do
      print "____|"
      current_col = current_col + 1
    end
    puts "\n\n" 

  end

  def print_column(row, col, current_col)

    while current_col < col do
      print "____|"
      current_col = current_col + 1
    end
    print "#{row}_#{col}|".rjust(5, '_')
 
  end
end

