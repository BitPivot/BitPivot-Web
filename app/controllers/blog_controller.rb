class BlogController < ApplicationController

  layout 'blog'

  def view
    render "blog/posts/#{params[:year]}-#{params[:month]}-#{params[:day]}#{params[:title]}"
  end

end