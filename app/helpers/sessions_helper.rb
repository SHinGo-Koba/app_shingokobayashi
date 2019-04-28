module SessionsHelper

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def current_user?
    user = User.find_by(id: params[:id])
    if !(user == current_user)
      redirect_to root_path
      flash[:danger] = "Invalid access"
    end
  end

  def log_in(user)
    session[:user_id] = user.id
    current_user
  end

  def logged_in?
    !current_user.nil?
  end
  
  def log_out
    reset_session
    @current_user = nil
  end

end
