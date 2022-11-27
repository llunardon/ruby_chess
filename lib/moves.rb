# lib/moves.rb

require_relative 'moves_helper.rb'

# returns the possible moves of a singular piece on the given board
# doesn't check if the move is legal, it will be removed in main.rb
def get_cell_moves(board, coords)
  piece = board.cell_at(coords[0], coords[1]).piece
  row = 8 - coords[0]
  col = coords[1][0].ord - 97
  
  case 
  when piece.name == 'pawn'
    return pawn_moves(board, row, col)
  when piece.name == 'rook'
    return long_moves(board, row, col)
  when piece.name == 'bishop'
    return long_moves(board, row, col)
  when piece.name == 'queen'
    return long_moves(board, row, col)
  when piece.name == 'knight'
    return kk_moves(board, row, col)
  when piece.name == 'king'
    return kk_moves(board, row, col)
  end
end

# assign possible moves to every piece in the given board
def assign_possible_moves(board)
  board.each_cell_with_index do |cell, row_index, col_index|
    piece = cell.piece

    # turn pawn into queen if it reaches the opposite end
    if piece.name == 'pawn'
      piece.name = 'queen' if piece.color == 'white' && row_index == 0
      piece.name = 'queen' if piece.color == 'black' && row_index == 7
    end

    piece.possible_moves = get_cell_moves(board, player_coords(row_index, col_index))
  end
end

# returns an array with all the possible moves a player can do
def get_all_player_moves(board, color)
  ret_array = []

  board.each_cell_with_index do |cell, row_index, col_index|
    piece = cell.piece
    piece.possible_moves.each { |coord| ret_array << coord } if piece.color == color
  end

  ret_array
end

# returns a boolean that indicates if the player's king is in check
def is_in_check?(board, player)
  if player.color == 'white'
    opp_color = 'black'
  else
    opp_color = 'white'
  end

  king_coords = board.find_king(player.color)

  if get_all_player_moves(board, opp_color).include?(king_coords)
    return true
  else
    return false
  end
end

# remove a player's illegal moves from a board
def delete_moves_that_cause_check(board, player)
  moves_to_delete = []

  # cycle every cell of the board
  board.each_cell_with_index do |cell, row_index, col_index|
    # get the piece at the current cell
    piece = cell.piece
    # reset the array
    moves_to_delete = []

    # select only the given player's pieces
    if piece.color == player.color
      start_coords = player_coords(row_index, col_index)

      # cycle every piece's possible move
      piece.possible_moves.each do |end_coords|
        # check if the move is illegal, if it is the add it to the array
        moves_to_delete << end_coords if causes_check?(board, player, start_coords, end_coords)
      end

      # subtract the illegal moves
      piece.possible_moves -= moves_to_delete
    end
  end
end

# returns true if a move causes the king to be in check
def causes_check?(board, player, start_coords, end_coords)
  # creates a temporary board to test the given move
  temp_board = Marshal.load(Marshal.dump(board))
  assign_possible_moves(temp_board)

  # move the piece at the given coordinates
  temp_board.move_piece(start_coords, end_coords)
  assign_possible_moves(temp_board)

  # is it in check?
  is_in_check?(temp_board, player)
end
