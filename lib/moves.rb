require_relative 'moves_helper.rb'

# returns the possible moves of a singular piece on the given board
# doesn't check if the move is legal, it will be removed in main.rb

def get_cell_moves(board, coords)
  piece = board.cell_at(coords[0], coords[1]).piece
  possible_moves = []

  row = 8 - coords[0]
  col = coords[1][0].ord - 97
  
  # switch statement
  case 
  # white pawn
  when piece.name == 'pawn' && piece.color == 'white'
    white_pawn_moves(board, row, col).each { |coordinate| possible_moves << coordinate }

  # black pawn
  when piece.name == 'pawn' && piece.color == 'black'
    black_pawn_moves(board, row, col).each { |coordinate| possible_moves << coordinate }
    
  # rook
  when piece.name == 'rook'
    long_moves(['up', 'down', 'left', 'right'], board, row, col).each { |coordinate| possible_moves << coordinate }

  # bishop
  when piece.name == 'bishop'
    long_moves(['up-right', 'down-right', 'down-left', 'up-left'], board, row, col).each { |coordinate| possible_moves << coordinate }

  # knight
  when piece.name == 'knight'
    knight_moves(board, row, col).each { |coordinate| possible_moves << coordinate }

  # queen
  when piece.name == 'queen'
    long_moves(['up-right', 'down-right', 'down-left', 'up-left', 'up', 'down', 'left', 'right'], board, row, col).each { |coordinate| possible_moves << coordinate }
  
  # king
  when piece.name == 'king'
    king_moves(board, row, col).each { |coordinate| possible_moves << coordinate }
  end

  possible_moves
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

    piece.possible_moves = get_cell_moves(board, get_coords(row_index, col_index))
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

# returns the "front-end" coordinates given the @cells indexes
def get_coords(row, col)
  [8 - row, (col + 97).chr]
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
      start_coords = get_coords(row_index, col_index)

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

# returns true if a move is illegal
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

# returns an array of possible moves given a list of directions in input
# only for pieces that can move across the board in one move
def long_moves(directions_list, board, row, col)
  possible_moves = []
  
  if directions_list.include?('up')
    vertical_upward_moves(board, row, col).each { |coordinate| possible_moves << coordinate}
  end

  if directions_list.include?('up_right')
    upward_right_moves(board, row, col).each { |coordinate| possible_moves << coordinate}
  end

  if directions_list.include?('right')
    horizontal_right_moves(board, row, col).each { |coordinate| possible_moves << coordinate}
  end

  if directions_list.include?('down_right')
    downward_right_moves(board, row, col).each { |coordinate| possible_moves << coordinate}
  end

  if directions_list.include?('down')
    vertical_downward_moves(board, row, col).each { |coordinate| possible_moves << coordinate}
  end

  if directions_list.include?('down-left')
    downward_left_moves(board, row, col).each { |coordinate| possible_moves << coordinate}
  end

  if directions_list.include?('left')
    horizontal_left_moves(board, row, col).each { |coordinate| possible_moves << coordinate}
  end

  if directions_list.include?('up-left')
    upward_left_moves(board, row, col).each { |coordinate| possible_moves << coordinate}
  end

  possible_moves
end
