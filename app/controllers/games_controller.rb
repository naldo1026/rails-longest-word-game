require 'open-uri'

class GamesController < ApplicationController

  def new
   $letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    @word = params[:game]
    link?(@word, $letters)
    @answer = checking_word?(@word)
    if link?(@word, $letters) && @answer
      @answer = "well done"
    else
      @answer = "incorrect"
    end
  end

private

  def link?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end

  def checking_word?(element)
    url = open("https://wagon-dictionary.herokuapp.com/#{element}")
    json = JSON.parse(url.read)
    if json['found'] == true
      @answer = "well done"
    else
      @answer = "incorrect"
    end
  end
end