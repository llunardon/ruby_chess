require_relative 'cell.rb'
require_relative 'pieces.rb'

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
  end

  def cell_at(row, col)
    col_num = col[0].ord - 97
    row_arr = @cells[8-row]

    @cells[8-row][col_num]
  end

  def move_piece(start_coords, end_coords)
    return
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
p board.cell_at(1, 'a')

board.cell_at(1, 'a').piece.name = 'pawn'
board.cell_at(1, 'a').piece.color = 'white'
p board.cell_at(1, 'a')
p board.cell_at(1, 'b')
