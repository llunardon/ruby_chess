# lib/moves_helper.rb

def white_pawn_moves(board, row, col)
  moves = []

  if board.at(row-1, col).is_none? && row == 6
    moves << player_coords(row-1, col)
    # pawn is in the starting position, it can move two cells up 
    moves << player_coords(row-2, col) if board.at(row-2, col).is_none?
  elsif board.at(row-1, col).is_none? && row > 0
    moves << player_coords(row-1, col)
  end
  # pawn has opponent piece to its left, upward
  if row > 0 && col > 0 && board.at(row-1, col-1).is_black?
    moves << player_coords(row-1, col-1)
  end
  # pawn has opponent piece to its right, upward
  if row > 0 && col < 7 && board.at(row-1, col+1).is_black?
    moves << player_coords(row-1, col+1)
  end

  moves
end

def black_pawn_moves(board, row, col)
  moves = []

  # pawn can move downward
  if row == 1 && board.at(row+1, col).is_none? 
    moves << player_coords(row+1, col)
    # pawn is in the starting position, it can move two cells down 
    moves << player_coords(row+2, col) if board.at(row+2, col).is_none?
  elsif row < 7 && board.at(row+1, col).is_none? 
    moves << player_coords(row+1, col)
  end
  # pawn has opponent piece to its left, downward
  if row < 7 && col > 0 && board.at(row+1, col-1).is_white?
    moves << player_coords(row+1, col-1)
  end
  # pawn has opponent piece to its right, downward
  if row < 7 && col < 7  && board.at(row+1, col+1).is_white?
    moves << player_coords(row+1, col+1)
  end

  moves
end

# used for knight and king, with different lists of moves to try
def kk_moves(board, row, col)
  # get the piece at the given coordinates
  piece = board.at(row, col)

  if piece.name == 'knight'
    dest_list = [[-2,+1], [-1,+2], [-2,-1], [-1,-2], [+1,+2], [+2,+1], [2,-1], [1,-2]]
  else
    dest_list = [[-1,0], [-1,+1], [0,+1], [+1,+1], [+1,0], [+1,-1], [0,-1], [-1,-1]]
  end

  moves = []

  dest_list.each do |dest|
    i = dest[0]
    j = dest[1]

    if is_inside?(row+i, col+j) && board.at(row+i, col+j).color != piece.color
      moves << player_coords(row+i, col+j)
    end
  end

  moves
end

# used for pieces that can move across the board in a single move
def long_moves(board, row, col)
  start_piece = board.at(row, col)
  name = start_piece.name
  moves = []

  # dest_list contains all possible directions, clock-wise
  dest_list = [[-1,0], [-1,1], [0,1], [1,1], [+1,0], [1,-1], [0,-1], [-1,-1]]
  stop_list = Array.new(8) { |n| 0 }

  for n in (1..7) do
    dest_list.each_with_index do |dest, dest_i|
      i = dest[0]
      j = dest[1]

      if is_inside?(row+(n*i), col+(n*j)) && stop_list[dest_i] == 0
        # straight moves
        if (name == 'rook' || name == 'queen') && is_straight?(dest_i)
          if board.at(row+(n*i), col+(n*j)).is_none?
            moves << player_coords(row+(n*i), col+(n*j))
          elsif board.at(row+(n*i), col+(n*j)).color != start_piece.color
            moves << player_coords(row+(n*i), col+(n*j))
            stop_list[dest_i] = 1
          else
            stop_list[dest_i] = 1
          end
        end

        # diagonal moves
        if (name == 'bishop' || name == 'queen') && !is_straight?(dest_i)
          if board.at(row+(n*i), col+(n*j)).is_none?
            moves << player_coords(row+(n*i), col+(n*j))
          elsif board.at(row+(n*i), col+(n*j)).color != start_piece.color
            moves << player_coords(row+(n*i), col+(n*j))
            stop_list[dest_i] = 1
          else
            stop_list[dest_i] = 1
          end
        end
      end
    end
  end

  moves
end

# translate indices of matrix into player's coordinates, as seen when playing
def player_coords(row, col)
  [8 - row, (col + 97).chr] 
end

# boolean function that checks if given position is valid
def is_inside?(row, col)
  (row <= 7 && row >= 0 && col <= 7 && col >= 0)
end

def is_straight?(dir)
  dir.modulo(2) == 0
end
