class Player
  attr_accessor :name, :color

  def initialize()
    puts "What\'s your name?"
    @name = gets.chomp
    @color = ''
  end
end
