require 'cgi'
require 'ostruct'

class BlogController < ApplicationController
  include ERB::Util
  before_action :get_posts

  layout 'blog'

  def index
    @posts.each_with_index do |p, i|
      if i >= (@page - 1) * @page_size && i < ((@page-1) * @page_size) + @page_size
        @page_posts.push(p)
      end
    end
  end

  def view_post
    post = @posts.select { |p| p.file_name ==  "#{params[:file_name]}.html.erb" }.shift
    render locals: { post: post }
  end

  def author
    @page_posts = @posts.select { |p| p.author.slice(0..(p.author.rindex(' ')-1)).downcase == params[:author]}
    render :index
  end

  def year
    year =  Integer(params[:year])
    @page_posts = @posts.select { |p| p.year == year}
    render :index
  end

  def month
    year = Integer(params[:year])
    month = Integer(params[:month])
    @page_posts = @posts.select { |p| p.year == year && p.month == month }
    render :index
  end

  def day
    year = Integer(params[:year])
    month = Integer(params[:month])
    day = Integer(params[:day])
    @page_posts = @posts.select { |p| p.year == year && p.month == month && p.day == day}
    render :index
  end

  def create_comment
    post = BlogPost.find_by(file_name: params[:comment][:post_file_name])
    comment = BlogPostComment.new
    comment.author = params[:comment][:author]
    comment.email = params[:comment][:email]
    comment.content = params[:comment][:content]
    post.blog_post_comments << comment
    post.save
    redirect_to "/blog/posts/#{post.file_name.slice(0..(post.file_name.index('.')-1))}"
  end



  private

  def get_posts
    @page_size = 5
    @page = params[:page].nil? ? 1 : Integer(params[:page])
    @page_posts = []
    @posts = BlogPost.all
    @posts.each do |p|
      p.body = CGI.unescapeHTML(p.body)
      p.blog_post_comments.each do |c|
        c.content = CGI.unescapeHTML(c.content)
      end
    end
  end

end