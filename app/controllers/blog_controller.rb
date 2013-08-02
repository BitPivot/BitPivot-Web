require 'cgi'
require 'ostruct'

class BlogController < ApplicationController
  before_action :get_posts

  layout 'blog'

  def index
    @posts.each_with_index do |p, i|
      if i >= (@page - 1) * @page_size && i < ((@page-1) * @page_size) + @page_size
        @page_posts.push(p)
      end
    end
  end

  def author
    author = params[:author]
    # @page_posts.select! { |post| post. }
    render :index
  end

  def year
    year = Integer(params[:year])

  end

  def month
    year = Integer(params[:year])
    month = Integer(params[:month])
  end

  def day
    year = Integer(params[:year])
    month = Integer(params[:month])
    day = Integer(params[:day])
  end

  #def show
  #  render "blog/posts/#{params[:year]}-#{params[:month]}-#{params[:day]}#{params[:title]}"
  #end


  private

  def get_posts
    @page_size = 5
    @page = params[:page].nil? ? 1 : Integer(params[:page])
    @page_posts = []
    @posts = BlogPost.all
    @posts.each do |p|
      p.body = CGI.unescapeHTML(p.body)
    end
  end

end