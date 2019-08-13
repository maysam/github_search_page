require 'open-uri'

class GithubController < ApplicationController
  def search
    if @query = params[:q]
      @per_page = 20
      @page = params[:page].to_i || 1

      @url = "https://api.github.com/search/repositories?q=#{@query}&per_page=#{@per_page}&page=#{@page}"
      Rails.logger.info "url = #{@url}"
      @response = JSON.parse open(@url).read
      total = @response['total_count']
      @pages = (total / @per_page).ceil
      @max_available_pages = [1000/@per_page, @pages].min
      @pagination_pages = (1..@max_available_pages).map { |i| i }.select{|i|
        # message: "Only the first 1000 search results are available",
        (i-@page).abs < 3 || i <= 3 || i + 3 > @max_available_pages
      }
      @prev = [@page - 1 , 1].max
      @next = [@page + 1 , @max_available_pages].min
    end
  end
end
