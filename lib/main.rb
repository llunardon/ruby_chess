require_relative 'player.rb'
require_relative 'board.rb'
require_relative 'moves.rb'

def play_game()
  #create player 1 and let them choose the color
  player1 = Player.new
  puts "#{player1.name}, what color do you choose?"
  player1.color = gets.chomp.downcase
  until player1.color == 'black' || player1.color == 'white' do
    player1.color = gets.chomp.downcase
  end

  #create player 2 and assign them the opposite color
  player2 = Player.new
  player1.color == 'white' ? player2.color = 'black' : player2.color = 'white'
  
  #inizialize board 
  board = Board.new
  board.print_board
  assign_possible_moves(board)

  #play rounds
  loop do
    if player1.color == 'white'
      play_round(board, player1)
      play_round(board, player2)
    else
      play_round(board, player2)
      play_round(board, player1)
    end
  end
end

def play_round(board, player)
  #calculate the legal moves
  delete_moves_that_cause_check(board, player)
  p get_all_player_moves(board, player.color)

  #control if the player is in checkmate
  if get_all_player_moves(board, player.color).empty?
    puts "#{player.name} lost!"
    #is in checkmate -> exit 
    exit
  end
  
  #control if the player is in check
  puts "***** #{player.name}, you\'re in check! *****" if is_in_check?(board, player)

  #inizialize coordinates
  start_coords = nil
  end_coords = nil

  #get the coordinates of the piece to move
  puts "It is #{player.name}\'s turn. Choose a piece to move:"
  loop do
    puts "Insert the row and column separated by a comma"
    start_coords = get_input_coords(board)

    piece = board.cell_at(start_coords[0], start_coords[1]).piece

    #loop until the starting cell is valid
    break if piece.color == player.color && piece.possible_moves.any?

    puts 'Insert a valid cell'
  end

  #get the coordinates of the target cell
  puts "Where do you want to move it?"
  loop do
    end_coords = get_input_coords(board)

    piece = board.cell_at(start_coords[0], start_coords[1]).piece

    #loop until the end cell is valid
    #break if piece.possible_moves.include?(end_coords) && !(causes_check?(board, player, start_coords, end_coords))
    break if piece.possible_moves.include?(end_coords) 

    puts 'Insert a valid cell'
  end

  #move the selected piece to the target cell
  board.move_piece(start_coords, end_coords)
  board.print_board

  #update the possible moves
  assign_possible_moves(board)
end

#receive the coordinates in stdin
def get_input_coords(board)
  loop do
    coords = gets.chomp
    coords = coords.split(',')

    #clean up the input
    coords[1] = coords[1].strip 
    coords[0] = coords[0].to_i 

    return coords if board.check_if_valid_coords(coords)

    puts 'Insert valid coordinates'
  end
end

play_game
