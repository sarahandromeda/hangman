
class Game
  def initialize(name, answer)
    @name = name
    @answer = answer
    @guesses_left = 6
    @score = 0
    @current_results = Array.new(answer.length, '_')
    @letters_guessed = []
  end

  def show_current
    puts "#{@current_results.join(' ')} | [#{@letters_guessed.join(',')}]"
  end

  def guess_letter
    guess = ''
    loop do
      guess = gets.chomp.downcase
      break if guess.match?(/[[:alpha:]]/) && guess.length == 1
    end
    guess
  end

  def compare_guess(guess)
    @letters_guessed << guess
    @answer.each_with_index do |letter, i|
      if letter == guess
        @current_results[i] = letter
      end
    end
  end
end

class NewGame < Game
  def self.new_game
    print 'What is your name: '
    name = gets.chomp
    answer = random_word
    new(name, answer)
  end

  def self.random_word
    dict = open('dictionary.txt', 'r').readlines
    dict.keep_if { |word| word.length.between?(6,12) }
    pick = dict.sample.chomp.split('')
  end
end

a = NewGame.new_game
p a
a.show_current
a.compare_guess(a.guess_letter)
a.show_current


