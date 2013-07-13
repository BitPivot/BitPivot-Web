class BlogController < ApplicationController

  def show_post
    post = "/public/static/blog/posts/#{params[:year]}-#{params[:month]}-#{params[:day]}#{params[:title]}.html"
    render file: post, layout: false
  end

end
