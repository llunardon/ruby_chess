require_relative 'moves.rb'

class Piece
  attr_accessor :color, :name, :possible_moves

  def initialize(name='none', color='none')
    @name = name
    @color = color
    @possible_moves = []
  end

  def set(name, color)
    @name = name
    @color = color
  end
end

def get_possible_moves(board, coords)
  piece = board.cell_at(coords[0], coords[1]).piece
  possible_moves = []

  row = 8 - coords[0]
  col = coords[1][0].ord - 97
  
  #switch statement
  case 
  #white pawn
  when piece.name == 'pawn' && piece.color == 'white'
    #pawn can move upward
    if board.cells[row - 1][col].piece.color == 'none' && row > 0
      possible_moves << [8 - row + 1, (col + 97).chr] 
    end
    #pawn has opponent piece to its left, upward
    if row > 0 && col > 0 && board.cells[row - 1][col - 1].piece.color == 'black'
      possible_moves << [8 - row + 1, (col - 1 + 97).chr]
    end
    #pawn has opponent piece to its right, upward
    if row > 0 && col < 7 && board.cells[row - 1][col + 1].piece.color == 'black'
      possible_moves << [8 - row + 1, (col + 1 + 97).chr]
    end

  #black pawn
  when piece.name == 'pawn' && piece.color == 'black'
    #pawn can move downward
    if row < 7 && board.cells[row + 1][col].piece.color == 'none' 
      possible_moves << [8 - row - 1, (col + 97).chr] 
    end
    #pawn has opponent piece to its left, downward
    if row < 7 && col > 0 && board.cells[row + 1][col - 1].piece.color == 'white'
      possible_moves << [8 - row - 1, (col - 1 + 97).chr]
    end
    #pawn has opponent piece to its right, downward
    if row < 7 && col < 7 && board.cells[row + 1][col + 1].piece.color == 'white'
      possible_moves << [8 - row - 1, (col + 1 + 97).chr]
    end
    
  #rook
  when piece.name == 'rook'
    #add possible moves in the upward direction
    vertical_upward_moves(board, row, col).each { |coordinate| possible_moves << coordinate}
    #add possible moves in the downward direction
    vertical_downward_moves(board, row, col).each { |coordinate| possible_moves << coordinate} 
    #add possible moves in the right direction
    horizontal_right_moves(board, row, col).each { |coordinate| possible_moves << coordinate }
    #add possible moves in the left direction
    horizontal_left_moves(board, row, col).each { |coordinate| possible_moves << coordinate }

  #bishop
  when piece.name == 'bishop'
    #add possible moves in the up-right direction
    upward_right_moves(board, row, col).each { |coordinate| possible_moves << coordinate}
    #add possible moves in the up-left direction
    upward_left_moves(board, row, col).each { |coordinate| possible_moves << coordinate} 
    #add possible moves in the down-right direction
    downward_right_moves(board, row, col).each { |coordinate| possible_moves << coordinate }
    #add possible moves in the down-left direction
    downward_left_moves(board, row, col).each { |coordinate| possible_moves << coordinate }

  #knight
  when piece.name == 'knight'
    knight_moves(board, row, col).each { |coordinate| possible_moves << coordinate }

  #queen
  when piece.name == 'queen'
    #add possible moves in the upward direction
    vertical_upward_moves(board, row, col).each { |coordinate| possible_moves << coordinate}
    #add possible moves in the downward direction
    vertical_downward_moves(board, row, col).each { |coordinate| possible_moves << coordinate} 
    #add possible moves in the right direction
    horizontal_right_moves(board, row, col).each { |coordinate| possible_moves << coordinate }
    #add possible moves in the left direction
    horizontal_left_moves(board, row, col).each { |coordinate| possible_moves << coordinate }
    #add possible moves in the up-right direction
    upward_right_moves(board, row, col).each { |coordinate| possible_moves << coordinate}
    #add possible moves in the up-left direction
    upward_left_moves(board, row, col).each { |coordinate| possible_moves << coordinate} 
    #add possible moves in the down-right direction
    downward_right_moves(board, row, col).each { |coordinate| possible_moves << coordinate }
    #add possible moves in the down-left direction
    downward_left_moves(board, row, col).each { |coordinate| possible_moves << coordinate }

  #king
  when piece.name == 'king'
    king_moves(board, row, col).each { |coordinate| possible_moves << coordinate }

  end
  possible_moves
end

def assign_possible_moves(board)
  board.cells.each_with_index do |row, row_index|

    row.each_with_index do |cell, col_index|
      coords = get_coords(row_index, col_index)
      cell.piece.possible_moves = get_possible_moves(board, coords)
    end

  end
end

def get_coords(row, col)
  [8 - row, (col + 97).chr]
end
