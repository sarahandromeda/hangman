require './lib/gameplay.rb'
require './lib/serialize.rb'

def new_game
  NewGame.new_game
end

def load_game
  NewGame.new(*Serialization.unserialize.values)
end

loop do
  puts "Welcome to Hangman.\n"\
    'Do you want to play a new game or load previous? (p/l)'
  choice = gets.chomp.downcase
  game = choice == 'l' ? load_game : new_game
  game.play
  puts 'Do you want to play again? y/n'
  break unless gets.chomp.downcase == 'y'
end
