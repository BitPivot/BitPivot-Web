class AdminController < ApplicationController
  layout 'admin'

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
    render :index
  end

  def logout
    session[:user] = nil
    render :index
  end
end
