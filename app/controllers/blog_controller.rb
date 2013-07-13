class BlogController < ApplicationController

  def show_post
    render "blog/posts/#{params[:year]}-#{params[:month]}-#{params[:day]}#{params[:title]}"
  end

end
