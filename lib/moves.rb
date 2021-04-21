def vertical_upward_moves(board, row, col)
  #get the piece at the given coordinates
  piece = board.cells[row][col].piece

  #find the opponent's color
  if piece.color == 'white'
    opp_color = 'black'
  else
    opp_color = 'white'
  end

  ret_array = []

  #loop until it reaches the border
  loop do
    upper_cell = board.cells[row - 1][col]

    if upper_cell.piece.color == 'none'
      ret_array << [8 - row + 1, (col + 97).chr]
    elsif upper_cell.piece.color == opp_color
      ret_array << [8 - row + 1, (col + 97).chr]
      return ret_array
    elsif upper_cell.piece.color == piece.color
      return ret_array
    end

    row -= 1
    #exit loop if it reaches the first row
    break if row == 0
  end

  ret_array
end

def vertical_downward_moves(board, row, col)
  piece = board.cells[row][col].piece

  #find the opponent's color
  if piece.color == 'white'
    opp_color = 'black'
  else
    opp_color = 'white'
  end

  ret_array = []

  loop do 
    lower_cell = board.cells[row + 1][col]

    if lower_cell.piece.color == 'none'
      ret_array << [8 - row - 1, (col + 97).chr]
    elsif lower_cell.piece.color == opp_color
      ret_array << [8 - row - 1, (col + 97).chr]
      return ret_array
    elsif lower_cell.piece.color == piece.color
      return ret_array
    end

    row += 1
    #exit loop if it reaches the first row
    break if row == 7 
  end

  ret_array
end

def horizontal_right_moves(board, row, col)
  piece = board.cells[row][col].piece

  #find the opponent's color
  if piece.color == 'white'
    opp_color = 'black'
  else
    opp_color = 'white'
  end

  ret_array = []

  loop do 
    right_cell = board.cells[row][col + 1]

    if right_cell.piece.color == 'none'
      ret_array << [8 - row, (col + 97 + 1).chr]
    elsif right_cell.piece.color == opp_color
      ret_array << [8 - row, (col + 97 + 1).chr]
      return ret_array
    elsif right_cell.piece.color == piece.color
      return ret_array
    end

    col += 1
    #exit loop if it reaches the first row
    break if col == 7 
  end

  ret_array
end

def horizontal_left_moves(board, row, col)
  piece = board.cells[row][col].piece

  #find the opponent's color
  if piece.color == 'white'
    opp_color = 'black'
  else
    opp_color = 'white'
  end

  ret_array = []

  loop do 
    left_cell = board.cells[row][col - 1]

    if left_cell.piece.color == 'none'
      ret_array << [8 - row, (col + 97 - 1).chr]
    elsif left_cell.piece.color == opp_color
      ret_array << [8 - row, (col + 97 - 1).chr]
      return ret_array
    elsif left_cell.piece.color == piece.color
      return ret_array
    end

    col -= 1
    #exit loop if it reaches the first row
    break if col == 0 
  end

  ret_array
end

def upward_right_moves(board, row, col)
  #get the piece at the given coordinates
  piece = board.cells[row][col].piece

  #find the opponent's color
  if piece.color == 'white'
    opp_color = 'black'
  else
    opp_color = 'white'
  end

  ret_array = []

  #loop until it reaches the border
  loop do
    upper_right_cell = board.cells[row - 1][col + 1]

    if upper_right_cell.piece.color == 'none'
      ret_array << [8 - row + 1, (col + 97 + 1).chr]
    elsif upper_right_cell.piece.color == opp_color
      ret_array << [8 - row + 1, (col + 97 + 1).chr]
      return ret_array
    elsif upper_right_cell.piece.color == piece.color
      return ret_array
    end

    row -= 1
    col += 1
    #exit loop if it reaches the first row or the last column
    break if row == 0 || col == 7
  end

  ret_array
end

def upward_left_moves(board, row, col)
  #get the piece at the given coordinates
  piece = board.cells[row][col].piece

  #find the opponent's color
  if piece.color == 'white'
    opp_color = 'black'
  else
    opp_color = 'white'
  end

  ret_array = []

  #loop until it reaches the border
  loop do
    upper_left_cell = board.cells[row - 1][col - 1]

    if upper_left_cell.piece.color == 'none'
      ret_array << [8 - row + 1, (col + 97 - 1).chr]
    elsif upper_left_cell.piece.color == opp_color
      ret_array << [8 - row + 1, (col + 97 - 1).chr]
      return ret_array
    elsif upper_left_cell.piece.color == piece.color
      return ret_array
    end

    row -= 1
    col -= 1
    #exit loop if it reaches the first row or the last column
    break if row == 0 || col == 0
  end

  ret_array
end

def downward_right_moves(board, row, col)
  #get the piece at the given coordinates
  piece = board.cells[row][col].piece

  #find the opponent's color
  if piece.color == 'white'
    opp_color = 'black'
  else
    opp_color = 'white'
  end

  ret_array = []

  #loop until it reaches the border
  loop do
    lower_right_cell = board.cells[row + 1][col + 1]

    if lower_right_cell.piece.color == 'none'
      ret_array << [8 - row - 1, (col + 97 + 1).chr]
    elsif lower_right_cell.piece.color == opp_color
      ret_array << [8 - row - 1, (col + 97 + 1).chr]
      return ret_array
    elsif lower_right_cell.piece.color == piece.color
      return ret_array
    end

    row += 1
    col += 1
    #exit loop if it reaches the first row or the last column
    break if row == 0 || col == 7
  end

  ret_array
end

def downward_left_moves(board, row, col)
  #get the piece at the given coordinates
  piece = board.cells[row][col].piece

  #find the opponent's color
  if piece.color == 'white'
    opp_color = 'black'
  else
    opp_color = 'white'
  end

  ret_array = []

  #loop until it reaches the border
  loop do
    lower_left_cell = board.cells[row + 1][col - 1]

    if lower_left_cell.piece.color == 'none'
      ret_array << [8 - row - 1, (col + 97 - 1).chr]
    elsif lower_left_cell.piece.color == opp_color
      ret_array << [8 - row - 1, (col + 97 - 1).chr]
      return ret_array
    elsif lower_left_cell.piece.color == piece.color
      return ret_array
    end

    row += 1
    col -= 1
    #exit loop if it reaches the first row or the last column
    break if row == 0 || col == 0
  end

  ret_array
end

