# lib/moves_helper.rb

# used for both black and white pawns
def pawn_moves(board, row, col)
  moves = []
  i = 1
  start_row = 1
  opp_color = 'white'

  if board.at(row, col).is_white?
    i = -1
    start_row = 6
    opp_color = 'black'
  end
           
  # can move two cells ahead if pawn is in starting row
  if board.at(row+i, col).is_none? && row == start_row
    moves << [row+i, col]
    moves << [row+(2*i), col] if board.at(row+(2*i), col).is_none?
  elsif is_inside?(row+i, col) && board.at(row+i, col).is_none? 
    moves << [row+i, col]
  end

  # check left and right columns for opponents
  [-1, 1].each do |j|
    if is_inside?(row+i, col+j) && (board.at(row+i, col+j).color == opp_color)
      moves << [row+i, col+j]
    end
  end

  moves
end

# used for knight and king, with different lists of moves to try
def kk_moves(board, row, col)
  piece = board.at(row, col)
  piece.color == 'black'? starting_row = 0 : startin_row = 7

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
      moves << [row+i, col+j]
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
      rq = (name == 'rook' || name == 'queen') && is_straight?(dest_i) # rook, queen
      bq =  (name == 'bishop' || name == 'queen') && !is_straight?(dest_i) # bishop, queen

      if is_inside?(row+(n*i), col+(n*j)) && stop_list[dest_i] == 0 && (rq || bq)
        if board.at(row+(n*i), col+(n*j)).is_none?
          moves << [row+(n*i), col+(n*j)]
        elsif board.at(row+(n*i), col+(n*j)).color != start_piece.color
          moves << [row+(n*i), col+(n*j)]
          stop_list[dest_i] = 1
        else
          stop_list[dest_i] = 1
        end
      end
    end
  end

  moves
end

def is_inside?(row, col)
  (row <= 7 && row >= 0 && col <= 7 && col >= 0)
end

def is_straight?(dir)
  dir.modulo(2) == 0
end
