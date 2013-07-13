class BlogController < ApplicationController

  def show_post
    filename = "_#{params[:year]}-#{params[:month]}-#{params[:day]}-#{params[:title]}.html.erb"
    puts "Rendering #{filename}"
    render "blog/posts/#{filename}"
  end

end
