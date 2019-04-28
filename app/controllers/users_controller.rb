class UsersController < ApplicationController

  # GET /users/1
  def show
    @user = User.find_by(id: params[:id])
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  def create
    @user = User.new(user_params)

    respond_to do |f|
      if @user.save
        f.html { redirect_to @user, success: 'User was successfully created.' }
      else
        f.html { render :new }
      end
    end
  end

  # PATCH/PUT /users/1
  def update
    respond_to do |f|
      if @user.update(user_params)
        f.html { redirect_to @user, success: 'User was successfully updated.' }
      else
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
