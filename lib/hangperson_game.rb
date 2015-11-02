class HangpersonGame
  attr_accessor :word, :guesses, :wrong_guesses
  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  def initialize word 
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  def guess input_letter
    raise ArgumentError.new("Input must be a character") unless /^[A-Z]$/i =~ input_letter
    
    letter = input_letter.downcase
    
    if @word.include? letter
      add_guess letter, @guesses
    else
      add_guess letter, @wrong_guesses
    end
  end

  def add_guess letter, guess
    already_has_letter = guess.include? letter

    guess << letter unless already_has_letter
    !already_has_letter
  end
  
  def word_with_guesses
    @word.gsub(Regexp.new("[^-#{@guesses}]"), '-')
  end

  def check_win_or_lose
    return :win if @word == word_with_guesses #!word_with_guesses.include? '-'
    return :lose if @wrong_guesses.length == 7
    :play
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end
