class UsersController < ApplicationController
  skip_before_action :require_login, except: [:current_user] 
  
  def index
    @users = User.all
  end

  def show
    @user = current_user

    if @user.nil?
      redirect_to users_path
      return
    end
  end

  def login_form
    @user = User.new
  end

  def login
    username = params[:user][:username]
    user = User.find_by(username: username)
    if user
      session[:user_id] = user.id
      flash[:success] = "Successfully logged in as returning user #{username}"
    else
      user = User.create(username: username)
      session[:user_id] = user.id
      flash[:success] = "Successfully logged in as new user #{username}"
    end

    redirect_to root_path
    return
  end

  def logout
    session[:user_id] = nil
    flash[:success] = "Successfully logged out"
    redirect_to root_path
    return
  end

  def current
    @current_user = current_user
    unless @current_user
      flash[:warning] = "You must be logged in to see this page"
      redirect_to root_path
      return
    end
  end
end
