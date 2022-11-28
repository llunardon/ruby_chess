# lib/main.rb

require_relative 'player.rb'
require_relative 'board.rb'
require_relative 'moves.rb'
require 'yaml'
require 'pathname'

class Game
  attr_accessor :board, :player1, :player2

  def play_game(choice)
    # chose to create a new game
    if choice == 'new' 
      # create player 1 and let them choose the color
      @player1 = Player.new(choice)

      # create player 2 and assign them the opposite color
      @player2 = Player.new('')
      @player1.color == 'white' ? @player2.color = 'black' : @player2.color = 'white'
      if @player1.color == 'white'
          @player1.turn = 1
      end

      # initialize board and print it
      @board = Board.new
      @board.print_board
      assign_possible_moves(@board)

    # choice to load a previous game
    elsif choice == 'load' 
      yaml = Game.load_game
      @board = yaml.board
      @player1 = yaml.player1
      @player2 = yaml.player2
      @board.print_board
      assign_possible_moves(@board)
    end

    loop do
      play_round(@board, @player1, @player2)
    end
  end

  def play_round(board, player1, player2)
    if player1.turn == 1
      curr_player = player1
      opponent_player = player2
    else
      curr_player = player2
      opponent_player = player1
    end

    # remove illegal moves and control if curr_player is in checkmate
    delete_moves_that_cause_check(board, curr_player)
    if get_all_player_moves(board, curr_player.color).empty?
      puts "#{curr_player.name} lost!"
      exit
    end

    # control if the player is in check
    puts "***** #{curr_player.name}, you\'re in check! *****" if is_in_check?(board, curr_player)

    # inizialize coordinates
    start_coords = nil
    end_coords = nil

    # get the coordinates of the piece to move
    puts "It is #{curr_player.name}\'s turn. Choose a piece to move or type \"quit\". The game will be saved automatically every two turns."
    puts "Insert the row and column separated by a comma"
    loop do
      start_coords = get_input_coords(board)
      piece = board.cell_at(start_coords[0], start_coords[1])

      # loop until the starting cell is valid
      break if piece.color == curr_player.color && piece.possible_moves.any?

      puts 'Insert a legal move'
    end

    # get the coordinates of the target cell
    puts "Where do you want to move it?"
    loop do
      piece = board.cell_at(start_coords[0], start_coords[1])

      end_coords = get_input_coords(board)

      # loop until the end cell is valid
      break if piece.possible_moves.include?(end_coords) 

      puts 'Insert a legal move'
    end

    # move the selected piece to the target cell
    board.move_piece(start_coords, end_coords)

    # update the possible moves
    assign_possible_moves(board)
    board.print_board

    # swap the turns variables and save the game
    curr_player.turn = 0
    opponent_player.turn = 1
    Game.save_game(self)
  end

  # receive the coordinates in stdin
  def get_input_coords(board)
    loop do
      input = gets.chomp
      exit if input.downcase == 'quit'

      input = input.split(',')
      num_args = input.length()
      input[0] = input[0].to_i
      input[1] = input[1].to_s.strip 

      return input if board.valid_coords?(input) && num_args == 2
      puts 'Insert valid coordinates'
    end
  end

  def self.save_game(game)
    File.open('save_file.yml', 'w') {|f| f.write game.to_yaml }
  end

  def self.load_game()
    yaml = YAML.load_file('save_file.yml')
  end
end

# ask choice
puts "Do you want to start a new game or load the saved one? Type \"new\" or \"load\""
choice = ''
loop do
  choice = gets.chomp
  break if choice == 'new' || choice == 'load'
end

if choice == 'load' && !(File.file?('save_file.yml'))
  puts 'the save file does not exist, creating a new game.'
  choice = 'new'
end

# start the actual game
game = Game.new
game.play_game(choice)
