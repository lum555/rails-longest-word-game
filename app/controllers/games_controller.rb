require 'open-uri'
# frozen_string_literal: true
# thanks rubocop
class GamesController < ApplicationController
  # frozen_string_literal: true
  ALPHABET = [('A'..'Z')].map(&:to_a).flatten

  def new
    @letters = []
    9.times do
      @letters << ALPHABET.sample
    end
  end

  def verify_word(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    url['found'] == true
  end

  def verify_grid(word, letters)
    letters = letters.gsub(/\s+/, '').split('')
    word = word.split('')
    result = word - letters
    raise
    result.join.empty?
  end

  def score
    # url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
    @result = if verify_grid(params[:word], params[:letters]) == false
                "Sorry, but #{params[:word]} can't be built out of #{params[:letters]}"
              elsif verify_word(params[:word]) == false
                "Sorry, but #{params[:word]} does not seem to be a valid English word..."
              end
  end
end
