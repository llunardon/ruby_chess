# lib/moves.rb

require_relative 'moves_helper.rb'

# returns the possible moves of a singular piece on the given board
# doesn't check if the move is legal, it will be removed in main.rb
def get_cell_moves(board, coords)
  name = board.at(coords[0], coords[1]).name
  row = coords[0]
  col = coords[1]
  
  case 
  when name == 'pawn'
    return pawn_moves(board, row, col)
  when name == 'bishop' || name == 'rook' || name == 'queen'
    return long_moves(board, row, col)
  when name == 'knight' || name == 'king'
    return kk_moves(board, row, col)
  end
end

# assign possible moves to every piece in the given board
def assign_possible_moves(board)
  board.each_cell_with_index do |piece, row, col|
    # turn pawn into queen if it reaches the opposite end
    if piece.name == 'pawn'
      piece.name = 'queen' if piece.color == 'white' && row == 0
      piece.name = 'queen' if piece.color == 'black' && row == 7
    end

    piece.possible_moves = get_cell_moves(board, [row, col])
  end
end

# returns an array with all the possible moves a player can do
def get_all_player_moves(board, color)
  ret_array = []

  board.each_cell_with_index do |piece, row_index, col_index|
    piece.possible_moves.each { |coord| ret_array << coord } if piece.color == color
  end

  ret_array
end

# returns a boolean that indicates if the player's king is in check
def is_in_check?(board, player)
  player.color == 'white'? opp_color = 'black' : opp_color = 'white'

  king_coords = board.find_king(player.color)

  return true if get_all_player_moves(board, opp_color).include?(king_coords)
  return false
end

# remove a player's illegal moves from a board
def delete_moves_that_cause_check(board, player)
  moves_to_delete = []

  # cycle every cell of the board
  board.each_cell_with_index do |piece, row_index, col_index|
    moves_to_delete = []

    if piece.color == player.color
      start_coords = [row_index, col_index]

      piece.possible_moves.each do |end_coords|
        moves_to_delete << end_coords if causes_check?(board, player, start_coords, end_coords)
      end
      piece.possible_moves -= moves_to_delete
    end
  end
end

# returns true if a move causes the king to be in check
def causes_check?(board, player, start_coords, end_coords)
  temp_board = Marshal.load(Marshal.dump(board)) # test move on temporary board
  assign_possible_moves(temp_board)

  temp_board.move_piece(start_coords, end_coords)
  assign_possible_moves(temp_board)

  is_in_check?(temp_board, player)
end
