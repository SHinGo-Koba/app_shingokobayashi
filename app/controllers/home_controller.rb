class HomeController < ApplicationController
  before_action :confirm_login, only: :search

  def index
    if logged_in?
      redirect_to projects_path
    end
  end
  
  def search
    if params[:user_name]
      @user = User.find_by(user_name: params[:user_name])
      if @user
        redirect_to @user
      else
        flash[:warning] = "No user or spelling not matched"
        redirect_to projects_path
      end
    else
      flash[:warning] = "Fill in any user name"
      redirect_to projects_path
    end
  end
  
end
