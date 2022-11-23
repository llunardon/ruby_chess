# lib/moves_helper.rb

def white_pawn_moves(board, row, col)
  moves = []

  if board.at(row-1, col).is_none? && row == 6
    moves << end_coords(row-1, col)
    # pawn is in the starting position, it can move two cells up 
    moves << end_coords(row-2, col) if board.at(row-2, col).is_none?
  elsif board.at(row-1, col).is_none? && row > 0
    moves << end_coords(row-1, col)
  end
  # pawn has opponent piece to its left, upward
  if row > 0 && col > 0 && board.at(row-1, col-1).is_black?
    moves << end_coords(row-1, col-1)
  end
  # pawn has opponent piece to its right, upward
  if row > 0 && col < 7 && board.at(row-1, col+1).is_black?
    moves << end_coords(row-1, col+1)
  end

  moves
end

def black_pawn_moves(board, row, col)
  moves = []

  # pawn can move downward
  if row == 1 && board.at(row+1, col).is_none? 
    moves << end_coords(row+1, col)
    # pawn is in the starting position, it can move two cells down 
    moves << end_coords(row+2, col) if board.at(row+2, col).is_none?
  elsif row < 7 && board.at(row+1, col).is_none? 
    moves << end_coords(row+1, col)
  end
  # pawn has opponent piece to its left, downward
  if row < 7 && col > 0 && board.at(row+1, col-1).is_white?
    moves << end_coords(row+1, col-1)
  end
  # pawn has opponent piece to its right, downward
  if row < 7 && col < 7  && board.at(row+1, col+1).is_white?
    moves << end_coords(row+1, col+1)
  end

  moves
end

# used for rook, bishop and queen
def long_moves(board, row, col)
  start_piece = board.at(row, col)
  name = start_piece.name

  if start_piece.color == 'white'
    opp_color = 'black'
  else
    opp_color = 'white'
  end
                  
  moves = []

  # loop until it reaches the border
  up_stop = 0
  right_stop = 0
  down_stop = 0
  left_stop = 0

  up_right_stop = 0
  down_right_stop = 0
  up_left_stop = 0
  down_left_stop = 0

  # checks in all directions, if the cell is empty then add
  # the move to the array, if the cell is occupied by the enemy
  # then also set the stop variable to 1. If the cell
  # is occupied by an ally piece, just set the stop variable to 1
  # without adding the move
  for i in 1..6 do
    # upwards
    if (name == 'rook' || name == 'queen')
      if row-i >= 0 && up_stop == 0
        upper_piece = board.at(row-i, col) 
        if upper_piece.is_none?
          moves << end_coords(row-i, col)
        elsif upper_piece.color == opp_color
          moves << end_coords(row-i, col)
          up_stop = 1
        else
          up_stop = 1
        end
      end

      # right
      if col+i <= 7 && right_stop == 0
        right_piece = board.at(row, col+i) 
        if right_piece.is_none?
          moves << end_coords(row, col+i)
        elsif right_piece.color == opp_color
          moves << end_coords(row, col+i)
          right_stop = 1
        else
          right_stop = 1
        end
      end

      # downwards
      if row+i <= 7 && down_stop == 0 && (name == 'rook' || name == 'queen')
        down_piece = board.at(row+i, col) 
        if down_piece.is_none?
          moves << end_coords(row+i, col)
        elsif down_piece.color == opp_color
          moves << end_coords(row+i, col)
          down_stop = 1
        else
          down_stop = 1
        end
      end
        
      # left
      if col-i >= 0 && left_stop == 0
        left_piece = board.at(row, col-i) 
        if left_piece.is_none?
          moves << end_coords(row, col-i)
        elsif left_piece.color == opp_color
          moves << end_coords(row, col-i)
          left_stop = 1
        else
          left_stop = 1
        end
      end
    end
      
    # up-right
    if (name == 'bishop' || name == 'queen')
      if row-i >= 0 && col+i <= 7 && up_right_stop == 0 && 
        up_right_piece = board.at(row-i, col+i) 
        if up_right_piece.is_none?
          moves << end_coords(row-i, col+i)
        elsif up_right_piece.color == opp_color
          moves << end_coords(row-i, col+i)
          up_right_stop = 1
        else
          up_right_stop = 1
        end
      end

      # down-right
      if row+i <= 7 && col+i <= 7 && down_right_stop == 0 && (name == 'bishop' || name == 'queen')
        down_right_piece = board.at(row+i, col+i) 
        if down_right_piece.is_none?
          moves << end_coords(row+i, col+i)
        elsif down_right_piece.color == opp_color
          moves << end_coords(row+i, col+i)
          down_right_stop = 1
        else
          down_right_stop = 1
        end
      end

      # down-left
      if row+i <= 7 && col-i >= 0 && down_left_stop == 0 && (name == 'bishop' || name == 'queen')
        down_left_piece = board.at(row+i, col-i) 
        if down_left_piece.is_none?
          moves << end_coords(row+i, col-i)
        elsif down_left_piece.color == opp_color
          moves << end_coords(row+i, col-i)
          down_left_stop = 1
        else
          down_left_stop = 1
        end
      end

      # up-left
      if row-i >= 0 && col-i >= 0 && up_left_stop == 0 && (name == 'bishop' || name == 'queen')
        up_left_piece = board.at(row-i, col-i) 
        if up_left_piece.is_none?
          moves << end_coords(row-i, col-i)
        elsif up_left_piece.color == opp_color
          moves << end_coords(row-i, col-i)
          up_left_stop = 1
        else
          up_left_stop = 1
        end
      end
    end
  end

  return moves
end

# used for knight and king, with different destination lists
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
      moves << end_coords(row+i, col+j)
    end
  end

  moves
end

# translate indices of matrix into player's coordinates
def end_coords(row, col)
  [8 - row, (col + 97).chr] 
end

# boolean that checks if position is inside the board
def is_inside?(row, col)
  return (row <= 7 && row >= 0 && col <= 7 && col >= 0)
end
