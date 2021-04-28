require_relative 'player.rb'
require_relative 'board.rb'
require_relative 'moves.rb'
require 'yaml'
require 'pathname'

class Game
  attr_accessor :board, :player1, :player2

  def play_game(choice)
    #chose to create a new game
    if choice == 'new' 
      #create player 1 and let them choose the color
      @player1 = Player.new
      puts "#{@player1.name}, what color do you choose?"
      @player1.color = gets.chomp.downcase
      until @player1.color == 'black' || @player1.color == 'white' do
        @player1.color = gets.chomp.downcase
      end

      #create player 2 and assign them the opposite color
      @player2 = Player.new
      @player1.color == 'white' ? @player2.color = 'black' : @player2.color = 'white'

      #inizialize board 
      @board = Board.new
      @board.print_board
      assign_possible_moves(@board)
    #choice to load a previous game
    elsif choice == 'load' 
      yaml = Game.load_game
      @board = yaml.board
      @player1 = yaml.player1
      @player2 = yaml.player2
      @board.print_board
      assign_possible_moves(@board)
    end

    #play rounds
    loop do
      if @player1.color == 'white'
        play_round(@board, @player1)
        play_round(@board, @player2)
      else
        play_round(@board, @player2)
        play_round(@board, @player1)
      end
    end
  end

  def play_round(board, player)
    #remove illegal moves
    delete_moves_that_cause_check(board, player)

    #control if the player is in checkmate
    if get_all_player_moves(board, player.color).empty?
      puts "#{player.name} lost!"
      #player is in checkmate -> exit 
      exit
    end

    #control if the player is in check
    puts "***** #{player.name}, you\'re in check! *****" if is_in_check?(board, player)

    #inizialize coordinates
    start_coords = nil
    end_coords = nil

    #get the coordinates of the piece to move
    puts "It is #{player.name}\'s turn. Choose a piece to move or type \"quit\". The game will be saved automatically every two turns."
    puts "Insert the row and column separated by a comma"
    loop do
      start_coords = get_input_coords(board)

      piece = board.cell_at(start_coords[0], start_coords[1]).piece

      #loop until the starting cell is valid
      break if piece.color == player.color && piece.possible_moves.any?

      puts 'Insert a legal move'
    end

    #get the coordinates of the target cell
    puts "Where do you want to move it?"
    loop do
      piece = board.cell_at(start_coords[0], start_coords[1]).piece
      puts "possible moves: " + piece.possible_moves.to_s

      end_coords = get_input_coords(board)

      #loop until the end cell is valid
      break if piece.possible_moves.include?(end_coords) 

      puts 'Insert a legal move'
    end

    #move the selected piece to the target cell
    board.move_piece(start_coords, end_coords)
    board.print_board

    #update the possible moves
    assign_possible_moves(board)

    Game.save_game(self) if player.color == 'black'
  end

  #receive the coordinates in stdin
  def get_input_coords(board)
    loop do
      input = gets.chomp
      #the player wants to quit the game
      exit if input.downcase == 'quit'

      input = input.split(',') 
      #clean up the input
      input[0] = input[0].to_i 
      input[1] = input[1].to_s.strip 

      return input if board.check_if_valid_coords(input)

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

puts "Do you want to start a new game or load the saved one? Type \"new\" or \"load\""
input = ''
loop do
  input = gets.chomp
  break if input == 'new' || input == 'load'
end

if input == 'load' && !(File.file?('save_file.yml'))
  puts 'the save file does not exist, creating a new game.'
  input = 'new'
end

game = Game.new
game.play_game(input)

