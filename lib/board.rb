# lib/board.rb

require_relative 'pieces.rb'

class Board
  attr_accessor :cells

  def initialize()
    @cells = Array.new(8)

    for i in 0..7 do
      @cells[i] = Array.new(8) { Piece.new }
    end

    assign_pieces
  end

  def assign_pieces()
    # assign white pieces
    self.at(7, 0).set('rook', 'white')
    self.at(7, 1).set('knight', 'white')
    self.at(7, 2).set('bishop', 'white')
    self.at(7, 3).set('queen', 'white')
    self.at(7, 4).set('king', 'white')
    self.at(7, 5).set('bishop', 'white')
    self.at(7, 6).set('knight', 'white')
    self.at(7, 7).set('rook', 'white')
    @cells[6].each do |cell|
      cell.set('pawn', 'white')
    end

    # assign black pieces
    self.at(0, 0).set('rook', 'black')
    self.at(0, 1).set('knight', 'black')
    self.at(0, 2).set('bishop', 'black')
    self.at(0, 3).set('queen', 'black')
    self.at(0, 4).set('king', 'black')
    self.at(0, 5).set('bishop', 'black')
    self.at(0, 6).set('knight', 'black')
    self.at(0, 7).set('rook', 'black')
    @cells[1].each do |cell|
      cell.set('pawn', 'black')
    end
  end

  def print_board()
    # unicode values
    # white characters
    white_square = "\u25a1"
    black_rook = "\u2656"
    black_knight = "\u2658"
    black_bishop = "\u2657"
    black_queen = "\u2655"
    black_king = "\u2654"
    black_pawn = "\u2659"

    # black characters
    black_square = "\u25a0"
    white_rook = "\u265c"
    white_knight = "\u265e"
    white_bishop = "\u265d"
    white_queen = "\u265b"
    white_king = "\u265a"
    white_pawn = "\u265f"

    # print columns indexes
    puts '  a b c d e f g h  '
    puts ' _________________ '

    # iterate over every row
    @cells.each_with_index do |row, index|
      # print row index
      print (8-index).to_s
      print '|'

      # iterate over every column
      row.each_with_index do |cell, j|
        # switch statement, checks the piece's name and color
        # and prints the corrispondent unicode character
        case cell.name
        when 'none'
          if (index+j).modulo(2) == 1
            print white_square.encode('utf-8') + ' '
          else
            print black_square.encode('utf-8') + ' '
          end

        when 'rook'
          if cell.color == 'white'
            print white_rook.encode('utf-8') + ' '
          else
            print black_rook.encode('utf-8') + ' '                       
          end

        when 'knight'
          if cell.color == 'white'
            print white_knight.encode('utf-8') + ' '
          else
            print black_knight.encode('utf-8') + ' '
          end

        when 'bishop'
          if cell.color == 'white' 
            print white_bishop.encode('utf-8') + ' '
          else
            print black_bishop.encode('utf-8') + ' '  
          end

        when 'queen'
          if cell.color == 'white' 
            print white_queen.encode('utf-8') + ' '
          else
            print black_queen.encode('utf-8') + ' '
          end

        when 'king'
          if cell.color == 'white' 
            print white_king.encode('utf-8') + ' '
          else
            print black_king.encode('utf-8') + ' '
          end

        when 'pawn'
          if cell.color == 'white' 
            print white_pawn.encode('utf-8') + ' '
          else
            print black_pawn.encode('utf-8') + ' '
          end
        else
          print '  '
        end
      end

      print '|'
      print (8-index).to_s
      puts ''
    end

    puts ' _________________ '
    puts '  a b c d e f g h  '
  end

  def valid_coords?(coords)
    row = coords[0]
    col = coords[1]
    return false if (row.nil? || col.nil?)
    return (row <= 7 && row >= 0 && col <= 7 && col >= 0)
  end

  def move_piece(start_coords, target_coords)
    return nil unless valid_coords?(start_coords)
    return nil unless valid_coords?(target_coords)

    # get the piece in the starting cell
    piece = self.at(start_coords[0], start_coords[1])

    # change values of ending cell equal to those of the starting cell
    self.at(target_coords[0], target_coords[1]).set(piece.name, piece.color)

    # set starting cell to empty
    self.at(start_coords[0], start_coords[1]).set('none', 'none')
  end

  # return the 'front end' coordinates of the king of the given color
  def find_king(color)
    each_cell_with_index do |piece, row_index, col_index|
      if piece.name == 'king' && piece.color == color
        return [row_index, col_index]
      end
    end

    # if something went wrong
    return nil
  end

  # cycle through every cell
  def each_cell()
    @cells.each do |row|
      row.each do |cell|
          yield(cell)
      end
    end
  end

  # cycle through every cell with indexes
  def each_cell_with_index()
    @cells.each_with_index do |row, row_index|
      row.each_with_index do |cell, col_index|
          yield(cell, row_index, col_index)
      end
    end
  end

  # returns the piece at indices row, col in the matrix
  def at(row, col)
    @cells[row][col]
  end
end
