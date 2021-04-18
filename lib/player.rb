class Player
  attr_accessor :name, :color

  def initialize()
    puts "What\'s your name?"
    @name = gets.chomp
    puts "What color do you choose?"
    @color = gets.chomp.downcase
    until @color == 'black' || @color == 'white' do
      @color = gets.chomp.downcase
    end
  end
end

player1 = Player.new
puts player1.color
puts player1.name
