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

  #def assign_possible_moves(cells_arr, coords)
  #  @possible_moves = []
  #  
  #  
  #end
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

  when piece.name == 'knight'
    knight_moves(board, row, col).each { |coordinate| possible_moves << coordinate }

  end
  possible_moves
end

#def vertical_upward_moves(board, row, col)
#  #get the piece at the given coordinates
#  piece = board.cells[row][col].piece
#
#  #find the opponent's color
#  if piece.color == 'white'
#    opp_color = 'black'
#  else
#    opp_color = 'white'
#  end
#
#  ret_array = []
#
#  #loop until it reaches the border
#  loop do
#    upper_cell = board.cells[row - 1][col]
#
#    if upper_cell.piece.color == 'none'
#      ret_array << [8 - row + 1, (col + 97).chr]
#    elsif upper_cell.piece.color == opp_color
#      ret_array << [8 - row + 1, (col + 97).chr]
#      return ret_array
#    elsif upper_cell.piece.color == piece.color
#      return ret_array
#    end
#
#    row -= 1
#    #exit loop if it reaches the first row
#    break if row == 0
#  end
#
#  ret_array
#end
#
#def vertical_downward_moves(board, row, col)
#  piece = board.cells[row][col].piece
#
#  #find the opponent's color
#  if piece.color == 'white'
#    opp_color = 'black'
#  else
#    opp_color = 'white'
#  end
#
#  ret_array = []
#
#  loop do 
#    lower_cell = board.cells[row + 1][col]
#
#    if lower_cell.piece.color == 'none'
#      ret_array << [8 - row - 1, (col + 97).chr]
#    elsif lower_cell.piece.color == opp_color
#      ret_array << [8 - row - 1, (col + 97).chr]
#      return ret_array
#    elsif lower_cell.piece.color == piece.color
#      return ret_array
#    end
#
#    row += 1
#    #exit loop if it reaches the first row
#    break if row == 7 
#  end
#
#  ret_array
#end
#
#def horizontal_right_moves(board, row, col)
#  piece = board.cells[row][col].piece
#
#  #find the opponent's color
#  if piece.color == 'white'
#    opp_color = 'black'
#  else
#    opp_color = 'white'
#  end
#
#  ret_array = []
#
#  loop do 
#    right_cell = board.cells[row][col + 1]
#
#    if right_cell.piece.color == 'none'
#      ret_array << [8 - row, (col + 97 + 1).chr]
#    elsif right_cell.piece.color == opp_color
#      ret_array << [8 - row, (col + 97 + 1).chr]
#      return ret_array
#    elsif right_cell.piece.color == piece.color
#      return ret_array
#    end
#
#    col += 1
#    #exit loop if it reaches the first row
#    break if col == 7 
#  end
#
#  ret_array
#end
#
#def horizontal_left_moves(board, row, col)
#  piece = board.cells[row][col].piece
#
#  #find the opponent's color
#  if piece.color == 'white'
#    opp_color = 'black'
#  else
#    opp_color = 'white'
#  end
#
#  ret_array = []
#
#  loop do 
#    left_cell = board.cells[row][col - 1]
#
#    if left_cell.piece.color == 'none'
#      ret_array << [8 - row, (col + 97 - 1).chr]
#    elsif left_cell.piece.color == opp_color
#      ret_array << [8 - row, (col + 97 - 1).chr]
#      return ret_array
#    elsif left_cell.piece.color == piece.color
#      return ret_array
#    end
#
#    col -= 1
#    #exit loop if it reaches the first row
#    break if col == 0 
#  end
#
#  ret_array
#end
#
#def upward_right_moves(board, row, col)
#  #get the piece at the given coordinates
#  piece = board.cells[row][col].piece
#
#  #find the opponent's color
#  if piece.color == 'white'
#    opp_color = 'black'
#  else
#    opp_color = 'white'
#  end
#
#  ret_array = []
#
#  #loop until it reaches the border
#  loop do
#    upper_right_cell = board.cells[row - 1][col + 1]
#
#    if upper_right_cell.piece.color == 'none'
#      ret_array << [8 - row + 1, (col + 97 + 1).chr]
#    elsif upper_right_cell.piece.color == opp_color
#      ret_array << [8 - row + 1, (col + 97 + 1).chr]
#      return ret_array
#    elsif upper_right_cell.piece.color == piece.color
#      return ret_array
#    end
#
#    row -= 1
#    col += 1
#    #exit loop if it reaches the first row or the last column
#    break if row == 0 || col == 7
#  end
#
#  ret_array
#end
#
#def upward_left_moves(board, row, col)
#  #get the piece at the given coordinates
#  piece = board.cells[row][col].piece
#
#  #find the opponent's color
#  if piece.color == 'white'
#    opp_color = 'black'
#  else
#    opp_color = 'white'
#  end
#
#  ret_array = []
#
#  #loop until it reaches the border
#  loop do
#    upper_left_cell = board.cells[row - 1][col - 1]
#
#    if upper_left_cell.piece.color == 'none'
#      ret_array << [8 - row + 1, (col + 97 - 1).chr]
#    elsif upper_left_cell.piece.color == opp_color
#      ret_array << [8 - row + 1, (col + 97 - 1).chr]
#      return ret_array
#    elsif upper_left_cell.piece.color == piece.color
#      return ret_array
#    end
#
#    row -= 1
#    col -= 1
#    #exit loop if it reaches the first row or the last column
#    break if row == 0 || col == 0
#  end
#
#  ret_array
#end
#
#def downward_right_moves(board, row, col)
#  #get the piece at the given coordinates
#  piece = board.cells[row][col].piece
#
#  #find the opponent's color
#  if piece.color == 'white'
#    opp_color = 'black'
#  else
#    opp_color = 'white'
#  end
#
#  ret_array = []
#
#  #loop until it reaches the border
#  loop do
#    lower_right_cell = board.cells[row + 1][col + 1]
#
#    if lower_right_cell.piece.color == 'none'
#      ret_array << [8 - row - 1, (col + 97 + 1).chr]
#    elsif lower_right_cell.piece.color == opp_color
#      ret_array << [8 - row - 1, (col + 97 + 1).chr]
#      return ret_array
#    elsif lower_right_cell.piece.color == piece.color
#      return ret_array
#    end
#
#    row += 1
#    col += 1
#    #exit loop if it reaches the first row or the last column
#    break if row == 0 || col == 7
#  end
#
#  ret_array
#end
#
#def downward_left_moves(board, row, col)
#  #get the piece at the given coordinates
#  piece = board.cells[row][col].piece
#
#  #find the opponent's color
#  if piece.color == 'white'
#    opp_color = 'black'
#  else
#    opp_color = 'white'
#  end
#
#  ret_array = []
#
#  #loop until it reaches the border
#  loop do
#    lower_left_cell = board.cells[row + 1][col - 1]
#
#    if lower_left_cell.piece.color == 'none'
#      ret_array << [8 - row - 1, (col + 97 - 1).chr]
#    elsif lower_left_cell.piece.color == opp_color
#      ret_array << [8 - row - 1, (col + 97 - 1).chr]
#      return ret_array
#    elsif lower_left_cell.piece.color == piece.color
#      return ret_array
#    end
#
#    row += 1
#    col -= 1
#    #exit loop if it reaches the first row or the last column
#    break if row == 0 || col == 0
#  end
#
#  ret_array
#end
#
