class SessionsController < ApplicationController

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
      redirect_to root_path
      flash[:success] = "Login successfully!!"
    else
      render "new"
      flash.now[:danger] = "Invalid name/password combination"
    end
  end

# DELETE /logout
  def destroy
    log_out
    redirect_to root_path
  end
  
end
