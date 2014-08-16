

Writing a program to implement Conway's game of life.

TODO:
* Seed Cells to a board as a hash
* Write Tests

  Use Rspec
  StateEval needs to verify if the state of a cell should change.
  May need to remove alive? from Cell

  Test Board with negative coordinates

Board needs to be able to return a fixed length arrary with the state 
of all neighbors of a cell.

Each cell needs to be able to read all cells that are one node away. 
There is no edge to the board so the environment can grow and shrink
as needed.

If a cell doesn't exist then it is not alive.
