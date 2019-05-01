class UsersController < ApplicationController
  before_action :confirm_current_user, only: [:edit, :update]
  before_action :already_login, only: :new
  # GET /users/1
  def show
    @user = User.find_by(id: params[:id])
    if !@user
      flash[:danger] = "No user page"
      redirect_to root_path
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

    respond_to do |f|
      if @user.save
        log_in @user
        flash[:success] = "User was successfully created"
        f.html { redirect_to @user }
      else
        flash.now[:danger] = "Failed to be created"
        f.html { render :new }
      end
    end
  end

  # PATCH/PUT /users/1
  def update
    @user = current_user
    respond_to do |f|
      if @user.update_attributes(user_params)
        flash[:success] = "User was successfully updated"
        f.html { redirect_to @user }
      else
        flash.now[:danger] = "Failed to be updated"
        f.html { render :edit }
      end
    end
  end

  # DELETE /users/1
  # def destroy
  #   @user.destroy
  #   respond_to do |f|
  #     f.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
  #   end
  # end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:user_name, :password)
    end
end
