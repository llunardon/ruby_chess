require_relative 'moves_helper.rb'

#returns the possible moves of a singular piece on the given board
def get_cell_moves(board, coords)
  piece = board.cell_at(coords[0], coords[1]).piece
  possible_moves = []

  row = 8 - coords[0]
  col = coords[1][0].ord - 97
  
  #switch statement
  case 
  #white pawn
  when piece.name == 'pawn' && piece.color == 'white'
    white_pawn_moves(board, row, col).each { |coordinate| possible_moves << coordinate }

  #black pawn
  when piece.name == 'pawn' && piece.color == 'black'
    black_pawn_moves(board, row, col).each { |coordinate| possible_moves << coordinate }
    
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

#assign possible moves to every piece in the given board
def assign_possible_moves(board)
  board.cells.each_with_index do |row, row_index|
    row.each_with_index do |cell, col_index|
      coords = get_coords(row_index, col_index)
      cell.piece.possible_moves = get_cell_moves(board, coords)
    end
  end
end

#returns an array with all the possible moves a player can do
def get_all_player_moves(board, color)
  ret_array = []

  board.cells.each_with_index do |row, row_index|
    row.each_with_index do |col, col_index|
      piece = board.cells[row_index][col_index].piece
      
      if piece.color == color
        piece.possible_moves.each do |coord|
          ret_array << coord
        end
      end
    end
  end

  ret_array
end

#returns the "front-end" coordinates given the @cells indexes
def get_coords(row, col)
  [8 - row, (col + 97).chr]
end

#returns a boolean that indicates if the player's king is in check
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

#returns an array of all the moves that cause a check
def get_moves_that_cause_check(board, player)
  moves_to_delete = []

  #cycle every cell of the board
  board.cells.each_with_index do |row, row_index|
    row.each_with_index do |cell, col_index|
      piece = cell.piece

      #select only the given player's pieces
      if piece.color == player.color
        start_coords = get_coords(row_index, col_index)
        #cycle every piece's possible move
        piece.possible_moves.each do |end_coords|
          if causes_check?(board, player, start_coords, end_coords)
            moves_to_delete << end_coords
          end
        end
      end
    end
  end

  moves_to_delete
end

def delete_moves_that_cause_check(board, player)
  moves_to_delete = []

  #cycle every cell of the board
  board.cells.each_with_index do |row, row_index|
    row.each_with_index do |cell, col_index|
      piece = cell.piece

      #select only the given player's pieces
      if piece.color == player.color
        start_coords = get_coords(row_index, col_index)
        #cycle every piece's possible move
        piece.possible_moves.each do |end_coords|
          if causes_check?(board, player, start_coords, end_coords)
            moves_to_delete << end_coords
          end
        end
        piece.possible_moves = piece.possible_moves - moves_to_delete
      end
    end
  end

  moves_to_delete
end

def causes_check?(board, player, start_coords, end_coords)
  temp_board = Marshal.load(Marshal.dump(board))
  assign_possible_moves(temp_board)

  #move the piece at the given coordinates
  temp_board.move_piece(start_coords, end_coords)
  assign_possible_moves(temp_board)

  #is it in check?
  if is_in_check?(temp_board, player)
    ret = true
  else
    ret = false
  end

  ret
end
