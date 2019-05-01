class HomeController < ApplicationController
  def index
    if logged_in?
      redirect_to projects_path
    end
  end
end
