require_relative 'player.rb'
require_relative 'board.rb'

def play_game()
  player1 = Player.new
  player2 = Player.new

  if player1.color == player2.color
    puts "Both players have chosen the same name, defaulting to #{player1.name} having white pieces"
    player1.color = 'white'
    player2.color = 'black'
  end
  
  board = Board.new
  board.print_board
  assign_possible_moves(board)

  loop do
    play_round(board, player1)
    play_round(board, player2)
  end
end

def play_round(board, player)
  #inizialize coordinates
  start_coords = nil
  end_coords = nil

  #get the coordinates of the piece to move
  puts "It is #{player.name}\'s turn. Choose a piece to move:"
  loop do
    puts "Insert the row and column separated by a comma"
    start_coords = get_input_coords(board)

    piece = board.cell_at(start_coords[0], start_coords[1]).piece

    break if piece.color == player.color && piece.possible_moves.any?

    puts 'Insert a valid cell'
  end

  #get the coordinates of the target cell
  puts "Choose the target cell in which to move the selected piece"
  loop do
    puts "Insert the row and column separated by a comma"
    end_coords = get_input_coords(board)

    piece = board.cell_at(start_coords[0], start_coords[1]).piece

    break if piece.possible_moves.include?(end_coords)

    puts 'Insert a valid cell'
  end

  board.move_piece(start_coords, end_coords)
  board.print_board
  assign_possible_moves(board)
end

def get_input_coords(board)
  loop do
    coords = gets.chomp
    coords = coords.split(',')

    #clean up the input
    coords[1] = coords[1].strip 
    coords[0] = coords[0].to_i 

    return coords if board.check_if_valid_coords(coords)

    puts 'Insert valid coordinates.'
  end
end

play_game
