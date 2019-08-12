require 'open-uri'

class GithubController < ApplicationController
  def search
    if params[:q]
      url = "https://api.github.com/search/repositories?q=#{params[:q]}"
      @response = JSON.parse open(url).read
    end
  end
end
