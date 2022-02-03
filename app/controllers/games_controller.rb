require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @grid = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    @word = params[:word]

    if included?(@word, @grid) == false
      @start = "Sorry but "
      @end = " can't be build out of "
    elsif english_word?(@word) == false
      @start = "Sorry but "
      @end = " doesn't seem to be a valid English word..."
    elsif english_word?(@word) && included?(@word, @grid)
      @start = "Congratulations! "
      @end = " is a valid English word!"
    end
  end

  def english_word?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    data = JSON.parse(URI.open(url).read)
    data["found"]
  end

def included?(word, grid)
  word_test = word.chars

  word_test.all? do |letter|
    word_test.count(letter) <= grid.count(letter)
  end
end
end
