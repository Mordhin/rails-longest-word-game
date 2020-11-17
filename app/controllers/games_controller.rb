require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = generate_grid(10)
  end

  def score
    

    def run_game(attempt, grid)
      url = "https://wagon-dictionary.herokuapp.com/#{attempt}"
      word_info_serialized = open(url).read
      word_info = JSON.parse(word_info_serialized)
      result = {message: "Well Done! #{attempt.upcase} is an english word!"}
    
      true_word(attempt, result, word_info)
      in_the_grid(attempt, result, grid)
      result[:message]
    end
    
    
    def true_word(attempt, result, word_info)
      if word_info["found"] == false
        result[:message] = "#{attempt.upcase} is not an english word!"
        return result[:message]
      end
    end
    
    def in_the_grid(attempt, result, grid)
      attempt.upcase.chars.each do |letter|
        next if attempt.upcase.chars.count(letter) <= grid.count(letter)
        result[:message] = "#{attempt.upcase} is not in the grid!"
        return result[:message]
      end
    end
  end

  def generate_grid(grid_size)
    array = Array.new(grid_size)
    array.map! { ('A'..'Z').to_a.sample }
  end
  helper_method :run_game
end
