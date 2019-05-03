class UsersController < ApplicationController
  before_action :confirm_login, only: [:show, :edit, :update]
  before_action :confirm_current_user, only: [:edit, :update]
  before_action :already_login, only: :new

  # GET /users/1
  def show
    @user = User.find_by(id: params[:id])
    if !@user
      no_page_("user") #from shared helper
    else
      @works_as_org = @user.organizer.try(:projects)
      @works_as_mem = @user.tasks
    end
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    @user = current_user
  end

  # POST /users
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "User was successfully created"
      redirect_to @user
    else
      flash.now[:danger] = "Failed to be created"
      render :new 
    end
  end

  # PATCH/PUT /users/1
  def update
    @user = current_user
    if @user.update_attributes(user_params)
      flash[:success] = "User was successfully updated"
      redirect_to @user
    else
      flash.now[:danger] = "Failed to be updated"
      render :edit
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:user_name, :password, :password_confirmation)
    end
    
end
