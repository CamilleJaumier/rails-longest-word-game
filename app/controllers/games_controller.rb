require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(10)
  end

  def score
    @user_proposition = params[:user_proposition]
    @letters = params[:letters]
    @letters_proposition = @user_proposition.split(//)

    @result = @letters_proposition.all? do |letter|
      @letters_proposition.count(letter) <= @letters.count(letter)
    end

    url = "https://wagon-dictionary.herokuapp.com/#{@user_proposition}"
    user_serialized = URI.open(url).read
    user = JSON.parse(user_serialized)

    if @result == false
      @answer = "Sorry but #{@user_proposition} can't be built out of #{@letters}"
    elsif user['found'] == false
      @answer = "Sorry but #{@user_proposition} does not seem to be an English word..."
    else
      @answer = "Congratulations ! #{@user_proposition} is a valid English word !"
    end
  end
end
