class SessionsController < ApplicationController
# Setting callbacks below to avoid user doing not necessary process
  before_action :already_login, only: [:new, :create]
  before_action :already_logout, only: [:destroy]
  
  
# GET /login
  def new
    @user = User.new
  end

# POST /login
  def create
    @user = User.find_by(user_name: params[:session][:user_name])
    if @user && @user.authenticate(params[:session][:password])
      reset_session
      log_in @user
      flash[:success] = "Login successfully!!"
      redirect_to root_path
    else
      flash.now[:danger] = "Invalid name/password combination"
      render "sessions/new"
    end
  end

# DELETE /logout
  def destroy
      log_out
      flash[:success] = "Logout!!"
      redirect_to root_path
  end
  
end
