class Player
  attr_accessor :name, :color

  def initialize(choice)
    puts "What\'s your name?"
    @name = gets.chomp

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
