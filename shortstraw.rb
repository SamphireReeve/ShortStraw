# SHORT STRAW 
# Ruby game to randomly allocate a short straw
class Straw 
    def initialize(size)
        @straw_size = size
    end
    SHORT_STRAW = 5
    LONG_STRAW = 20
    
    def short?
        @straw_size == SHORT_STRAW
    end
    
    def appearance
        '-' * @straw_size
    end
    
    def self.create_bundle(short, long)
        bundle = []
        1.upto(short) do 
            bundle << Straw.new(SHORT_STRAW)
        end
        1.upto(long) do
            bundle << Straw.new(LONG_STRAW)
        end
        bundle
    end
end


class Player 
    def initialize(name)
        @name = name
    end
    
    def name 
        @name
    end
    
    def appearance
        "#{straw.appearance} #{name}"
    end
    
    def short_straw?
        straw.short?
    end
    
    attr_accessor :straw
end


class Game
    def initialize(player_names)
        @players = []
            player_names.each do |name|
            @players.push(Player.new(name))
        end
        @rounds = 1
    end
    
    def done?
        @players.length <= 1
    end
    
    def show_round__number
        puts ""
        puts "----> Round #{@rounds}"
        puts ""
    end
     
    def setup_new_bundle
        number_of_players = @players.length
        bundle = Straw.create_bundle(1, number_of_players - 1)
        bundle.shuffle
    end
    
    def play_round
        bundle_of_straws = setup_new_bundle
        0.upto(@players.length - 1) do |index|
            player = @players[index]
            player.straw = bundle_of_straws.pop
        end
    end
    
    def show_results
        @players.each do |player|
            puts player.appearance 
        end
    end
    
    def finish_round
        @players.delete_if do |player|
            player.short_straw?
        end
        @rounds += 1
    end
    
    def show_winner
        last_player = @players[0]
        puts ""
        puts "The winner is #{last_player.name}"
        puts ""
    end
    
end


puts "Welcome"
print "Please enter a name: "
name = gets.chomp


PLAYERS = ["anne", "bert", "chris", "donna", "ernie", "franz", "garfield", "holden", "ivy", "jose"]

game = Game.new(PLAYERS)

while !game.done? do
    game.show_round__number
    game.play_round
    game.show_results
    game.finish_round
end

game.show_winner


