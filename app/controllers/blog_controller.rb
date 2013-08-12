require 'cgi'
require 'ostruct'

class BlogController < ApplicationController
  include ERB::Util
  include ErrorsHelper

  before_action :get_max_comment_depth
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
    file_name = params[:file_name]
    post = @posts.select { |p| p.file_name == "#{params[:file_name]}.html.erb" }.shift
    if post.nil?
      render template: 'blog/post_not_found.html.erb', locals: { file_name: file_name }
      return
    end
    render locals: { post: post, hide_comments: false }
  end

  def author
    @page_posts = @posts.select { |p| p.author.slice(0..(p.author.rindex(' ')-1)).downcase == params[:author] }
    render :index
  end

  def year
    year = Integer(params[:year])
    @page_posts = @posts.select { |p| p.year == year }
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
    @page_posts = @posts.select { |p| p.year == year && p.month == month && p.day == day }
    render :index
  end

  def create_comment
    post = BlogPost.find_by(file_name: params[:comment][:post_file_name])
    comment = BlogPostComment.new(params[:comment])
    if comment.valid?
      post.blog_post_comments << comment
      post.save
      CommentMailer.new_comment_notification(comment).deliver
      render template: 'blog/comment_confirmation.html.erb', locals: {
          post: unescape_post(post),
          comment: comment,
          respond_to_id: nil
      }
      return
    end
    # get hash with full error messages
    flash_error_placeholders(comment, [:author, :email, :content]).each do |k,v|
      flash[k] = v
    end

    # jump to create comment to show errors
    redirect_to "#{post.post_url}#create-comment"
  end

  def respond_to_comment
    post = @posts.select { |p| p.id == Integer(params[:post_id]) }.shift
    render template: 'blog/view_post', locals: { post: post, respond_to_id: Integer(params[:respond_to_id]) }
  end


  private

  def get_posts
    @page_posts = []
    @page_size = APP_CONFIG.blog_posts_per_page
    @page = params[:page].nil? ? 1 : Integer(params[:page])
    @posts = BlogPost.all
    @posts.each do |p|
      unescape_post(p)
    end
  end

  def get_max_comment_depth
    @max_comment_depth = APP_CONFIG.max_comment_reply_depth
  end

  def unescape_post(post)
    post.body = CGI.unescapeHTML(post.body)
    post.blog_post_comments.each do |c|
      c.content = CGI.unescapeHTML(c.content)
    end
    post
  end

end
