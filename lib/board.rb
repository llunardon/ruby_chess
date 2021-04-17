class Board
  def initialize()
    @cells = [
      Array.new(8, 'row8'),
      Array.new(8, 'row7'),
      Array.new(8, 'row6'),
      Array.new(8, 'row5'),
      Array.new(8, 'row4'),
      Array.new(8, 'row3'),
      Array.new(8, 'row2'),
      Array.new(8, 'row1')
    ]
  end

  def cell(row, col)
    col_num = col[0].ord - 97
    row_arr = @cells[8-row]

    row_arr[col_num]
  end
end

board = Board.new
p board.cell(1, 'a')
