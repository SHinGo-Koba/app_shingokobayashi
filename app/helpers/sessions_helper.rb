module SessionsHelper

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def confirm_current_user
    user = User.find_by(id: params[:id])
    if !(user && (user == current_user))
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
  
  def confirm_login
    unless logged_in?
      redirect_to login_path
      flash[:notice] = "Please login"
    end
  end
  
  def log_out
    reset_session
    @current_user = nil
  end

end
