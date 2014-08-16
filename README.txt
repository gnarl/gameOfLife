Ruby implementation of Conway's Game of Life

This implementation uses a hash instead of an array to track the state of the board. Only alive cells are ever included in the hash and this appears to greatly simplify the code needed to evaluate if a cell lives or dies in the next generation. 

I currently have the board able to update itself and the cells contain state information. The next steps include seeding the board from a file and drawing the representation of the board.

Drawing the representation of the board will initially just spit out html of each generation of the board.

Additional information on the game can be found at: http://en.wikipedia.org/wiki/Conway%27s_Game_of_Life

