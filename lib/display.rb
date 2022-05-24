module Display
  def print_board(current_results, letters_guessed)
    puts <<~BOARD
      #{'='*20}
      Status || Letters Guessed
      
      #{current_results.join(' ')} || #{letters_guessed.join(', ')}
      #{'='*20}
    BOARD
  end

  def lose_message(answer, sore)
    puts "Sorry, you couldn't guess the word in time.\n"\
      "The word was #{answer.join('')}\n"\
      "Your final score was #{@score}.\n"\
  end

  def win_message(score)
    puts "Nice! You guessed the word!\n" \
      "You now have #{score} points!"
  end
end


