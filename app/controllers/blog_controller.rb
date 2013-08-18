require 'cgi'
require 'ostruct'

class BlogController < ApplicationController
  include ERB::Util
  include ErrorsHelper

  before_action :before

  layout 'blog'

  def index
    @page_posts = []
    BlogPost.all.each_with_index do |p, i|
      if i >= (@page - 1) * @page_size && i < ((@page-1) * @page_size) + @page_size
        @page_posts.push(p)
      end
    end
    unescape_posts(@page_posts)
  end

  def view_post
    if @action_params_valid
      id = Integer(params[:id])
      post = unescape_post(BlogPost.find(id))
      render locals: { post: post, hide_comments: false }
      return
    end
    post_not_found
  end

  def author
    if @action_params_valid
      @page_posts = unescape_posts(BlogPost.where(author: to_full_author_name(params[:author])))
      render :index
      return
    end
    post_not_found
  end

  def year
    if @action_params_valid
      year = Integer(params[:year])
      @page_posts = unescape_posts(BlogPost.where(year: year))
      render :index
      return
    end
    post_not_found
  end

  def month
    if @action_params_valid
      year = Integer(params[:year])
      month = Integer(params[:month])
      @page_posts = unescape_posts(BlogPost.where(year: year, month: month))
      render :index
      return
    end
    post_not_found
  end

  def day
    if @action_params_valid
      year = Integer(params[:year])
      month = Integer(params[:month])
      day = Integer(params[:day])
      @page_posts = unescape_posts(BlogPost.where(year: year, month: month, day: day))
      render :index
      return
    end
    post_not_found
  end

  def create_comment
    id = Integer(params[:comment][:post_id])
    post = BlogPost.find(id)

    # TODO: don't use mass assignment
    comment = BlogPostComment.new(params[:comment])
    unless comment.valid?
      # get hash with full error messages
      flash_error_placeholders(comment, [:author, :email, :content]).each do |k,v|
        flash[k] = v
      end
      # jump to create comment to show errors
      redirect_to "#{post.post_url}#create-comment"
      return
    end
    post.blog_post_comments << comment
    post.save
    begin
      CommentMailer.new_comment_notification(comment).deliver
    rescue
    ensure
      render template: 'blog/comment_confirmation', locals: {
        post: unescape_post(post),
        comment: comment,
        respond_to_id: nil
      }
    end
  end

  def respond_to_comment
    post = @posts.select { |p| p.id == Integer(params[:post_id]) }.shift
    render template: 'blog/view_post', locals: { post: post, respond_to_id: Integer(params[:respond_to_id]), hide_comments: false }
  end



  private

  def before
    @max_comment_depth = APP_CONFIG.max_comment_reply_depth
    @total_posts = BlogPost.count
    @page = params[:page].nil? ? 1 : Integer(params[:page])
    @page_size = APP_CONFIG.blog_posts_per_page
    validate_params
  end

  def unescape_posts(posts)
    posts.each do |p|
      unescape_post(p)
    end
  end

  def unescape_post(post)
    post.body = CGI.unescapeHTML(post.body)
    post.blog_post_comments.each do |c|
      c.content = CGI.unescapeHTML(c.content)
    end
    post
  end

  def validate_params
    valid = true
    case params[:action]
    when 'view_post'
      valid = params_present? [:id]
      valid = BlogPost.exists?(params[:id]) if valid
    when 'author'
      valid = params_present? [:author]
      valid = to_full_author_name params[:author] != ''
    when 'year'
      param_keys = [:year]
      valid = false unless params_present? param_keys
      param_keys.each do |key| valid = false unless params[key].is_i? end
    when 'month'
      param_keys = [:year,:month]
      valid = false unless params_present? param_keys
      param_keys.each do |key| valid = false unless params[key].is_i? end
    when 'day'
      param_keys = [:year,:month,:day]
      valid = false unless params_present? param_keys
      param_keys.each do |key| valid = false unless params[key].is_i? end
    when 'create_comment'
      param_keys = [:id]
      valid = false unless params_present? param_keys
    when 'respond_to_comment'
      param_keys = [:post_id, :respond_to_id]
      valid = false unless params_present? params_keys
    end
    @action_params_valid = valid
  end

  def params_present?(param_keys)
    present = true
    param_keys.each do |key| present = false if params[key].nil? end
    present
  end

  def to_full_author_name(first_name)
    name = ''
    case first_name
      when 'sean'
        name = 'Sean Kennedy'
      when 'rob'
        name = 'Robert Hencke'
      when 'matthew'
        name = 'Matthew McMillion'
    end
    name
  end

  def post_not_found
    render template: 'blog/post_not_found'
  end
end
