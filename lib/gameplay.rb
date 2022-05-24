require './lib/display.rb'
require './lib/serialize.rb'

class Game
  include Display
  include Serialization

  def initialize(name, answer, guesses_left = 6, score = 0, current_results = Array.new(answer.length, '_'), letters_guessed = [])
    @name = name
    @answer = answer
    @guesses_left = guesses_left
    @score = score
    @current_results = current_results
    @letters_guessed = letters_guessed
  end

  def guess_letter
    guess = ''
    loop do
      guess = gets.chomp.downcase
      self.serialize if guess == 'save'
      break if guess.match?(/[[:alpha:]]/) &&
               guess.length == 1 &&
               !@letters_guessed.include?(guess) ||
               guess == 'save'
    end
    guess
  end

  def compare_guess(guess)
    @letters_guessed << guess
    @guesses_left -= 1 unless @answer.include?(guess)
    @answer.each_with_index do |letter, i|
      @current_results[i] = letter if letter == guess
    end
  end

  def end_result
    if @current_results == @answer
      win
    else
      lose
    end
  end

  def win
    @score += 1
    win_message(@score)
    reset
    play
  end

  def lose
    lose_message(@answer, @score)
  end

  def reset
    @answer = NewGame.random_word
    @guesses_left = 6
    @current_results = Array.new(@answer.length, '_')
    @letters_guessed = []
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
    dict = open('./lib/dictionary.txt', 'r').readlines
    dict.keep_if { |word| word.length.between?(6, 12) }
    dict.sample.chomp.split('')
  end

  def play
    loop do
      print_board(@current_results, @letters_guessed)
      puts 'Guess a letter or type "save" to save current spot.'
      curr_guess = guess_letter
      return if curr_guess == 'save'

      compare_guess(curr_guess)
      break if @answer == @current_results || @guesses_left.zero?
    end
    end_result
  end
end
