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

  play_round(board, player1)
end

def play_round(board, player)
  puts "It is #{player.name}\'s turn. Choose a piece to move:"
  puts "Insert the row and column separated by a comma"
  start_coords = get_input_coords

  puts "Choose the target cell in which to move the selected piece"
  puts "Insert the row and column separated by a comma"
  end_coords = get_input_coords

  board.move_piece(start_coords, end_coords)
  board.print_board
end

def get_input_coords()
  start_coords = gets.chomp
  start_coords = start_coords.split(',')

  #clean up the input
  start_coords[1] = start_coords[1].strip
  start_coords[0] = start_coords[0].to_i

  start_coords
end

play_game
