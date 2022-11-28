# lib/player.rb

class Player
  attr_accessor :name, :color, :turn

  def initialize(choice)
    puts "What\'s your name?"
    @name = gets.chomp
    @turn = 0

    if choice == 'new'
      puts "#{@name}, what color do you choose?"
      @color = gets.chomp.downcase

      until @color == 'black' || @color == 'white' do
        @color = gets.chomp.downcase
      end

    else
      @color = ''
    end
  end
end
