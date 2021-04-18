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
    white_rook = "\u2656"
    white_knight = "\u2658"
    white_bishop = "\u2657"
    white_queen = "\u2655"
    white_king = "\u2654"
    white_pawn = "\u2659"

    #black characters
    black_rook = "\u265c"
    black_knight = "\u265e"
    black_bishop = "\u265d"
    black_queen = "\u265b"
    black_king = "\u265a"
    black_pawn = "\u265f"

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
    row_arr = @cells[8-row]

    @cells[8-row][col_num]
  end

  def move_piece(start_coords, end_coords)
    #read values of starting cell
    piece_name = cell_at(start_coords[0], start_coords[1]).piece.name
    piece_color = cell_at(start_coords[0], start_coords[1]).piece.color

    #change values of ending cell equal to those of the starting cell
    cell_at(end_coords[0], end_coords[1]).piece.set(piece_name, piece_color)

    #set starting cell to empty
    cell_at(start_coords[0], start_coords[1]).piece.set('none', 'none')
  end

  def get_possible_moves(row, col)
    piece = cell(row, col)

    piece.color == 'white'? opponent_color = 'black' : opponent_color = 'white'

    case piece.name
    when 'pawn'
      get_pawn_moves(@cells, row, col, piece.color)
    when 'knight'

    when 'bishop'

    when 'rook'

    when 'king'

    when 'queen'

    else
      puts ''
    end
  end
end

board = Board.new
board.print_board
