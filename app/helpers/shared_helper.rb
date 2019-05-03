module SharedHelper

  def no_page_(obj)
    flash[:warning] = "No #{obj} page"
    redirect_to root_path
  end

end