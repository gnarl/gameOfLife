Ruby implementation of Conway's Game of Life

This implementation uses a hash instead of an array to track the state of the board. Only living cells are ever included in the hash between one generation and the next. This appears to simplify the code needed to evaluate if a cell lives or dies in the next generation. 

To play the game simply run conway.rb and specify a path to your seed file.

Additional information on the game can be found at: http://en.wikipedia.org/wiki/Conway%27s_Game_of_Life

