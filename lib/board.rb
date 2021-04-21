#lib/board.rb

require_relative 'cell.rb'

class Board
  attr_accessor :cells

  def initialize()
    @cells = [
      Array.new(8) { Cell.new },
      Array.new(8) { Cell.new },
      Array.new(8) { Cell.new },
      Array.new(8) { Cell.new },
      Array.new(8) { Cell.new },
      Array.new(8) { Cell.new },
      Array.new(8) { Cell.new },
      Array.new(8) { Cell.new }
    ]

    assign_pieces
  end

  def assign_pieces()
    #assign white pieces
    cell_at(1, 'a').piece.set('rook', 'white')
    cell_at(1, 'h').piece.set('rook', 'white')
    cell_at(1, 'b').piece.set('knight', 'white')
    cell_at(1, 'g').piece.set('knight', 'white')
    cell_at(1, 'c').piece.set('bishop', 'white')
    cell_at(1, 'f').piece.set('bishop', 'white')
    cell_at(1, 'd').piece.set('queen', 'white')
    cell_at(1, 'e').piece.set('king', 'white')
    @cells[6].each do |cell|
      cell.piece.set('pawn', 'white')
    end

    #assign black pieces
    cell_at(8, 'a').piece.set('rook', 'black')
    cell_at(8, 'h').piece.set('rook', 'black')
    cell_at(8, 'b').piece.set('knight', 'black')
    cell_at(8, 'g').piece.set('knight', 'black')
    cell_at(8, 'c').piece.set('bishop', 'black')
    cell_at(8, 'f').piece.set('bishop', 'black')
    cell_at(8, 'd').piece.set('queen', 'black')
    cell_at(8, 'e').piece.set('king', 'black')
    @cells[1].each do |cell|
      cell.piece.set('pawn', 'black')
    end
  end

  def print_board()
    #unicode values
    #white characters
    black_rook = "\u2656"
    black_knight = "\u2658"
    black_bishop = "\u2657"
    black_queen = "\u2655"
    black_king = "\u2654"
    black_pawn = "\u2659"

    #black characters
    white_rook = "\u265c"
    white_knight = "\u265e"
    white_bishop = "\u265d"
    white_queen = "\u265b"
    white_king = "\u265a"
    white_pawn = "\u265f"

    #print columns indexes
    puts '  abcdefgh  '
    puts ' __________ '

    #iterate over every row
    @cells.each_with_index do |row, index|
      #print row index
      print (8-index).to_s
      print '|'

      #iterate over every column
      row.each do |cell|
        #switch statement, checks the piece's name and color
        #and prints the corrispondent unicode character
        case cell.piece.name
        when 'rook'
          if cell.piece.color == 'white'
            print white_rook.encode('utf-8')                       
          else
            print black_rook.encode('utf-8')                       
          end

        when 'knight'
          if cell.piece.color == 'white'
            print white_knight.encode('utf-8')
          else
            print black_knight.encode('utf-8')
          end

        when 'bishop'
          if cell.piece.color == 'white' 
            print white_bishop.encode('utf-8') 
          else
            print black_bishop.encode('utf-8')
          end

        when 'queen'
          if cell.piece.color == 'white' 
            print white_queen.encode('utf-8') 
          else
            print black_queen.encode('utf-8')
          end

        when 'king'
          if cell.piece.color == 'white' 
            print white_king.encode('utf-8') 
          else
            print black_king.encode('utf-8')
          end

        when 'pawn'
          if cell.piece.color == 'white' 
            print white_pawn.encode('utf-8') 
          else
            print black_pawn.encode('utf-8')
          end
        else
          print ' '
        end
      end

      print '|'
      print (8-index).to_s
      puts ''
    end

    puts ' __________ '
    puts '  abcdefgh  '
  end

  def cell_at(row, col)
    return nil if row < 1 || row > 8 

    #convert the ASCII code to the correct integer
    col_num = col[0].ord - 97
    return nil if col_num < 0 || col_num > 7

    #white king is in row 1 at the beginning
    #black king is in row 8 at the beginning
    @cells[8-row][col_num]
  end

  def check_if_valid_coords(coords)
    #check row index
    return false if coords[0] < 1 || coords[0] > 8 

    #check column index
    col_index = coords[1][0].ord - 97
    return false if col_index < 0 || col_index > 7

    return true
  end

  def move_piece(start_coords, end_coords)
    return nil unless check_if_valid_coords(start_coords)
    return nil unless check_if_valid_coords(end_coords)

    #get the piece in the starting cell
    piece = cell_at(start_coords[0], start_coords[1]).piece

    #change values of ending cell equal to those of the starting cell
    cell_at(end_coords[0], end_coords[1]).piece.set(piece.name, piece.color)

    #set starting cell to empty
    cell_at(start_coords[0], start_coords[1]).piece.set('none', 'none')
  end

  def set_possible_moves()
    @cells.each_with_index do |row, row_index|
      
      row.each_with_index do |cell, col_index|
        p coords = [(8 - row_index), (col_index + 97).chr]
        p cell.piece.name
      end

    end
  end

  #def get_possible_moves(row, col)
  #  piece = cell_at(row, col)

  #  piece.color == 'white'? opponent_color = 'black' : opponent_color = 'white'

  #  case piece.name
  #  when 'pawn'
  #    get_pawn_moves(@cells, row, col, piece.color)
  #  when 'knight'

  #  when 'bishop'

  #  when 'rook'

  #  when 'king'

  #  when 'queen'

  #  else
  #    puts ''
  #  end
  #end
end

board = Board.new
board.print_board

board.move_piece([1, 'b'], [7, 'e'])

board.print_board

p get_possible_moves(board, [7, 'e'])
