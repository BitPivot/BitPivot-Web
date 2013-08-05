require 'ostruct'

class AdminController < ApplicationController
  layout 'admin'

  before_action :load_user
  before_action :load_new_comments

  def index
  end

  def login
    user ||= User.find_by(email: params[:login_user][:login_email])

    if user.nil?
      @login_email_placeholder = 'Nope'
      @login_email_class = @login_email_placeholder.nil? ? '' : 'error'
    else
      if user.authenticate(params[:login_user][:login_password])
        session[:user] = user.id
        @user = user
      else
        @login_password_placeholder = 'Nope'
        @login_password_class = @login_password_placeholder.nil? ? '' : 'error'
      end
    end
    redirect_to '/admin'
  end

  def logout
    @user = nil
    session[:user] = nil
    redirect_to '/admin'
  end

  def approve_comment
    if params[:id]
      comment = BlogPostComment.find(params[:id])
      comment.approved = true
      comment.save
    end
    redirect_to '/admin'
  end

  def delete_comment
    if params[:id]
      comment = BlogPostComment.find(params[:id])
      comment.delete
    end
    redirect_to '/admin'
  end

  private

  def load_user
    if session[:user]
      @user ||= User.find(session[:user])
    end
  end

  def load_new_comments
    @unapproved_comments = {
        'Matthew McMillion' => [],
        'Rob Hencke' => [],
        'Sean Kennedy' => []
    }
    @unapproved_comments.keys.each do |author|
      BlogPost.where(author: author).to_a.each do |post|
        post.blog_post_comments.select { |c| c.approved == false }.each do |unapproved|
          @unapproved_comments[author] << unapproved
        end
      end
    end
  end
end
